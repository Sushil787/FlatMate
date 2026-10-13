import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/features/chores/domain/chore_turns.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

void main() {
  final today = DateTime.utc(2026, 10, 7, 12);
  DateTime day(int offset) => today.add(Duration(days: offset));

  /// A real Turn; pass `id: null` for a projected one.
  Turn turn(
    int offset,
    int mate,
    TurnStatus status, {
    int choreId = 1,
    int? id = 1,
  }) => Turn(
    id: id == null ? null : uid(id),
    flatId: uid(10),
    choreId: uid(choreId),
    mateId: uid(mate),
    day: day(offset),
    lastDay: day(offset),
    status: status,
  );
  final chore = Chore(
    id: uid(1),
    flatId: uid(10),
    name: 'Bins',
    period: const Duration(days: 1),
    startDay: day(-3),
    rotation: [uid(1), uid(2), uid(3)],
    rotationIndex: 0,
    archived: false,
  );

  test('a Chore card: today\'s Turn, who is next, yesterday\'s Missed', () {
    final now = ChoreNow.of(chore, [
      turn(1, 3, TurnStatus.active),
      turn(-1, 1, TurnStatus.missed),
      turn(0, 2, TurnStatus.active),
      turn(0, 9, TurnStatus.active, choreId: 2), // another Chore's
    ], today);
    expect(now.turn!.mateId, uid(2));
    expect(now.dueToday, isTrue);
    expect(now.next!.mateId, uid(3));
    expect(now.missed!.mateId, uid(1));
  });

  test('a projected Turn today, not yet started on the server, is not due', () {
    final now = ChoreNow.of(chore, [
      turn(0, 2, TurnStatus.active, id: null),
    ], today);
    expect(now.isToday, isTrue);
    expect(now.dueToday, isFalse);
  });

  test('no Turn today: the card shows the next one, not due today', () {
    final now = ChoreNow.of(chore, [turn(2, 1, TurnStatus.active)], today);
    expect(now.turn!.mateId, uid(1));
    expect(now.isToday, isFalse);
    expect(now.next, isNull);
  });

  test('Chore detail: Turns done per Mate and Turn history', () {
    final history = ChoreHistory([
      turn(-2, 1, TurnStatus.done),
      turn(-1, 2, TurnStatus.missed),
      turn(0, 3, TurnStatus.active),
      turn(-5, 1, TurnStatus.done),
    ], today);
    expect(history.doneBy(uid(1)), 2);
    expect(history.doneBy(uid(2)), 0);
    expect(history.current!.mateId, uid(3));
    expect([for (final t in history.past) t.day], [day(-1), day(-2), day(-5)]);
  });
}
