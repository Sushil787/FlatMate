import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/features/away/domain/away_preview.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

void main() {
  final today = DateTime.utc(2026, 10, 7, 12);
  DateTime day(int n) => today.add(Duration(days: n));
  final sam = uid(2), alex = uid(3), priya = uid(1), bins = uid(50);

  Mate mate(UuidValue id) => Mate(
    id: id,
    flatId: uid(10),
    authUserId: id,
    displayName: '$id',
    joinedAt: today,
  );
  // Weekly, Sam has today's Turn.
  final chore = Chore(
    id: bins,
    flatId: uid(10),
    name: 'Bins',
    period: const Duration(days: 7),
    startDay: today,
    rotation: [sam, alex, priya],
    rotationIndex: 0,
    archived: false,
  );
  final samsTurn = Turn(
    id: uid(60),
    flatId: uid(10),
    choreId: bins,
    mateId: sam,
    day: today,
    lastDay: today,
    status: TurnStatus.active,
  );

  List<AwayEffect> preview(UuidValue me, int from, int to, AwayRule rule) =>
      previewAway(
        me: me,
        startDay: day(from),
        lastDay: day(to),
        today: today,
        chores: [chore],
        current: [samsTurn],
        awayRule: rule,
        mates: [mate(priya), mate(sam), mate(alex)],
        aways: const [],
        debts: const [],
      );

  test('an open Turn is covered by the next Mate under Swap', () {
    expect(
      preview(sam, 0, 1, AwayRule.swap).map(
        (e) => (e.choreId, e.day, e.coverMateId, e.newDay),
      ),
      [(bins, today, alex, null)],
    );
  });

  test('a planned Turn waits for its Mate under Pause', () {
    expect(
      preview(alex, 7, 8, AwayRule.pause).map(
        (e) => (e.day, e.awayRule, e.coverMateId, e.newDay),
      ),
      [(day(7), AwayRule.pause, null, day(9))],
    );
  });
}
