import 'package:serverpod/serverpod.dart';

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
      period: chore.period,
      awayRule: flat.awayRule,
      activeMateIds: mates.map((m) => m.id!).toSet(),
      aways: [for (final a in aways) AwaySpan(a.mateId, a.startsAt, a.endsAt)],
      debts: [
        for (final d in debts) Debt(d.debtorMateId, d.creditorMateId),
      ],
    );
  }

  /// Creates the Chore's first Turn. Called when the Admin creates a Chore.
  static Future<void> startChore(Session session, Flat flat, Chore chore) async {
    final now = DateTime.now().toUtc();
    final start = chore.startsAt.isBefore(now) ? now : chore.startsAt;
    await _createNextTurn(session, flat, chore, start);
  }

  static Future<Turn?> _createNextTurn(
    Session session,
    Flat flat,
    Chore chore,
    DateTime startAt,
  ) async {
    final state = await plannerState(session, flat, chore);
    final plan = planNextTurn(state, chore.rotationIndex, startAt);
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
            createdAt: DateTime.now().toUtc(),
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
          startsAt: plan.startsAt,
          endsAt: plan.endsAt,
          status: TurnStatus.active,
        ),
        transaction: tx,
      );
    });

    await _schedule(session, turn);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return turn;
  }

  /// Projects upcoming Turns for every Chore in the Flat up to [until],
  /// starting after each Chore's latest real Turn. Projected Turns have no id.
  static Future<List<Turn>> projectTurns(
    Session session,
    Flat flat,
    DateTime until,
  ) async {
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
      final state = await plannerState(session, flat, chore);
      var index = chore.rotationIndex;
      var start = latest.endsAt;
      for (var i = 0; i < 200 && start.isBefore(until); i++) {
        final plan = planNextTurn(state, index, start);
        if (plan == null) break;
        projected.add(
          Turn(
            flatId: flat.id!,
            choreId: chore.id!,
            mateId: plan.mateId,
            coveringForMateId: plan.coveringForMateId,
            startsAt: plan.startsAt,
            endsAt: plan.endsAt,
            status: TurnStatus.active,
          ),
        );
        index = plan.rotationIndex;
        start = plan.endsAt;
      }
    }
    return projected;
  }

  // ---------------------------------------------------------------------------
  // Scheduling

  static String _id(int turnId, String what) => 'turn-$turnId-$what';

  /// Schedules the Turn's start, reminder and end. A Turn that has already
  /// started is announced right away unless [announce] is false.
  static Future<void> _schedule(
    Session session,
    Turn turn, {
    bool announce = true,
  }) async {
    final calls = session.serverpod.futureCalls;
    final now = DateTime.now().toUtc();
    await _cancel(session, turn.id!);

    if (turn.startsAt.isAfter(now)) {
      await calls
          .callAtTime(turn.startsAt, identifier: _id(turn.id!, 'start'))
          .turnCalls
          .started(turn.id!);
    } else if (announce) {
      await onTurnStarted(session, turn.id!);
    }

    final remindAt = turn.endsAt.subtract(reminderLead);
    if (remindAt.isAfter(now) && remindAt.isAfter(turn.startsAt)) {
      await calls
          .callAtTime(remindAt, identifier: _id(turn.id!, 'reminder'))
          .turnCalls
          .reminder(turn.id!);
    }

    await calls
        .callAtTime(turn.endsAt, identifier: _id(turn.id!, 'end'))
        .turnCalls
        .ended(turn.id!);
  }

  static Future<void> _cancel(Session session, int turnId) async {
    final calls = session.serverpod.futureCalls;
    for (final what in ['start', 'reminder', 'end']) {
      await calls.cancel(_id(turnId, what));
    }
  }

  // ---------------------------------------------------------------------------
  // Scheduled handlers

  static Future<void> onTurnStarted(Session session, int turnId) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null || turn.status != TurnStatus.active) return;
    final chore = await Chore.db.findById(session, turn.choreId);
    if (chore == null) return;

    final coveringFor = turn.coveringForMateId;
    if (coveringFor == null) {
      await Notifier.toMates(
        session,
        [turn.mateId],
        title: 'Your turn: ${chore.name}',
        body: 'Due ${_dueIn(turn.endsAt)}.',
      );
    } else {
      final other = await Mate.db.findById(session, coveringFor);
      await Notifier.toMates(
        session,
        [turn.mateId],
        title: 'You\'re covering: ${chore.name}',
        body: 'Doing ${other?.displayName ?? 'a mate'}\'s turn, '
            'due ${_dueIn(turn.endsAt)}.',
      );
    }
  }

  static Future<void> onTurnReminder(Session session, int turnId) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null || turn.status != TurnStatus.active) return;
    final chore = await Chore.db.findById(session, turn.choreId);
    if (chore == null) return;
    await Notifier.toMates(
      session,
      [turn.mateId],
      title: '${chore.name} is due soon',
      body: 'Mark it done, it\'s due ${_dueIn(turn.endsAt)}.',
    );
  }

  static Future<void> onTurnEnded(Session session, int turnId) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null) return;
    // The Turn was extended (Pause) after this call was scheduled.
    if (turn.endsAt.isAfter(DateTime.now().toUtc().add(_slack))) return;

    // Only the Chore's latest Turn hands over; guards against a re-run.
    final newer = await Turn.db.count(
      session,
      where: (t) => t.choreId.equals(turn.choreId) & (t.id > turnId),
    );
    if (newer > 0) return;

    final chore = await Chore.db.findById(session, turn.choreId);
    final flat = await Flat.db.findById(session, turn.flatId);
    if (chore == null || flat == null) return;

    if (turn.status == TurnStatus.active) {
      turn.status = TurnStatus.missed;
      await Turn.db.updateRow(session, turn);
      final mate = await Mate.db.findById(session, turn.mateId);
      await Notifier.toFlat(
        session,
        flat.id!,
        title: '${chore.name} was missed',
        body: '${mate?.displayName ?? 'Someone'} didn\'t mark it done.',
      );
    }

    if (!chore.archived) {
      await _createNextTurn(session, flat, chore, turn.endsAt);
    } else {
      await broadcast(session, flat.id!, FlatChangeKind.chores);
    }
  }

  static const _slack = Duration(seconds: 5);

  // ---------------------------------------------------------------------------
  // Actions

  static Future<Turn> markDone(Session session, Mate me, int turnId) async {
    final turn = await Turn.db.findById(session, turnId);
    if (turn == null || turn.flatId != me.flatId) fail('Turn not found.');
    if (turn.mateId != me.id) fail('This is not your turn.');
    if (turn.status != TurnStatus.active) fail('This turn is already over.');
    final now = DateTime.now().toUtc();
    if (turn.startsAt.isAfter(now)) fail('This turn hasn\'t started yet.');

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

  /// Applies the Flat's Away rule to the Mate's existing Turns that overlap
  /// the new [away].
  static Future<void> applyAway(Session session, Flat flat, Away away) async {
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.mateId.equals(away.mateId) &
          t.status.equals(TurnStatus.active) &
          (t.startsAt < away.endsAt) &
          (t.endsAt > away.startsAt),
    );

    for (final turn in turns) {
      final chore = await Chore.db.findById(session, turn.choreId);
      if (chore == null) continue;
      final state = await plannerState(session, flat, chore);

      if (flat.awayRule != AwayRule.pause) {
        final cover = findCover(
          state,
          chore.rotationIndex,
          away.mateId,
          turn.startsAt,
          turn.endsAt,
        );
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
      }

      // Pause, or nobody available to cover.
      final span = pauseSpan(
        state,
        turn.mateId,
        turn.startsAt,
        chore.period,
      );
      turn
        ..startsAt = span.start
        ..endsAt = span.end;
      await Turn.db.updateRow(session, turn);
      await _schedule(session, turn, announce: false);
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
            createdAt: DateTime.now().toUtc(),
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
    await _schedule(session, turn);
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
        turn.startsAt,
        turn.endsAt,
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
