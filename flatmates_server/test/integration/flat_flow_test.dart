import 'package:flatmates_server/src/day.dart';
import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:flatmates_server/src/rotation/turn_service.dart';
import 'package:flatmates_server/src/updated_at.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const week = Duration(days: 7);
const tz = 'Asia/Kathmandu';
DateTime today([int plus = 0]) => Day.add(Day.today(tz), plus);

void main() {
  withServerpod('Given a flat with three mates', (sessionBuilder, endpoints) {
    TestSessionBuilder as(String uuid) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(uuid, {}),
    );

    final priya = as('00000000-0000-4000-8000-000000000001');
    final sam = as('00000000-0000-4000-8000-000000000002');
    final alex = as('00000000-0000-4000-8000-000000000003');

    late MyFlat flat;
    late int priyaId, samId, alexId;

    setUp(() async {
      flat = await endpoints.flat.create(priya, 'Elm St', 'Priya', tz);
      priyaId = flat.me.id!;
      samId = (await endpoints.flat.join(
        sam,
        flat.flat.inviteCode,
        'Sam',
      )).me.id!;
      alexId = (await endpoints.flat.join(
        alex,
        flat.flat.inviteCode,
        'Alex',
      )).me.id!;
    });

    /// Ends the Turn now, as the scheduled end call would, by moving it to
    /// yesterday.
    Future<void> endTurn(Turn turn) async {
      final session = sessionBuilder.build();
      turn
        ..day = today(-1)
        ..lastDay = today(-1);
      await Turn.db.updateRow(session, turn);
      await endpoints.futureCalls.turnCalls.ended(sessionBuilder, turn.id!);
    }

    Future<Turn> onlyActiveTurn() async {
      final turns = await endpoints.chore.activeTurns(priya);
      expect(turns, hasLength(1));
      return turns.single;
    }

    test('the creator is the admin and everyone is a mate', () async {
      final mine = await endpoints.flat.mine(alex);
      expect(mine!.flat.adminMateId, priyaId);
      expect(mine.mates.map((m) => m.displayName), ['Priya', 'Sam', 'Alex']);
    });

    test('a wrong invite code is rejected', () async {
      final stranger = as('00000000-0000-4000-8000-000000000009');
      await expectLater(
        endpoints.flat.join(stranger, 'NOPE00', 'Jo'),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('only the admin can create chores', () async {
      await expectLater(
        endpoints.chore.create(sam, 'Bins', week, today(), [samId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('turns pass round-robin and a missed turn is marked', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [priyaId, samId, alexId],
      );
      var turn = await onlyActiveTurn();
      expect(turn.mateId, priyaId);

      await endpoints.chore.markDone(priya, turn.id!);
      await endTurn(
        (await Turn.db.findById(sessionBuilder.build(), turn.id!))!,
      );

      turn = await onlyActiveTurn();
      expect(turn.mateId, samId);
      await endTurn(turn);

      final missed = await Turn.db.findById(sessionBuilder.build(), turn.id!);
      expect(missed!.status, TurnStatus.missed);
      expect((await onlyActiveTurn()).mateId, alexId);
    });

    test('only the turn\'s mate can mark it done', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [priyaId, samId],
      );
      final turn = await onlyActiveTurn();
      await expectLater(
        endpoints.chore.markDone(sam, turn.id!),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('Swap: going Away hands the turn over and it is paid back', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId, priyaId],
      );
      await endpoints.away.create(sam, today(), today(1));

      var turn = await onlyActiveTurn();
      expect(turn.mateId, alexId);
      expect(turn.coveringForMateId, samId);

      // Time passes: Sam is back before the next Turn starts.
      final session = sessionBuilder.build();
      final away = (await Away.db.find(session)).single;
      away
        ..startDay = today(-3)
        ..lastDay = today(-2);
      await Away.db.updateRow(session, away);

      await endTurn(turn);
      // Alex's own slot comes next; Sam does it to pay Alex back.
      turn = await onlyActiveTurn();
      expect(turn.mateId, samId);
      expect(turn.coveringForMateId, alexId);
    });

    test('Skip: the next mate takes the turn and nothing is owed', () async {
      await endpoints.flat.setAwayRule(priya, AwayRule.skip);
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId, priyaId],
      );
      await endpoints.away.create(sam, today(), today());

      var turn = await onlyActiveTurn();
      expect(turn.mateId, alexId);
      expect(turn.coveringForMateId, isNull);

      // Turns last a day and start one Rotation period apart.
      expect(turn.day, today());
      expect(turn.lastDay, today());
      await endTurn(turn);
      final next = await onlyActiveTurn();
      expect(next.mateId, priyaId);
      expect(next.day, today(-1 + 7));
    });

    test('Pause: Away in the middle of a turn extends it', () async {
      await endpoints.flat.setAwayRule(priya, AwayRule.pause);
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId],
      );
      await endpoints.away.create(sam, today(), today(2));

      final after = await onlyActiveTurn();
      expect(after.mateId, samId);
      expect(after.day, today());
      expect(after.lastDay, today(3));
    });

    test('Away can\'t be backdated', () async {
      await expectLater(
        endpoints.away.create(sam, today(-2), today()),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('the calendar includes projected turns', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [priyaId, samId, alexId],
      );
      final turns = await endpoints.chore.turnsBetween(
        priya,
        today(),
        today(27),
      );
      expect(turns.map((t) => t.mateId), [priyaId, samId, alexId, priyaId]);
      expect(turns.first.id, isNotNull);
      expect(turns.skip(1).every((t) => t.id == null), isTrue);
    });

    test('the admin can\'t leave without handing over the role', () async {
      await expectLater(
        endpoints.flat.leave(priya),
        throwsA(isA<FlatmatesException>()),
      );
      await endpoints.flat.transferAdmin(priya, samId);
      await endpoints.flat.leave(priya);
      expect(await endpoints.flat.mine(priya), isNull);
      expect((await endpoints.flat.mine(sam))!.flat.adminMateId, samId);
    });

    test('a leaving mate\'s turn goes to the next mate', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId, priyaId],
      );
      await endpoints.flat.leave(sam);
      expect((await onlyActiveTurn()).mateId, alexId);
    });

    test('a chore\'s first turn can\'t be in the past', () async {
      await expectLater(
        endpoints.chore.create(priya, 'Bins', week, today(-1), [priyaId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('a turn ends at midnight in the flat\'s timezone', () async {
      await endpoints.chore.create(priya, 'Bins', week, today(), [priyaId]);
      final turn = await onlyActiveTurn();
      final (:start, :end) = TurnService.instants(flat.flat, turn);
      // Kathmandu is UTC+05:45, so local midnight is 18:15 UTC.
      expect((start.hour, start.minute), (18, 15));
      expect(end.difference(start), const Duration(days: 1));
    });

    test('updatedAt is set by the database on every update', () async {
      final session = sessionBuilder.build();
      await installUpdatedAtTriggers(session);
      final notice = await Notice.db.insertRow(
        session,
        Notice(
          flatId: flat.flat.id!,
          mateId: priyaId,
          text: 'Hi',
          pinned: false,
          updatedAt: DateTime.utc(2000),
        ),
      );
      await Notice.db.updateRow(session, notice..text = 'Hello');
      final saved = await Notice.db.findById(session, notice.id!);
      expect(saved!.updatedAt.isAfter(DateTime.utc(2001)), isTrue);
    });

    test('grocery items can be bought and notices pinned', () async {
      final item = await endpoints.grocery.add(sam, 'Milk', '2L');
      await endpoints.grocery.setBought(alex, item.id!, true);
      final items = await endpoints.grocery.list(priya);
      expect(items.single.boughtByMateId, alexId);

      final a = await endpoints.notice.post(sam, 'Party Saturday');
      await endpoints.notice.post(alex, 'Wifi is down');
      await endpoints.notice.setPinned(priya, a.id!, true);
      final notices = await endpoints.notice.list(sam);
      expect(notices.map((n) => n.text), ['Party Saturday', 'Wifi is down']);
    });
  });
}
