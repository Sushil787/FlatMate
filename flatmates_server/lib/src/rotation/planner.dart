import 'package:serverpod/serverpod.dart' show UuidValue;

import '../day.dart';
import '../generated/protocol.dart';

// Everything here works in days (see day.dart); ranges are inclusive.

/// The day of the Turn after one on [day]..[lastDay]: one [period] after its
/// day, but never before it's over (Pause can extend it).
DateTime nextTurnDay(DateTime day, DateTime lastDay, Duration period) =>
    Day.later(day.add(period), Day.add(lastDay, 1));

/// Days a Mate is Away.
class AwaySpan {
  final UuidValue mateId;
  final DateTime startDay;
  final DateTime lastDay;

  const AwaySpan(this.mateId, this.startDay, this.lastDay);

  bool overlaps(DateTime from, DateTime to) =>
      !startDay.isAfter(to) && !lastDay.isBefore(from);
}

/// A Turn owed back under the Swap rule.
class Debt {
  final UuidValue debtorMateId;
  final UuidValue creditorMateId;

  const Debt(this.debtorMateId, this.creditorMateId);
}

/// Everything the planner needs to know about a Chore and its Flat.
class PlannerState {
  final List<UuidValue> rotation;
  final AwayRule awayRule;
  final Set<UuidValue> activeMateIds;
  final List<AwaySpan> aways;
  final List<Debt> debts;

  PlannerState({
    required this.rotation,
    required this.awayRule,
    required this.activeMateIds,
    required this.aways,
    required List<Debt> debts,
  }) : debts = List.of(debts);

  bool isAway(UuidValue mateId, DateTime from, DateTime to) =>
      aways.any((a) => a.mateId == mateId && a.overlaps(from, to));
}

/// The outcome of planning one Turn.
class PlannedTurn {
  final int rotationIndex;
  final UuidValue mateId;
  final UuidValue? coveringForMateId;
  final DateTime day;
  final DateTime lastDay;

  /// Debt created by this Turn (Swap cover), if any.
  final Debt? debtCreated;

  /// Debt repaid by this Turn, if any.
  final Debt? debtRepaid;

  const PlannedTurn({
    required this.rotationIndex,
    required this.mateId,
    required this.day,
    required this.lastDay,
    this.coveringForMateId,
    this.debtCreated,
    this.debtRepaid,
  });
}

/// Plans the Turn that follows the slot at [previousIndex], on [day].
/// Returns null when nobody in the Rotation is still in the Flat.
///
/// Mutates [state.debts] to reflect debts created or repaid, so it can be
/// called repeatedly to project future Turns.
PlannedTurn? planNextTurn(
  PlannerState state,
  int previousIndex,
  DateTime day,
) {
  final index = _nextActiveIndex(state, previousIndex);
  if (index == null) return null;

  final owner = state.rotation[index];

  // A Mate who covered a Swap gets their next Turn done by the debtor.
  final debt = state.debts
      .where((d) => d.creditorMateId == owner)
      .where((d) => state.activeMateIds.contains(d.debtorMateId))
      .where((d) => !state.isAway(d.debtorMateId, day, day))
      .firstOrNull;
  if (debt != null) {
    state.debts.remove(debt);
    return PlannedTurn(
      rotationIndex: index,
      mateId: debt.debtorMateId,
      coveringForMateId: owner,
      day: day,
      lastDay: day,
      debtRepaid: debt,
    );
  }

  if (!state.isAway(owner, day, day)) {
    return PlannedTurn(
      rotationIndex: index,
      mateId: owner,
      day: day,
      lastDay: day,
    );
  }

  switch (state.awayRule) {
    case AwayRule.swap:
      final cover = findCover(state, index, owner, day, day);
      if (cover != null) {
        final created = Debt(owner, cover.mateId);
        state.debts.add(created);
        return PlannedTurn(
          rotationIndex: index,
          mateId: cover.mateId,
          coveringForMateId: owner,
          day: day,
          lastDay: day,
          debtCreated: created,
        );
      }
    case AwayRule.skip:
      final cover = findCover(state, index, owner, day, day);
      if (cover != null) {
        return PlannedTurn(
          rotationIndex: cover.index,
          mateId: cover.mateId,
          day: day,
          lastDay: day,
        );
      }
    case AwayRule.pause:
      break;
  }

  // Pause, or nobody available to cover: the Chore freezes for the owner.
  final paused = pauseSpan(state, owner, day, day, canMoveStart: true);
  return PlannedTurn(
    rotationIndex: index,
    mateId: owner,
    day: paused.day,
    lastDay: paused.lastDay,
  );
}

/// What the Away rule does to an existing Turn of [mateId] that an Away
/// overlaps: someone covers it, or (Pause, or nobody free) it moves to
/// new days.
({({int index, UuidValue mateId})? cover, DateTime day, DateTime lastDay})
awayOutcome(
  PlannerState state,
  int rotationIndex,
  UuidValue mateId,
  DateTime day,
  DateTime lastDay, {
  required bool canMoveStart,
}) {
  if (state.awayRule != AwayRule.pause) {
    final cover = findCover(state, rotationIndex, mateId, day, lastDay);
    if (cover != null) return (cover: cover, day: day, lastDay: lastDay);
  }
  final span = pauseSpan(
    state,
    mateId,
    day,
    lastDay,
    canMoveStart: canMoveStart,
  );
  return (cover: null, day: span.day, lastDay: span.lastDay);
}

/// The next Mate after [index] in the Rotation who is in the Flat, is not
/// [excludeMateId] and is not Away during the Turn.
({int index, UuidValue mateId})? findCover(
  PlannerState state,
  int index,
  UuidValue excludeMateId,
  DateTime start,
  DateTime end,
) {
  final n = state.rotation.length;
  for (var step = 1; step <= n; step++) {
    final i = (index + step) % n;
    final mateId = state.rotation[i];
    if (mateId == excludeMateId) continue;
    if (!state.activeMateIds.contains(mateId)) continue;
    if (state.isAway(mateId, start, end)) continue;
    return (index: i, mateId: mateId);
  }
  return null;
}

/// Applies the Pause rule to a Turn on [day]..[lastDay]. A Turn not yet
/// started ([canMoveStart]) waits for the Mate's return; a Turn in progress
/// is extended by the Away days.
({DateTime day, DateTime lastDay}) pauseSpan(
  PlannerState state,
  UuidValue mateId,
  DateTime day,
  DateTime lastDay, {
  required bool canMoveStart,
}) {
  final aways = state.aways.where((a) => a.mateId == mateId).toList()
    ..sort((a, b) => a.startDay.compareTo(b.startDay));

  var s = day;
  var e = lastDay;
  if (canMoveStart) {
    for (final a in aways) {
      if (a.overlaps(s, s)) {
        final shift = Day.between(s, a.lastDay) + 1;
        s = Day.add(s, shift);
        e = Day.add(e, shift);
      }
    }
  }
  for (final a in aways) {
    if (a.overlaps(s, e)) {
      final from = Day.later(a.startDay, s);
      e = Day.add(e, Day.between(from, a.lastDay) + 1);
    }
  }
  return (day: s, lastDay: e);
}

int? _nextActiveIndex(PlannerState state, int previousIndex) {
  final n = state.rotation.length;
  if (n == 0) return null;
  for (var step = 1; step <= n; step++) {
    final i = (previousIndex + step) % n;
    if (state.activeMateIds.contains(state.rotation[i])) return i;
  }
  return null;
}
