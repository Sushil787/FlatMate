import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../notify/digests.dart';
import '../notify/notifier.dart';
import 'planner.dart';

/// How long before a Turn ends its Mate is reminded.
const reminderLead = Duration(hours: 3);

/// How late the evening push may run (after a restart, say) and still go
/// out; any later and "3 hours left" would be wrong.
const _reminderLate = Duration(minutes: 30);

/// Moves Chores through their Turns: creates them, reacts to Away and
/// leaving Mates, and handles the scheduled start, reminder and end.
class TurnService {
  // ---------------------------------------------------------------------------
  // Planning

  /// [extraAway] adds an Away that isn't saved, for the Away preview.
  static Future<PlannerState> plannerState(
    Session session,
    Flat flat,
    Chore chore, {
    AwaySpan? extraAway,
  }) async {
    final mates = await activeMates(session, flat.id!);
    final aways = await Away.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!),
    );
    final debts = await SwapDebt.db.find(
      session,
      where: (t) => t.choreId.equals(chore.id!),
      orderBy: (t) => t.createdAt,
    );
    return PlannerState(
      rotation: chore.rotation,
      awayRule: flat.awayRule,
      activeMateIds: mates.map((m) => m.id!).toSet(),
      aways: [
        for (final a in aways) AwaySpan(a.mateId, a.startDay, a.lastDay),
        ?extraAway,
      ],
      debts: [
        for (final d in debts) Debt(d.debtorMateId, d.creditorMateId),
      ],
    );
  }

  /// Creates the Chore's first Turn. Called when the Admin creates a Chore.
  static Future<void> startChore(
    Session session,
    Flat flat,
    Chore chore,
  ) async {
    // A start day already over rolls forward to the next day in the rhythm.
    final today = Day.today(flat.timezone);
    var day = chore.startDay;
    while (day.isBefore(today)) {
      day = day.add(chore.period);
    }
    await _createNextTurn(session, flat, chore, day);
  }

  static Future<Turn?> _createNextTurn(
    Session session,
    Flat flat,
    Chore chore,
    DateTime day,
  ) async {
    final state = await plannerState(session, flat, chore);
    final plan = planNextTurn(state, chore.rotationIndex, day);
    if (plan == null) {
      session.log('Chore ${chore.name} has nobody left in its rotation.');
      return null;
    }

    final turn = await session.db.transaction((tx) async {
      chore.rotationIndex = plan.rotationIndex;
      await Chore.db.updateRow(session, chore, transaction: tx);

      final repaid = plan.debtRepaid;
      if (repaid != null) {
        final row = await SwapDebt.db.findFirstRow(
          session,
          where: (t) =>
              t.choreId.equals(chore.id!) &
              t.debtorMateId.equals(repaid.debtorMateId) &
              t.creditorMateId.equals(repaid.creditorMateId),
          orderBy: (t) => t.createdAt,
          transaction: tx,
        );
        if (row != null) {
          await SwapDebt.db.deleteRow(session, row, transaction: tx);
        }
      }
      final created = plan.debtCreated;
      if (created != null) {
        await SwapDebt.db.insertRow(
          session,
          SwapDebt(
            choreId: chore.id!,
            debtorMateId: created.debtorMateId,
            creditorMateId: created.creditorMateId,
          ),
          transaction: tx,
        );
      }

      return Turn.db.insertRow(
        session,
        Turn(
          flatId: flat.id!,
          choreId: chore.id!,
          mateId: plan.mateId,
          coveringForMateId: plan.coveringForMateId,
          day: plan.day,
          lastDay: plan.lastDay,
          status: TurnStatus.active,
        ),
        transaction: tx,
      );
    });

    await _schedule(session, flat, turn);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return turn;
  }

  /// Projects upcoming Turns for every Chore in the Flat up to the day
  /// [until], starting after each Chore's latest real Turn. Projected Turns
  /// have no id.
  static Future<List<Turn>> projectTurns(
    Session session,
    Flat flat,
    DateTime until, {
    AwaySpan? extraAway,
  }) async {
    final chores = await Chore.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!) & t.archived.equals(false),
    );
    final projected = <Turn>[];
    for (final chore in chores) {
      final latest = await Turn.db.findFirstRow(
        session,
        where: (t) => t.choreId.equals(chore.id!),
        orderBy: (t) => t.day.desc(),
      );
      if (latest == null) continue;
      final state = await plannerState(
        session,
        flat,
        chore,
        extraAway: extraAway,
      );
      var index = chore.rotationIndex;
      var day = nextTurnDay(latest.day, latest.lastDay, chore.period);
      for (var i = 0; i < 200 && !day.isAfter(until); i++) {
        final plan = planNextTurn(state, index, day);
        if (plan == null) break;
        projected.add(
          Turn(
            flatId: flat.id!,
            choreId: chore.id!,
            mateId: plan.mateId,
            coveringForMateId: plan.coveringForMateId,
            day: plan.day,
            lastDay: plan.lastDay,
            status: TurnStatus.active,
          ),
        );
        index = plan.rotationIndex;
        day = nextTurnDay(plan.day, plan.lastDay, chore.period);
      }
    }
    return projected;
  }

  // ---------------------------------------------------------------------------
  // Scheduling

  static String _id(UuidValue turnId, String what) => 'turn-$turnId-$what';

  /// When the Turn starts and ends: the Flat's local midnights.
  static ({DateTime start, DateTime end}) instants(Flat flat, Turn turn) => (
    start: Day.start(flat.timezone, turn.day),
    end: Day.end(flat.timezone, turn.lastDay),
  );

  /// When the morning summary for Turns starting on [day] goes out.
  static DateTime morningOf(Flat flat, DateTime day) =>
      Day.at(flat.timezone, day, flat.morningSummaryAt);

  /// Schedules the Turn's morning summary, reminder and end. A Turn that
  /// lands after its morning summary went out is announced right away,
  /// unless [announce] is false.
  static Future<void> _schedule(
    Session session,
    Flat flat,
    Turn turn, {
    bool announce = true,
  }) async {
    final calls = session.serverpod.futureCalls;
    await _cancel(session, turn.id!);

    final morning = morningOf(flat, turn.day);
    if (morning.isAfter(DateTime.now().toUtc())) {
      await _scheduleMorning(session, turn, morning);
    } else if (announce) {
      await _announce(session, flat, turn);
    }

    await _scheduleReminder(session, flat, turn);

    await calls
        .callAtTime(instants(flat, turn).end, identifier: _id(turn.id!, 'end'))
        .turnCalls
        .ended(turn.id!);
  }

  static Future<void> _scheduleMorning(
    Session session,
    Turn turn,
    DateTime at,
  ) => session.serverpod.futureCalls
      .callAtTime(at, identifier: _id(turn.id!, 'start'))
      .turnCalls
      .started(turn.id!);

  /// Moves the morning summary of Turns still waiting for theirs to the
  /// Flat's new time; [wasAt] is the old one. Today's summary stays put if
  /// the new time has already passed.
  static Future<void> moveMorningSummary(
    Session session,
    Flat flat,
    int wasAt,
  ) async {
    final now = DateTime.now().toUtc();
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          t.status.equals(TurnStatus.active) &
          (t.day >= Day.today(flat.timezone)),
    );
    for (final turn in turns) {
      final next = morningOf(flat, turn.day);
      if (!Day.at(flat.timezone, turn.day, wasAt).isAfter(now) ||
          !next.isAfter(now)) {
        continue;
      }
      await session.serverpod.futureCalls.cancel(_id(turn.id!, 'start'));
      await _scheduleMorning(session, turn, next);
    }
  }

  /// Schedules the reminder, unless its time has passed or comes before the
  /// Turn starts.
  static Future<void> _scheduleReminder(
    Session session,
    Flat flat,
    Turn turn,
  ) async {
    final (:start, :end) = instants(flat, turn);
    final remindAt = end.subtract(reminderLead);
    if (remindAt.isAfter(DateTime.now().toUtc()) && remindAt.isAfter(start)) {
      await session.serverpod.futureCalls
          .callAtTime(remindAt, identifier: _id(turn.id!, 'reminder'))
          .turnCalls
          .reminder(turn.id!);
    }
  }

  static Future<void> _cancel(Session session, UuidValue turnId) async {
    final calls = session.serverpod.futureCalls;
    for (final what in ['start', 'reminder', 'end']) {
      await calls.cancel(_id(turnId, what));
    }
  }

  // ---------------------------------------------------------------------------
  // Scheduled handlers

  /// The Turn with its Chore and Flat, or null if any is gone.
  static Future<({Turn turn, Chore chore, Flat flat})?> _load(
    Session session,
    UuidValue turnId,
  ) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null) return null;
    final chore = await Chore.db.findById(session, turn.choreId);
    final flat = await Flat.db.findById(session, turn.flatId);
    if (chore == null || flat == null) return null;
    return (turn: turn, chore: chore, flat: flat);
  }

  /// Tells a Turn's Mate it's theirs, when it lands on them after the
  /// morning summary.
  static Future<void> _announce(Session session, Flat flat, Turn turn) async {
    final chore = await Chore.db.findById(session, turn.choreId);
    final coveringFor = turn.coveringForMateId;
    final other = coveringFor == null
        ? null
        : await Mate.db.findById(session, coveringFor);
    final push = turnPush(
      chore?.name ?? 'A chore',
      coveringFor: coveringFor == null ? null : other?.displayName ?? 'a mate',
      due: _dueIn(instants(flat, turn).end),
    );
    await Notifier.toMates(
      session,
      [turn.mateId],
      title: push.title,
      body: push.body,
      kind: NotifyKind.turnStarts,
    );
  }

  /// The Flat's open Turns matching [where] in id order, or nothing unless
  /// [turnId] is the first. Every one of them has a call at the same time,
  /// so this lets one call speak for all of them.
  static Future<List<Turn>> _ifFirst(
    Session session,
    Flat flat,
    UuidValue turnId,
    WhereExpressionBuilder<TurnTable> where,
  ) async {
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          t.status.equals(TurnStatus.active) &
          where(t),
      orderBy: (t) => t.id,
    );
    return turns.firstOrNull?.id == turnId ? turns : const [];
  }

  static Future<Map<UuidValue, String>> _choreNames(
    Session session,
    Iterable<Turn> turns,
  ) async => {
    for (final c in await Chore.db.find(
      session,
      where: (t) => t.id.inSet(turns.map((t) => t.choreId).toSet()),
    ))
      c.id!: c.name,
  };

  /// The morning summary: each Mate gets one push listing their Turns that
  /// start today.
  static Future<void> onTurnStarted(Session session, UuidValue turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null) return;
    final flat = loaded.flat;
    final today = Day.today(flat.timezone);
    final turns = await _ifFirst(
      session,
      flat,
      turnId,
      (t) => t.day.equals(today),
    );
    if (turns.isEmpty) return;

    final chores = await _choreNames(session, turns);
    // Left Mates too: someone may be covering for one.
    final names = {
      for (final m in await Mate.db.find(
        session,
        where: (t) => t.flatId.equals(flat.id!),
      ))
        m.id!: m.displayName,
    };
    final byMate = <UuidValue, List<Turn>>{};
    for (final t in turns) {
      (byMate[t.mateId] ??= []).add(t);
    }
    for (final MapEntry(key: mateId, value: mine) in byMate.entries) {
      final push = morningPush(
        [
          for (final t in mine)
            (
              chore: chores[t.choreId] ?? 'A chore',
              coveringFor: t.coveringForMateId == null
                  ? null
                  : names[t.coveringForMateId] ?? 'a mate',
            ),
        ],
        due: _dueIn(instants(flat, mine.first).end),
      );
      await Notifier.toMates(
        session,
        [mateId],
        title: push.title,
        body: push.body,
        kind: NotifyKind.turnStarts,
      );
    }
  }

  /// The evening push, [reminderLead] before the day ends: each Mate gets
  /// one push with their own Turns not Done yet and, unless they are Away,
  /// their Mates' ones.
  static Future<void> onTurnReminder(Session session, UuidValue turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null) return;
    final flat = loaded.flat;
    final today = Day.today(flat.timezone);
    final remindAt = Day.end(flat.timezone, today).subtract(reminderLead);
    if (DateTime.now().toUtc().isAfter(remindAt.add(_reminderLate))) return;
    final turns = await _ifFirst(
      session,
      flat,
      turnId,
      (t) => t.lastDay.equals(today),
    );
    if (turns.isEmpty) return;

    final chores = await _choreNames(session, turns);
    final mates = await activeMates(session, flat.id!);
    final names = {for (final m in mates) m.id!: m.displayName};
    final away = {
      for (final a in await Away.db.find(
        session,
        where: (t) =>
            t.flatId.equals(flat.id!) &
            (t.startDay <= today) &
            (t.lastDay >= today),
      ))
        a.mateId,
    };
    for (final m in mates) {
      final mine = [
        if (m.notifyReminder)
          for (final t in turns.where((t) => t.mateId == m.id))
            chores[t.choreId] ?? 'A chore',
      ];
      final others = <String, List<String>>{};
      if (m.notifyMatesNotDone && !away.contains(m.id)) {
        for (final t in turns.where((t) => t.mateId != m.id)) {
          (others[names[t.mateId] ?? 'Someone'] ??= []).add(
            chores[t.choreId] ?? 'A chore',
          );
        }
      }
      final push = eveningPush(
        mine,
        others,
        hoursLeft: reminderLead.inHours,
      );
      if (push == null) continue;
      await Notifier.toMates(
        session,
        [m.id!],
        title: push.title,
        body: push.body,
      );
    }
  }

  static Future<void> onTurnEnded(Session session, UuidValue turnId) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null) return;
    await _locked(turn.flatId, () => _end(session, turnId));
  }

  /// Ends every Turn in [flat] whose day is over and starts the next ones,
  /// as their scheduled end calls would. Run before reading or changing
  /// Turns, so a late or missed end call can't leave yesterday's Turn open
  /// and today's missing.
  static Future<void> catchUp(Session session, Flat flat) =>
      _locked(flat.id!, () async {
        final today = Day.today(flat.timezone);
        final chores = await Chore.db.find(
          session,
          where: (c) => c.flatId.equals(flat.id!) & c.archived.equals(false),
        );
        for (final chore in chores) {
          // Days the server was down for: hand over once per missed Turn.
          for (var i = 0; i < 1000; i++) {
            final latest = (await Turn.db.find(
              session,
              where: (t) => t.choreId.equals(chore.id!),
              orderBy: (t) => t.day.desc(),
              limit: 1,
            )).firstOrNull;
            if (latest == null || !latest.lastDay.isBefore(today)) break;
            if (!await _end(session, latest.id!)) break;
          }
        }
      });

  /// One Flat's Turn hand-overs at a time, so a scheduled end call and a
  /// [catchUp] can't both start the next Turn.
  // ponytail: in-process only; a Postgres advisory lock if the server ever
  // runs as more than one instance.
  static final _flatLocks = <UuidValue, Future<void>>{};

  static Future<void> _locked(UuidValue flatId, Future<void> Function() body) {
    final run = (_flatLocks[flatId] ?? Future<void>.value())
        .catchError((_) {})
        .then((_) => body());
    _flatLocks[flatId] = run;
    return run.whenComplete(() {
      if (identical(_flatLocks[flatId], run)) _flatLocks.remove(flatId);
    });
  }

  /// Ends Turn [turnId] if its time is up: Missed if not Done, then the
  /// next Turn starts. Returns whether it handed over.
  static Future<bool> _end(Session session, UuidValue turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null) return false;
    final (:turn, :chore, :flat) = loaded;
    // The Turn was extended (Pause) after this call was scheduled.
    final end = instants(flat, turn).end;
    if (end.isAfter(DateTime.now().toUtc().add(_slack))) return false;

    // Only the Chore's latest Turn hands over; guards against a re-run.
    // Each Turn starts after the one before it ends, so later means newer.
    final newer = await Turn.db.count(
      session,
      where: (t) => t.choreId.equals(turn.choreId) & (t.day > turn.day),
    );
    if (newer > 0) return false;

    // No push: the evening one already told the Flat it wasn't Done.
    if (turn.status == TurnStatus.active) {
      turn.status = TurnStatus.missed;
      await Turn.db.updateRow(session, turn);
    }

    if (!chore.archived) {
      final next = await _createNextTurn(
        session,
        flat,
        chore,
        nextTurnDay(turn.day, turn.lastDay, chore.period),
      );
      return next != null;
    }
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return false;
  }

  static const _slack = Duration(seconds: 5);

  // ---------------------------------------------------------------------------
  // Actions

  static Future<Turn> markDone(
    Session session,
    Flat flat,
    Mate me,
    UuidValue turnId,
  ) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null || turn.flatId != me.flatId) fail('Turn not found.');
    if (turn.mateId != me.id) fail('This is not your turn.');
    if (turn.status != TurnStatus.active) fail('This turn is already over.');
    if (turn.day.isAfter(Day.today(flat.timezone))) {
      fail('This turn hasn\'t started yet.');
    }
    final now = DateTime.now().toUtc();

    turn.status = TurnStatus.done;
    turn.doneAt = now;
    await Turn.db.updateRow(session, turn);
    await session.serverpod.futureCalls.cancel(_id(turnId, 'reminder'));
    await broadcast(session, me.flatId, FlatChangeKind.chores);
    return turn;
  }

  /// Takes back a Done while the Turn's day is still going.
  static Future<Turn> undoDone(
    Session session,
    Flat flat,
    Mate me,
    UuidValue turnId,
  ) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null || turn.flatId != me.flatId) fail('Turn not found.');
    if (turn.mateId != me.id) fail('This is not your turn.');
    if (turn.status != TurnStatus.done) fail('This turn isn\'t done.');
    if (turn.lastDay.isBefore(Day.today(flat.timezone))) {
      fail('This turn is already over.');
    }

    turn.status = TurnStatus.active;
    turn.doneAt = null;
    await Turn.db.updateRow(session, turn);
    await _scheduleReminder(session, flat, turn);
    await broadcast(session, me.flatId, FlatChangeKind.chores);
    return turn;
  }

  /// Applies the Flat's Away rule to the Mate's existing Turns that overlap
  /// the new [away].
  static Future<void> applyAway(Session session, Flat flat, Away away) async {
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.mateId.equals(away.mateId) &
          t.status.equals(TurnStatus.active) &
          (t.day <= away.lastDay) &
          (t.lastDay >= away.startDay),
    );
    final today = Day.today(flat.timezone);

    for (final turn in turns) {
      final chore = await Chore.db.findById(session, turn.choreId);
      if (chore == null) continue;
      final state = await plannerState(session, flat, chore);
      final outcome = awayOutcome(
        state,
        chore.rotationIndex,
        turn.mateId,
        turn.day,
        turn.lastDay,
        canMoveStart: turn.day.isAfter(today),
      );
      final cover = outcome.cover;
      if (cover != null) {
        await _reassign(
          session,
          flat,
          chore,
          turn,
          cover,
          owesBack: flat.awayRule == AwayRule.swap,
        );
        continue;
      }
      turn
        ..day = outcome.day
        ..lastDay = outcome.lastDay;
      await Turn.db.updateRow(session, turn);
      await _schedule(session, flat, turn, announce: false);
    }
    if (turns.isNotEmpty) {
      await broadcast(session, flat.id!, FlatChangeKind.chores);
    }
  }

  /// What marking [me] Away for [away] would do to their Turns, without
  /// saving anything: their open Turns as [applyAway] would treat them, then
  /// projected ones, each matched with the Turn in the same place in the
  /// projection with the Away.
  // ponytail: ignores knock-on effects of changing an open Turn on the
  // projected ones after it; good enough for a preview.
  static Future<List<AwayEffect>> previewAway(
    Session session,
    Flat flat,
    Mate me,
    AwaySpan away,
  ) async {
    final today = Day.today(flat.timezone);
    final effects = <AwayEffect>[];
    // Who does the Turn on which days once the Away is in.
    AwayEffect effect(
      UuidValue choreId,
      DateTime day,
      UuidValue mateId,
      DateTime newDay,
      DateTime newLastDay,
    ) {
      final moved = mateId == me.id;
      return AwayEffect(
        choreId: choreId,
        day: day,
        awayRule: flat.awayRule,
        coverMateId: moved ? null : mateId,
        newDay: moved ? newDay : null,
        newLastDay: moved ? newLastDay : null,
      );
    }

    final open = await Turn.db.find(
      session,
      where: (t) =>
          t.mateId.equals(me.id!) &
          t.status.equals(TurnStatus.active) &
          (t.day <= away.lastDay) &
          (t.lastDay >= away.startDay),
      orderBy: (t) => t.day,
    );
    for (final turn in open) {
      final chore = await Chore.db.findById(session, turn.choreId);
      if (chore == null) continue;
      final state = await plannerState(session, flat, chore, extraAway: away);
      final outcome = awayOutcome(
        state,
        chore.rotationIndex,
        me.id!,
        turn.day,
        turn.lastDay,
        canMoveStart: turn.day.isAfter(today),
      );
      effects.add(
        effect(
          chore.id!,
          turn.day,
          outcome.cover?.mateId ?? me.id!,
          outcome.day,
          outcome.lastDay,
        ),
      );
    }

    // Pause can push a Turn back by at most the Away's length.
    final length = Day.between(away.startDay, away.lastDay) + 1;
    final before = await projectTurns(session, flat, away.lastDay);
    final after = await projectTurns(
      session,
      flat,
      Day.add(away.lastDay, length),
      extraAway: away,
    );
    for (final choreId in before.map((t) => t.choreId).toSet()) {
      final was = before.where((t) => t.choreId == choreId).toList();
      final now = after.where((t) => t.choreId == choreId).toList();
      for (var i = 0; i < was.length; i++) {
        final turn = was[i];
        if (turn.mateId != me.id || !away.overlaps(turn.day, turn.lastDay)) {
          continue;
        }
        if (i >= now.length) continue;
        effects.add(
          effect(choreId, turn.day, now[i].mateId, now[i].day, now[i].lastDay),
        );
      }
    }
    return effects;
  }

  static Future<void> _reassign(
    Session session,
    Flat flat,
    Chore chore,
    Turn turn,
    ({int index, UuidValue mateId}) cover, {
    required bool owesBack,
  }) async {
    final awayMateId = turn.mateId;
    await session.db.transaction((tx) async {
      if (owesBack) {
        turn.coveringForMateId = awayMateId;
        await SwapDebt.db.insertRow(
          session,
          SwapDebt(
            choreId: chore.id!,
            debtorMateId: awayMateId,
            creditorMateId: cover.mateId,
          ),
          transaction: tx,
        );
      } else {
        turn.coveringForMateId = null;
        chore.rotationIndex = cover.index;
        await Chore.db.updateRow(session, chore, transaction: tx);
      }
      turn.mateId = cover.mateId;
      await Turn.db.updateRow(session, turn, transaction: tx);
    });
    await _schedule(session, flat, turn);
  }

  /// Hands a leaving Mate's open Turns to the next Mate and drops their debts.
  static Future<void> onMateLeft(Session session, Flat flat, Mate mate) async {
    await SwapDebt.db.deleteWhere(
      session,
      where: (t) =>
          t.debtorMateId.equals(mate.id!) | t.creditorMateId.equals(mate.id!),
    );
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.mateId.equals(mate.id!) & t.status.equals(TurnStatus.active),
    );
    for (final turn in turns) {
      final chore = await Chore.db.findById(session, turn.choreId);
      if (chore == null) continue;
      final state = await plannerState(session, flat, chore);
      final cover = findCover(
        state,
        chore.rotationIndex,
        mate.id!,
        turn.day,
        turn.lastDay,
      );
      if (cover == null) {
        await _cancel(session, turn.id!);
        await Turn.db.deleteRow(session, turn);
      } else {
        await _reassign(session, flat, chore, turn, cover, owesBack: false);
      }
    }
    await broadcast(session, flat.id!, FlatChangeKind.chores);
  }

  /// Stops a Chore: its open Turn is removed.
  static Future<void> stopChore(Session session, Chore chore) async {
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.choreId.equals(chore.id!) & t.status.equals(TurnStatus.active),
    );
    for (final turn in turns) {
      await _cancel(session, turn.id!);
      await Turn.db.deleteRow(session, turn);
    }
    await SwapDebt.db.deleteWhere(
      session,
      where: (t) => t.choreId.equals(chore.id!),
    );
  }

  /// "in 2d 4h", "in 3h", "in 45m": the server doesn't know the reader's
  /// timezone, so durations read better than clock times.
  static String _dueIn(DateTime t) {
    final d = t.difference(DateTime.now().toUtc());
    if (d.inMinutes < 60) return 'in ${d.inMinutes.clamp(0, 59)}m';
    if (d.inHours < 24) return 'in ${d.inHours}h';
    final hours = d.inHours % 24;
    return 'in ${d.inDays}d${hours > 0 ? ' ${hours}h' : ''}';
  }
}
