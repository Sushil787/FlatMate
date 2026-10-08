import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../notify/notifier.dart';
import 'planner.dart';

/// How long before a Turn ends its Mate is reminded.
const reminderLead = Duration(hours: 3);

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
        orderBy: (t) => t.id.desc(),
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

  static String _id(int turnId, String what) => 'turn-$turnId-$what';

  /// When the Turn starts and ends: the Flat's local midnights.
  static ({DateTime start, DateTime end}) instants(Flat flat, Turn turn) => (
    start: Day.start(flat.timezone, turn.day),
    end: Day.end(flat.timezone, turn.lastDay),
  );

  /// Schedules the Turn's start, reminder and end. A Turn that has already
  /// started is announced right away unless [announce] is false.
  static Future<void> _schedule(
    Session session,
    Flat flat,
    Turn turn, {
    bool announce = true,
  }) async {
    final calls = session.serverpod.futureCalls;
    final now = DateTime.now().toUtc();
    final (:start, :end) = instants(flat, turn);
    await _cancel(session, turn.id!);

    if (start.isAfter(now)) {
      await calls
          .callAtTime(start, identifier: _id(turn.id!, 'start'))
          .turnCalls
          .started(turn.id!);
    } else if (announce) {
      await onTurnStarted(session, turn.id!);
    }

    await _scheduleReminder(session, flat, turn);

    await calls
        .callAtTime(end, identifier: _id(turn.id!, 'end'))
        .turnCalls
        .ended(turn.id!);
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

  static Future<void> _cancel(Session session, int turnId) async {
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
    int turnId,
  ) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null) return null;
    final chore = await Chore.db.findById(session, turn.choreId);
    final flat = await Flat.db.findById(session, turn.flatId);
    if (chore == null || flat == null) return null;
    return (turn: turn, chore: chore, flat: flat);
  }

  static Future<void> onTurnStarted(Session session, int turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null || loaded.turn.status != TurnStatus.active) return;
    final (:turn, :chore, :flat) = loaded;
    final due = _dueIn(instants(flat, turn).end);

    final coveringFor = turn.coveringForMateId;
    if (coveringFor == null) {
      await Notifier.toMates(
        session,
        [turn.mateId],
        title: 'Your Turn: ${chore.name}',
        body: 'It\'s yours, due $due.',
        kind: NotifyKind.turnStarts,
      );
    } else {
      final other = await Mate.db.findById(session, coveringFor);
      await Notifier.toMates(
        session,
        [turn.mateId],
        title: 'You\'re covering: ${chore.name}',
        body:
            'Doing ${other?.displayName ?? 'a mate'}\'s turn, '
            'due $due.',
        kind: NotifyKind.turnStarts,
      );
    }
  }

  static Future<void> onTurnReminder(Session session, int turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null || loaded.turn.status != TurnStatus.active) return;
    final (:turn, :chore, :flat) = loaded;
    await Notifier.toMates(
      session,
      [turn.mateId],
      title: '${reminderLead.inHours} hours left for ${chore.name}',
      body: 'Done already? Tap to tell your Mates.',
      kind: NotifyKind.reminder,
    );
  }

  static Future<void> onTurnEnded(Session session, int turnId) async {
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
              orderBy: (t) => t.id.desc(),
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
  static final _flatLocks = <int, Future<void>>{};

  static Future<void> _locked(int flatId, Future<void> Function() body) {
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
  static Future<bool> _end(Session session, int turnId) async {
    final loaded = await _load(session, turnId);
    if (loaded == null) return false;
    final (:turn, :chore, :flat) = loaded;
    // The Turn was extended (Pause) after this call was scheduled.
    final end = instants(flat, turn).end;
    if (end.isAfter(DateTime.now().toUtc().add(_slack))) return false;

    // Only the Chore's latest Turn hands over; guards against a re-run.
    final newer = await Turn.db.count(
      session,
      where: (t) => t.choreId.equals(turn.choreId) & (t.id > turnId),
    );
    if (newer > 0) return false;

    if (turn.status == TurnStatus.active) {
      turn.status = TurnStatus.missed;
      await Turn.db.updateRow(session, turn);
      final mate = await Mate.db.findById(session, turn.mateId);
      await Notifier.toFlat(
        session,
        flat.id!,
        title: '${chore.name} was Missed',
        body: '${mate?.displayName ?? 'Someone'}\'s Turn ended without a Done.',
        kind: NotifyKind.missed,
      );
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
    int turnId,
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

    final chore = await Chore.db.findById(session, turn.choreId);
    await Notifier.toFlat(
      session,
      me.flatId,
      title: '${chore?.name ?? 'A chore'} is done',
      body: '${me.displayName} marked it done.',
      exceptMateId: me.id,
    );
    await broadcast(session, me.flatId, FlatChangeKind.chores);
    return turn;
  }

  /// Takes back a Done while the Turn's day is still going.
  static Future<Turn> undoDone(
    Session session,
    Flat flat,
    Mate me,
    int turnId,
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
      int choreId,
      DateTime day,
      int mateId,
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
    ({int index, int mateId}) cover, {
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
