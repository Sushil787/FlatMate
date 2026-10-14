import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../notify/digests.dart';
import '../notify/notifier.dart';

/// The moments of the day the Flat's Turn pushes go out.
enum PushMoment {
  turnStarts,
  reminder,
  matesNotDone,
  nightSummary;

  /// Whether it comes once per Turn time, not once a day.
  bool get byTurnTime => this == turnStarts || this == reminder;
}

/// A push to send: to whom, what, and the switch it obeys (null when the
/// Mate's switch was already checked).
typedef Outgoing = ({UuidValue mateId, Push push, NotifyKind? kind});

/// How late a scheduled push may run (after a restart, say) and still go
/// out; any later and "1 hour left" or "this morning" would be wrong.
const _late = Duration(minutes: 30);

/// Moves Chores through their Turns: creates them, reacts to Away and
/// leaving Mates, and handles the scheduled start, reminder and end.
class TurnService {
  // ---------------------------------------------------------------------------
  // Planning

  static Future<PlannerState> plannerState(
    Session session,
    Flat flat,
    Chore chore,
  ) async {
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

    await _schedule(session, flat, chore, turn);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return turn;
  }

  // ---------------------------------------------------------------------------
  // Scheduling

  static String _id(UuidValue turnId, String what) => 'turn-$turnId-$what';

  /// When the Turn starts and ends: the Flat's local midnights.
  static ({DateTime start, DateTime end}) instants(Flat flat, Turn turn) => (
    start: Day.start(flat.timezone, turn.day),
    end: Day.end(flat.timezone, turn.lastDay),
  );

  /// [minutes] after the Flat's local midnight on [day], in UTC.
  static DateTime _at(Flat flat, DateTime day, int minutes) =>
      Day.at(flat.timezone, day, minutes);

  /// Schedules the Turn's pushes and end: its start at the Chore's Turn
  /// time, its reminder, the Flat's 18:00 Mates' Turns not Done and 22:00
  /// night summary on its last day, and its end at midnight. A Turn that
  /// lands after its Turn time started is announced right away, unless
  /// [announce] is false.
  static Future<void> _schedule(
    Session session,
    Flat flat,
    Chore chore,
    Turn turn, {
    bool announce = true,
  }) async {
    final calls = session.serverpod.futureCalls;
    final id = turn.id!;
    final now = DateTime.now().toUtc();
    await _cancel(session, id);

    final start = _at(flat, turn.day, chore.turnTime.startsAt);
    if (start.isAfter(now)) {
      await calls
          .callAtTime(start, identifier: _id(id, 'start'))
          .turnCalls
          .started(id);
    } else if (announce) {
      await _announce(session, flat, chore, turn);
    }

    await _scheduleReminder(session, flat, chore, turn);

    final notDone = _at(flat, turn.lastDay, matesNotDoneAt);
    if (notDone.isAfter(now)) {
      await calls
          .callAtTime(notDone, identifier: _id(id, 'notdone'))
          .turnCalls
          .matesNotDone(id);
    }
    final summary = _at(flat, turn.lastDay, nightSummaryAt);
    if (summary.isAfter(now)) {
      await calls
          .callAtTime(summary, identifier: _id(id, 'summary'))
          .turnCalls
          .nightSummary(id);
    }

    await calls
        .callAtTime(instants(flat, turn).end, identifier: _id(id, 'end'))
        .turnCalls
        .ended(id);
  }

