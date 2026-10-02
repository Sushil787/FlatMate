import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const week = Duration(days: 7);

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
      flat = await endpoints.flat.create(priya, 'Elm St', 'Priya', 'UTC');
      priyaId = flat.me.id!;
      samId = (await endpoints.flat.join(sam, flat.flat.inviteCode, 'Sam'))
          .me
          .id!;
      alexId = (await endpoints.flat.join(alex, flat.flat.inviteCode, 'Alex'))
          .me
          .id!;
    });

    /// Ends the Turn now, as the scheduled end call would.
    Future<void> endTurn(Turn turn) async {
      final session = sessionBuilder.build();
      turn.endsAt = DateTime.now().toUtc().subtract(const Duration(seconds: 10));
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
        endpoints.chore.create(sam, 'Bins', week, DateTime.now(), [samId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('turns pass round-robin and a missed turn is marked', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        DateTime.now(),
        [priyaId, samId, alexId],
      );
      var turn = await onlyActiveTurn();
      expect(turn.mateId, priyaId);

      await endpoints.chore.markDone(priya, turn.id!);
      await endTurn((await Turn.db.findById(sessionBuilder.build(), turn.id!))!);

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
        DateTime.now(),
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
        DateTime.now(),
        [samId, alexId, priyaId],
      );
      final now = DateTime.now().toUtc();
      await endpoints.away.create(
        sam,
        now.add(const Duration(days: 1)),
        now.add(const Duration(days: 2)),
      );

      var turn = await onlyActiveTurn();
      expect(turn.mateId, alexId);
      expect(turn.coveringForMateId, samId);

      // Time passes: Sam is back before the next Turn starts.
      final session = sessionBuilder.build();
      final away = (await Away.db.find(session)).single;
      away
        ..startsAt = now.subtract(const Duration(days: 3))
        ..endsAt = now.subtract(const Duration(days: 2));
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
        DateTime.now(),
        [samId, alexId, priyaId],
      );
      final now = DateTime.now().toUtc();
      await endpoints.away.create(sam, now, now.add(const Duration(days: 1)));

      var turn = await onlyActiveTurn();
      expect(turn.mateId, alexId);
      expect(turn.coveringForMateId, isNull);

      await endTurn(turn);
      expect((await onlyActiveTurn()).mateId, priyaId);
    });

    test('Pause: Away in the middle of a turn extends it', () async {
      await endpoints.flat.setAwayRule(priya, AwayRule.pause);
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        DateTime.now(),
        [samId, alexId],
      );
      final before = await onlyActiveTurn();
      final start = DateTime.now().toUtc().add(const Duration(days: 2));
      await endpoints.away.create(sam, start, start.add(const Duration(days: 3)));

      final after = await onlyActiveTurn();
      expect(after.mateId, samId);
      expect(after.endsAt.difference(before.endsAt), const Duration(days: 3));
    });

    test('Away can\'t be backdated', () async {
      final now = DateTime.now().toUtc();
      await expectLater(
        endpoints.away.create(sam, now.subtract(const Duration(days: 2)), now),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('the calendar includes projected turns', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        DateTime.now(),
        [priyaId, samId, alexId],
      );
      final now = DateTime.now().toUtc();
      final turns = await endpoints.chore.turnsBetween(
        priya,
        now,
        now.add(const Duration(days: 27)),
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
        DateTime.now(),
        [samId, alexId, priyaId],
      );
      await endpoints.flat.leave(sam);
      expect((await onlyActiveTurn()).mateId, alexId);
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
