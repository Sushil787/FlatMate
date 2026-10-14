import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';

import '../../chores/domain/planned_turns.dart';

/// What marking [me] Away on [startDay]..[lastDay] would do to their
/// Turns, worked out on the phone with the shared planner, so it shows at
/// once and offline. Their open Turns as the server will treat them, then
/// planned ones, each matched with the Turn in the same place in the plan
/// with the Away. Days are stored days (see day.dart).
// ponytail: ignores knock-on effects of changing an open Turn on the
// planned ones after it; good enough for a preview.
List<AwayEffect> previewAway({
  required UuidValue me,
  required DateTime startDay,
  required DateTime lastDay,
  required DateTime today,
  required List<Chore> chores,
  required List<Turn> current,
  required AwayRule awayRule,
  required List<Mate> mates,
  required List<Away> aways,
  required List<SwapDebt> debts,
}) {
  final span = AwaySpan(me, startDay, lastDay);
  final withAway = [
    ...aways,
    Away(
      flatId: mates.first.flatId,
      mateId: me,
      startDay: startDay,
      lastDay: lastDay,
    ),
  ];
  final activeMateIds = {for (final m in mates) m.id!};

  AwayEffect effect(
    UuidValue choreId,
    DateTime day,
    UuidValue mateId,
    DateTime newDay,
    DateTime newLastDay,
  ) {
    final moved = mateId == me;
    return AwayEffect(
      choreId: choreId,
      day: day,
      awayRule: awayRule,
      coverMateId: moved ? null : mateId,
      newDay: moved ? newDay : null,
      newLastDay: moved ? newLastDay : null,
    );
  }

  final effects = <AwayEffect>[];
  final open =
      current
          .where(
            (t) =>
                t.mateId == me &&
                t.status == TurnStatus.active &&
                span.overlaps(t.day, t.lastDay),
          )
          .toList()
        ..sort((a, b) => a.day.compareTo(b.day));
  for (final turn in open) {
    final chore = chores.where((c) => c.id == turn.choreId).firstOrNull;
    if (chore == null) continue;
    final outcome = awayOutcome(
      PlannerState(
        rotation: chore.rotation,
        awayRule: awayRule,
        activeMateIds: activeMateIds,
        aways: [
          for (final a in withAway) AwaySpan(a.mateId, a.startDay, a.lastDay),
        ],
        debts: [
          for (final d in debts)
            if (d.choreId == chore.id) Debt(d.debtorMateId, d.creditorMateId),
        ],
      ),
      chore.rotationIndex,
      me,
      turn.day,
      turn.lastDay,
      canMoveStart: turn.day.isAfter(today),
    );
    effects.add(
      effect(
        chore.id!,
        turn.day,
        outcome.cover?.mateId ?? me,
        outcome.day,
        outcome.lastDay,
      ),
    );
  }

  // Pause can push a Turn back by at most the Away's length.
  List<Turn> plan(List<Away> aways, DateTime until) => plannedTurns(
    chores: chores,
    current: current,
    awayRule: awayRule,
    mates: mates,
    aways: aways,
    debts: debts,
    until: until,
  );
  final length = lastDay.difference(startDay).inDays + 1;
  final before = plan(aways, lastDay);
  final after = plan(withAway, lastDay.add(Duration(days: length)));
  for (final choreId in {for (final t in before) t.choreId}) {
    final was = before.where((t) => t.choreId == choreId).toList();
    final now = after.where((t) => t.choreId == choreId).toList();
    for (var i = 0; i < was.length && i < now.length; i++) {
      final turn = was[i];
      if (turn.mateId != me || !span.overlaps(turn.day, turn.lastDay)) {
        continue;
      }
      effects.add(
        effect(choreId, turn.day, now[i].mateId, now[i].day, now[i].lastDay),
      );
    }
  }
  return effects;
}
