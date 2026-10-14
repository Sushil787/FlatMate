import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';

/// The planned Turns (no id) of every Chore up to the day [until], each
/// Chore's starting after its latest real Turn in [current]. Uses the same
/// planner as the server, so they match the Turns it will create.
List<Turn> plannedTurns({
  required List<Chore> chores,
  required Iterable<Turn> current,
  required AwayRule awayRule,
  required Iterable<Mate> mates,
  required List<Away> aways,
  required List<SwapDebt> debts,
  required DateTime until,
}) {
  final latest = <UuidValue, Turn>{};
  for (final t in current) {
    final seen = latest[t.choreId];
    if (seen == null || t.day.isAfter(seen.day)) latest[t.choreId] = t;
  }
  final activeMateIds = {for (final m in mates) m.id!};
  final spans = [
    for (final a in aways) AwaySpan(a.mateId, a.startDay, a.lastDay),
  ];
  return [
    for (final chore in chores)
      if (latest[chore.id] case final turn?)
        for (final plan in projectChoreTurns(
          PlannerState(
            rotation: chore.rotation,
            awayRule: awayRule,
            activeMateIds: activeMateIds,
            aways: spans,
            debts: [
              for (final d in debts)
                if (d.choreId == chore.id)
                  Debt(d.debtorMateId, d.creditorMateId),
            ],
          ),
          rotationIndex: chore.rotationIndex,
          period: chore.period,
          day: turn.day,
          lastDay: turn.lastDay,
          until: until,
        ))
          Turn(
            flatId: chore.flatId,
            choreId: chore.id!,
            mateId: plan.mateId,
            coveringForMateId: plan.coveringForMateId,
            day: plan.day,
            lastDay: plan.lastDay,
            status: TurnStatus.active,
          ),
  ];
}
