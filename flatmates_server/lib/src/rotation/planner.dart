import '../generated/protocol.dart';

/// A span of time a Mate is Away.
class AwaySpan {
  final int mateId;
  final DateTime start;
  final DateTime end;

  const AwaySpan(this.mateId, this.start, this.end);

  bool overlaps(DateTime from, DateTime to) =>
      start.isBefore(to) && end.isAfter(from);
}

/// A Turn owed back under the Swap rule.
class Debt {
  final int debtorMateId;
  final int creditorMateId;

  const Debt(this.debtorMateId, this.creditorMateId);
}

/// Everything the planner needs to know about a Chore and its Flat.
class PlannerState {
  final List<int> rotation;
  final Duration period;
  final AwayRule awayRule;
  final Set<int> activeMateIds;
  final List<AwaySpan> aways;
  final List<Debt> debts;

  PlannerState({
    required this.rotation,
    required this.period,
    required this.awayRule,
    required this.activeMateIds,
    required this.aways,
    required List<Debt> debts,
  }) : debts = List.of(debts);

  bool isAway(int mateId, DateTime from, DateTime to) =>
      aways.any((a) => a.mateId == mateId && a.overlaps(from, to));
}

/// The outcome of planning one Turn.
class PlannedTurn {
  final int rotationIndex;
  final int mateId;
  final int? coveringForMateId;
  final DateTime startsAt;
  final DateTime endsAt;

  /// Debt created by this Turn (Swap cover), if any.
  final Debt? debtCreated;

  /// Debt repaid by this Turn, if any.
  final Debt? debtRepaid;

  const PlannedTurn({
    required this.rotationIndex,
    required this.mateId,
    required this.startsAt,
    required this.endsAt,
    this.coveringForMateId,
    this.debtCreated,
    this.debtRepaid,
  });
}

/// Plans the Turn that follows the slot at [previousIndex], beginning at
/// [startAt]. Returns null when nobody in the Rotation is still in the Flat.
///
/// Mutates [state.debts] to reflect debts created or repaid, so it can be
/// called repeatedly to project future Turns.
PlannedTurn? planNextTurn(
  PlannerState state,
  int previousIndex,
  DateTime startAt,
) {
  final index = _nextActiveIndex(state, previousIndex);
  if (index == null) return null;

  final owner = state.rotation[index];
  var start = startAt;
  var end = start.add(state.period);

  // A Mate who covered a Swap gets their next Turn done by the debtor.
  final debt = state.debts
      .where((d) => d.creditorMateId == owner)
      .where((d) => state.activeMateIds.contains(d.debtorMateId))
      .where((d) => !state.isAway(d.debtorMateId, start, end))
      .firstOrNull;
  if (debt != null) {
    state.debts.remove(debt);
    return PlannedTurn(
      rotationIndex: index,
      mateId: debt.debtorMateId,
      coveringForMateId: owner,
      startsAt: start,
      endsAt: end,
      debtRepaid: debt,
    );
  }

  if (!state.isAway(owner, start, end)) {
    return PlannedTurn(
      rotationIndex: index,
      mateId: owner,
      startsAt: start,
      endsAt: end,
    );
  }

  switch (state.awayRule) {
    case AwayRule.swap:
      final cover = findCover(state, index, owner, start, end);
      if (cover != null) {
        final created = Debt(owner, cover.mateId);
        state.debts.add(created);
        return PlannedTurn(
          rotationIndex: index,
          mateId: cover.mateId,
          coveringForMateId: owner,
          startsAt: start,
          endsAt: end,
          debtCreated: created,
        );
      }
    case AwayRule.skip:
      final cover = findCover(state, index, owner, start, end);
      if (cover != null) {
        return PlannedTurn(
          rotationIndex: cover.index,
          mateId: cover.mateId,
          startsAt: start,
          endsAt: end,
        );
      }
    case AwayRule.pause:
      break;
  }

  // Pause, or nobody available to cover: the Chore freezes for the owner.
  final paused = pauseSpan(state, owner, start, state.period);
  return PlannedTurn(
    rotationIndex: index,
    mateId: owner,
    startsAt: paused.start,
    endsAt: paused.end,
  );
}

/// The next Mate after [index] in the Rotation who is in the Flat, is not
/// [excludeMateId] and is not Away during the Turn.
({int index, int mateId})? findCover(
  PlannerState state,
  int index,
  int excludeMateId,
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

/// Applies the Pause rule to a Turn of [length] starting at [start]: a Turn
/// whose start falls in an Away waits for the Mate's return, and Away days
/// in the middle extend the Turn.
({DateTime start, DateTime end}) pauseSpan(
  PlannerState state,
  int mateId,
  DateTime start,
  Duration length,
) {
  final aways = state.aways.where((a) => a.mateId == mateId).toList()
    ..sort((a, b) => a.start.compareTo(b.start));

  var s = start;
  for (final a in aways) {
    if (!a.start.isAfter(s) && a.end.isAfter(s)) s = a.end;
  }

  var e = s.add(length);
  for (final a in aways) {
    if (a.start.isBefore(e) && a.end.isAfter(s)) {
      final from = a.start.isAfter(s) ? a.start : s;
      e = e.add(a.end.difference(from));
    }
  }
  return (start: s, end: e);
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