  /// Moves the pushes of [chore]'s open Turn to its new Turn time.
  static Future<void> rescheduleOpen(
    Session session,
    Flat flat,
    Chore chore,
  ) async {
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.choreId.equals(chore.id!) & t.status.equals(TurnStatus.active),
    );
    for (final turn in turns) {
      await _schedule(session, flat, chore, turn, announce: false);
    }
  }

  /// Schedules every open Turn's calls again, at start-up: Turns from
  /// before Turn times were scheduled the old way. Replaces what's there,
  /// so running it again changes nothing.
  // ponytail: every open Turn on every start; batch per Flat if that's
  // ever slow.
  static Future<void> rescheduleAll(Session session) async {
    final turns = await Turn.db.find(
      session,
      where: (t) => t.status.equals(TurnStatus.active),
    );
    final flats = <UuidValue, Flat?>{};
    for (final turn in turns) {
      final flat = flats[turn.flatId] ??= await Flat.db.findById(
        session,
        turn.flatId,
      );
      final chore = await Chore.db.findById(session, turn.choreId);
      if (flat == null || chore == null) continue;
      await _schedule(session, flat, chore, turn, announce: false);
    }
  }

  /// Schedules the reminder on the Turn's last day, an hour before its
  /// Turn time ends, unless that has passed.
  static Future<void> _scheduleReminder(
    Session session,
    Flat flat,
    Chore chore,
    Turn turn,
  ) async {
    final remindAt = _at(flat, turn.lastDay, chore.turnTime.remindAt);
    if (remindAt.isAfter(DateTime.now().toUtc())) {
      await session.serverpod.futureCalls
          .callAtTime(remindAt, identifier: _id(turn.id!, 'reminder'))
          .turnCalls
          .reminder(turn.id!);
    }
  }

  static Future<void> _cancel(Session session, UuidValue turnId) async {
    final calls = session.serverpod.futureCalls;
    for (final what in ['start', 'reminder', 'notdone', 'summary', 'end']) {
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

  /// Tells a Turn's Mate it's theirs, when it lands on them after its Turn
  /// time started.
  static Future<void> _announce(
    Session session,
    Flat flat,
    Chore chore,
    Turn turn,
  ) async {
    final coveringFor = turn.coveringForMateId;
    final other = coveringFor == null
        ? null
        : await Mate.db.findById(session, coveringFor);
    final over = !_at(
      flat,
      turn.day,
      chore.turnTime.endsAt,
    ).isAfter(DateTime.now().toUtc());
    final push = startPush([
      (
        chore: chore.name,
        coveringFor: coveringFor == null
            ? null
            : other?.displayName ?? 'a mate',
      ),
    ], when: over ? 'today' : chore.turnTime.thisPart);
    await Notifier.toMates(
      session,
      [turn.mateId],
      title: push.title,
      body: push.body,
      kind: NotifyKind.turnStarts,
    );
  }

  /// Today's Turns in [flat] that [moment]'s pushes are about, in id
  /// order, each with its Chore. [time] picks the Turn time for
  /// [PushMoment.turnStarts] and [PushMoment.reminder].
  static Future<List<({Turn turn, Chore chore})>> _slot(
    Session session,
    Flat flat,
    PushMoment moment,
    TurnTime? time,
  ) async {
    final today = Day.today(flat.timezone);
    final active = TurnStatus.active;
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          switch (moment) {
            PushMoment.turnStarts =>
              t.status.equals(active) & t.day.equals(today),
            PushMoment.reminder || PushMoment.matesNotDone =>
              t.status.equals(active) & t.lastDay.equals(today),
            PushMoment.nightSummary =>
              t.lastDay.equals(today) &
                  t.status.inSet({active, TurnStatus.done}),
          },
      orderBy: (t) => t.id,
    );
    final chores = {
      for (final c in await Chore.db.find(
        session,
        where: (t) => t.id.inSet(turns.map((t) => t.choreId).toSet()),
      ))
        c.id!: c,
    };
    return [
      for (final t in turns)
        if (chores[t.choreId] case final c?
            when time == null || c.turnTime == time)
          (turn: t, chore: c),
    ];
  }

  /// When [moment] is, in minutes after the Flat's midnight.
  static int _minuteOf(PushMoment moment, TurnTime? time) => switch (moment) {
    PushMoment.turnStarts => time!.startsAt,
    PushMoment.reminder => time!.remindAt,
    PushMoment.matesNotDone => matesNotDoneAt,
    PushMoment.nightSummary => nightSummaryAt,
  };

  /// Whether a push due [minutes] after midnight today is still worth
  /// sending: not more than [_late] late.
  static bool _onTime(Flat flat, int minutes) => !DateTime.now()
      .toUtc()
      .isAfter(_at(flat, Day.today(flat.timezone), minutes).add(_late));

  /// Every Mate of the Flat by id, left ones too: someone may be covering
  /// for one, or have done a Turn before leaving.
  static Future<Map<UuidValue, String>> _names(
    Session session,
    Flat flat,
  ) async => {
    for (final m in await Mate.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!),
    ))
      m.id!: m.displayName,
  };

  static Future<void> onTurnStarted(Session session, UuidValue turnId) =>
      _onCall(session, turnId, PushMoment.turnStarts);

  static Future<void> onTurnReminder(Session session, UuidValue turnId) =>
      _onCall(session, turnId, PushMoment.reminder);

  static Future<void> onMatesNotDone(Session session, UuidValue turnId) =>
      _onCall(session, turnId, PushMoment.matesNotDone);

  static Future<void> onNightSummary(Session session, UuidValue turnId) =>
      _onCall(session, turnId, PushMoment.nightSummary);

  /// A Turn's call for [moment]. Every Turn in the slot has one at the same
  /// time, so only the slot's first Turn sends, for all of them.
  static Future<void> _onCall(
    Session session,
    UuidValue turnId,
    PushMoment moment,
  ) async {
    final loaded = await _load(session, turnId);
    if (loaded == null) return;
    final (:flat, :chore, turn: _) = loaded;
    final time = moment.byTurnTime ? chore.turnTime : null;
    if (!_onTime(flat, _minuteOf(moment, time))) return;
    final slot = await _slot(session, flat, moment, time);
    if (slot.firstOrNull?.turn.id != turnId) return;
    await _send(session, await _pushes(session, flat, moment, time, slot));
  }

  static Future<void> _send(Session session, List<Outgoing> pushes) async {
    for (final o in pushes) {
      await Notifier.toMates(
        session,
        [o.mateId],
        title: o.push.title,
        body: o.push.body,
        kind: o.kind,
      );
    }
  }

  static Future<List<Outgoing>> _pushes(
    Session session,
    Flat flat,
    PushMoment moment,
    TurnTime? time,
    List<({Turn turn, Chore chore})> slot,
  ) async {
    if (slot.isEmpty) return const [];
    final today = Day.today(flat.timezone);
    final mates = await activeMates(session, flat.id!);
    final names = await _names(session, flat);
    switch (moment) {
      // Each Mate: their Turns of this Turn time that start today.
      case PushMoment.turnStarts:
        final byMate = <UuidValue, List<({Turn turn, Chore chore})>>{};
        for (final s in slot) {
          (byMate[s.turn.mateId] ??= []).add(s);
        }
        return [
          for (final MapEntry(key: mateId, value: mine) in byMate.entries)
            (
              mateId: mateId,
              push: startPush([
                for (final s in mine)
                  (
                    chore: s.chore.name,
                    coveringFor: s.turn.coveringForMateId == null
                        ? null
                        : names[s.turn.coveringForMateId] ?? 'a mate',
                  ),
              ], when: time!.thisPart),
              kind: NotifyKind.turnStarts,
            ),
        ];
      // Each Mate who wants it: their Turns of this Turn time not Done.
      case PushMoment.reminder:
        return [
          for (final m in mates)
            if (m.notifyReminder)
              if ([
                    for (final s in slot)
                      if (s.turn.mateId == m.id) s.chore.name,
                  ]
                  case final mine when mine.isNotEmpty)
                (mateId: m.id!, push: reminderPush(mine, time!), kind: null),
        ];
      // Each Mate who wants it and isn't Away: others' Turns from earlier
      // Turn times not Done.
      case PushMoment.matesNotDone:
        final over = [
          for (final s in slot)
            if (s.chore.turnTime.endsAt <= matesNotDoneAt) s,
        ];
        final away = await _awayToday(session, flat, today);
        return [
          for (final m in mates)
            if (m.notifyMatesNotDone && !away.contains(m.id))
              if (matesNotDonePush({
                    for (final s in over)
                      if (s.turn.mateId != m.id)
                        names[s.turn.mateId] ?? 'Someone': [
                          for (final o in over)
                            if (o.turn.mateId == s.turn.mateId) o.chore.name,
                        ],
                  })
                  case final push?)
                (mateId: m.id!, push: push, kind: null),
        ];
      // Each Mate who wants it: the day so far.
      case PushMoment.nightSummary:
        List<Who> pick(Mate m, bool Function(Turn t, Chore c) keep) => [
          for (final s in slot)
            if (keep(s.turn, s.chore))
              (
                chore: s.chore.name,
                who: s.turn.mateId == m.id
                    ? 'you'
                    : names[s.turn.mateId] ?? 'someone',
              ),
        ];
        bool open(Turn t) => t.status == TurnStatus.active;
        return [
          for (final m in mates)
            if (m.notifyNightSummary)
              if (nightSummaryPush(
                    flat.name,
                    done: pick(m, (t, _) => t.status == TurnStatus.done),
                    notDone: pick(
                      m,
                      (t, c) => open(t) && c.turnTime.endsAt <= nightSummaryAt,
                    ),
                    tonight: pick(
                      m,
                      (t, c) => open(t) && c.turnTime.endsAt > nightSummaryAt,
                    ),
                  )
                  case final push?)
                (mateId: m.id!, push: push, kind: null),
        ];
    }
  }

  /// The Mates Away on [today].
  static Future<Set<UuidValue>> _awayToday(
    Session session,
    Flat flat,
    DateTime today,
  ) async => {
    for (final a in await Away.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          (t.startDay <= today) &
          (t.lastDay >= today),
    ))
      a.mateId,
  };

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

    // No push: the night summary already told the Flat it wasn't Done.
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
    // Nothing left to tell its Mate; the Flat-wide pushes see it's Done.
    for (final what in ['start', 'reminder']) {
      await session.serverpod.futureCalls.cancel(_id(turnId, what));
    }
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
    final chore = await Chore.db.findById(session, turn.choreId);
    if (chore != null) await _scheduleReminder(session, flat, chore, turn);
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
      await _schedule(session, flat, chore, turn, announce: false);
    }
    if (turns.isNotEmpty) {
      await broadcast(session, flat.id!, FlatChangeKind.chores);
    }
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
    await _schedule(session, flat, chore, turn);
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
}
