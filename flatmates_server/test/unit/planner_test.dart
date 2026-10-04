import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:flatmates_server/src/rotation/planner.dart';
import 'package:test/test.dart';

const priya = 1, sam = 2, alex = 3;
const week = Duration(days: 7);
final t0 = DateTime.utc(2026, 10, 5);
DateTime day(int n) => t0.add(Duration(days: n));

PlannerState state({
  List<int> rotation = const [priya, sam, alex],
  AwayRule rule = AwayRule.swap,
  Set<int> active = const {priya, sam, alex},
  List<AwaySpan> aways = const [],
}) => PlannerState(
  rotation: rotation,
  period: week,
  awayRule: rule,
  activeMateIds: active,
  aways: aways,
  debts: [],
);

/// Plans [count] consecutive Turns from the start of the Rotation.
List<PlannedTurn> plan(PlannerState s, int count) {
  final turns = <PlannedTurn>[];
  var index = -1;
  var start = t0;
  for (var i = 0; i < count; i++) {
    final t = planNextTurn(s, index, start)!;
    turns.add(t);
    index = t.rotationIndex;
    start = t.endsAt;
  }
  return turns;
}

void main() {
  test('passes round-robin through the Rotation', () {
    final turns = plan(state(), 4);
    expect(turns.map((t) => t.mateId), [priya, sam, alex, priya]);
    expect(turns[1].startsAt, day(7));
    expect(turns[1].endsAt, day(14));
  });

  test('a Mate may appear more than once', () {
    final turns = plan(state(rotation: [priya, sam, priya]), 4);
    expect(turns.map((t) => t.mateId), [priya, sam, priya, priya]);
  });

  test('Mates who left the Flat are skipped', () {
    final turns = plan(state(active: {priya, alex}), 3);
    expect(turns.map((t) => t.mateId), [priya, alex, priya]);
  });

  test('returns null when nobody in the Rotation is left', () {
    expect(planNextTurn(state(active: {}), -1, t0), isNull);
  });

  group('Swap', () {
    test('next Mate covers, then the Away Mate takes their Turn back', () {
      final s = state(aways: [AwaySpan(sam, day(8), day(10))]);
      final turns = plan(s, 4);
      expect(turns.map((t) => t.mateId), [priya, alex, sam, priya]);
      expect(turns[1].coveringForMateId, sam);
      expect(turns[2].coveringForMateId, alex);
      expect(s.debts, isEmpty);
    });

    test('any overlap with the Turn counts', () {
      // Away only for the last hour of Sam's week.
      final s = state(
        aways: [AwaySpan(sam, day(14).subtract(const Duration(hours: 1)), day(15))],
      );
      expect(plan(s, 2)[1].mateId, alex);
    });

    test('repayment waits while the debtor is still Away', () {
      final s = state(aways: [AwaySpan(sam, day(7), day(21))]);
      final turns = plan(s, 6);
      // Sam is away for both Sam's and Alex's weeks, so Sam repays on
      // Alex's next slot after coming back.
      expect(turns.map((t) => t.mateId), [priya, alex, alex, priya, sam, sam]);
      expect(turns[4].coveringForMateId, isNull);
      expect(turns[5].coveringForMateId, alex);
    });

    test('with nobody free to cover, the Chore pauses', () {
      final s = state(
        rotation: [priya, sam],
        active: {priya, sam},
        aways: [
          AwaySpan(sam, day(7), day(9)),
          AwaySpan(priya, day(7), day(14)),
        ],
      );
      final turn = plan(s, 2)[1];
      expect(turn.mateId, sam);
      expect(turn.startsAt, day(9));
      expect(turn.endsAt, day(16));
    });
  });

  group('Skip', () {
    test('the next Mate does it and nothing is owed', () {
      final s = state(
        rule: AwayRule.skip,
        aways: [AwaySpan(sam, day(8), day(10))],
      );
      final turns = plan(s, 4);
      expect(turns.map((t) => t.mateId), [priya, alex, priya, sam]);
      expect(turns[1].coveringForMateId, isNull);
      expect(s.debts, isEmpty);
    });
  });

  group('Pause', () {
    test('a Turn starting while Away waits for the return', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(6), day(10))],
      );
      final turn = plan(s, 2)[1];
      expect(turn.mateId, sam);
      expect(turn.startsAt, day(10));
      expect(turn.endsAt, day(17));
    });

    test('Away in the middle of a Turn extends it by the Away days', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(9), day(12))],
      );
      final turn = plan(s, 2)[1];
      expect(turn.startsAt, day(7));
      expect(turn.endsAt, day(17));
    });

    test('the Rotation carries on after the paused Turn', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(6), day(10))],
      );
      final turns = plan(s, 3);
      expect(turns[2].mateId, alex);
      expect(turns[2].startsAt, day(17));
    });
  });
}
