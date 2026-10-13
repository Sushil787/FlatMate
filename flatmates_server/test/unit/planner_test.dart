import 'package:flatmates_server/src/day.dart';
import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:flatmates_server/src/rotation/planner.dart';
import 'package:serverpod/serverpod.dart' show UuidValue;
import 'package:test/test.dart';

final priya = UuidValue.fromString('00000000-0000-7000-8000-000000000001'),
    sam = UuidValue.fromString('00000000-0000-7000-8000-000000000002'),
    alex = UuidValue.fromString('00000000-0000-7000-8000-000000000003');
const week = Duration(days: 7);
final d0 = Day.of(2026, 10, 5);
DateTime day(int n) => Day.add(d0, n);

PlannerState state({
  List<UuidValue>? rotation,
  AwayRule rule = AwayRule.swap,
  Set<UuidValue>? active,
  List<AwaySpan> aways = const [],
}) => PlannerState(
  rotation: rotation ?? [priya, sam, alex],
  awayRule: rule,
  activeMateIds: active ?? {priya, sam, alex},
  aways: aways,
  debts: [],
);

/// Plans [count] consecutive weekly Turns from the start of the Rotation.
List<PlannedTurn> plan(PlannerState s, int count) {
  final turns = <PlannedTurn>[];
  var index = -1;
  var next = d0;
  for (var i = 0; i < count; i++) {
    final t = planNextTurn(s, index, next)!;
    turns.add(t);
    index = t.rotationIndex;
    next = nextTurnDay(t.day, t.lastDay, week);
  }
  return turns;
}

void main() {
  group('Day', () {
    test('adding days never shifts the date, even across DST', () {
      var d = Day.of(2026, 1, 1);
      for (var i = 0; i < 400; i++) {
        d = Day.add(d, 1);
        expect(d.hour, 12);
      }
      expect(d, Day.of(2027, 2, 5));
    });

    test('a day starts and ends at local midnight', () {
      final d = Day.of(2026, 10, 18);
      expect(
        Day.start('Asia/Kathmandu', d),
        DateTime.utc(2026, 10, 17, 18, 15),
      );
      expect(Day.end('Asia/Kathmandu', d), DateTime.utc(2026, 10, 18, 18, 15));
      // The day clocks go back in Berlin is 25 hours long.
      final dst = Day.of(2026, 10, 25);
      expect(
        Day.end(
          'Europe/Berlin',
          dst,
        ).difference(Day.start('Europe/Berlin', dst)),
        const Duration(hours: 25),
      );
    });
  });

  test('a Turn is one day, and the next is one period later', () {
    final turns = plan(state(), 4);
    expect(turns.map((t) => t.mateId), [priya, sam, alex, priya]);
    expect(turns[0].day, d0);
    expect(turns[0].lastDay, d0);
    expect(turns[1].day, day(7));
    expect(turns[1].lastDay, day(7));
  });

  test('Away between Turns does not affect them', () {
    final s = state(aways: [AwaySpan(sam, day(1), day(6))]);
    expect(plan(s, 2)[1].mateId, sam);
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
    expect(planNextTurn(state(active: {}), -1, d0), isNull);
  });

  group('Swap', () {
    test('next Mate covers, then the Away Mate takes their Turn back', () {
      final s = state(aways: [AwaySpan(sam, day(7), day(7))]);
      final turns = plan(s, 4);
      expect(turns.map((t) => t.mateId), [priya, alex, sam, priya]);
      expect(turns[1].coveringForMateId, sam);
      expect(turns[2].coveringForMateId, alex);
      expect(s.debts, isEmpty);
    });

    test('repayment waits while the debtor is still Away', () {
      final s = state(aways: [AwaySpan(sam, day(7), day(20))]);
      final turns = plan(s, 6);
      // Sam is away for both Sam's and Alex's days, so Sam repays on
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
          AwaySpan(sam, day(7), day(8)),
          AwaySpan(priya, day(7), day(13)),
        ],
      );
      final turn = plan(s, 2)[1];
      expect(turn.mateId, sam);
      expect(turn.day, day(9));
      expect(turn.lastDay, day(9));
    });
  });

  group('Skip', () {
    test('the next Mate does it and nothing is owed', () {
      final s = state(
        rule: AwayRule.skip,
        aways: [AwaySpan(sam, day(7), day(7))],
      );
      final turns = plan(s, 4);
      expect(turns.map((t) => t.mateId), [priya, alex, priya, sam]);
      expect(turns[1].coveringForMateId, isNull);
      expect(s.debts, isEmpty);
    });
  });

  group('Pause', () {
    test('a Turn starting while Away waits for the day after the return', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(6), day(9))],
      );
      final turn = plan(s, 2)[1];
      expect(turn.mateId, sam);
      expect(turn.day, day(10));
      expect(turn.lastDay, day(10));
    });

    test('a Turn in progress is extended by the Away days', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(7), day(9))],
      );
      final span = pauseSpan(s, sam, day(7), day(7), canMoveStart: false);
      expect(span.day, day(7));
      expect(span.lastDay, day(10));
    });

    test('the Rotation carries on one period after the paused Turn', () {
      final s = state(
        rule: AwayRule.pause,
        aways: [AwaySpan(sam, day(6), day(9))],
      );
      final turns = plan(s, 3);
      expect(turns[2].mateId, alex);
      expect(turns[2].day, day(17));
    });

    test('a Turn extended past its period delays the next one', () {
      expect(nextTurnDay(day(7), day(20), week), day(21));
    });
  });
}
