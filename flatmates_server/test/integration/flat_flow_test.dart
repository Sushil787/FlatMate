import 'package:flatmates_server/src/day.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:flatmates_server/src/notify/notifier.dart';
import 'package:flatmates_server/src/rotation/turn_service.dart';
import 'package:flatmates_server/src/updated_at.dart';
import 'package:serverpod/serverpod.dart' show UuidValue;
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
    late UuidValue priyaId, samId, alexId;

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

    test(
      'an Invite works for 7 days, then until the Admin makes a new one',
      () async {
        final mine = await endpoints.flat.mine(priya);
        expect(
          mine!.flat.inviteExpiresAt.difference(DateTime.now().toUtc()).inDays,
          6, // 6 days and 23-ish hours left
        );

        final session = sessionBuilder.build();
        await Flat.db.updateRow(
          session,
          mine.flat..inviteExpiresAt = DateTime.now().toUtc(),
        );
        final stranger = as('00000000-0000-4000-8000-000000000009');
        await expectLater(
          endpoints.flat.join(stranger, mine.flat.inviteCode, 'Jo'),
          throwsA(
            isA<FlatmatesException>().having(
              (e) => e.message,
              'message',
              contains('expired'),
            ),
          ),
        );

        final code = await endpoints.flat.regenerateInvite(priya);
        expect(
          (await endpoints.flat.join(stranger, code, 'Jo')).me.displayName,
          'Jo',
        );
      },
    );

    test('the admin welcomes a new mate into chores, once', () async {
      final mine = await endpoints.flat.mine(priya);
      expect(
        {for (final m in mine!.mates) m.displayName: m.welcomed},
        {'Priya': true, 'Sam': false, 'Alex': false},
      );
      final bins = await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [priyaId],
      );
      await expectLater(
        endpoints.flat.welcomeMate(sam, alexId, [bins.id!]),
        throwsA(isA<FlatmatesException>()),
      );

      await endpoints.flat.welcomeMate(priya, samId, [bins.id!]);
      // A second answer (the admin's other phone) changes nothing.
      await endpoints.flat.welcomeMate(priya, samId, [bins.id!]);
      await endpoints.flat.welcomeMate(priya, alexId, []);

      final chores = await endpoints.chore.list(priya);
      expect(chores.single.rotation, [priyaId, samId]);
      final after = await endpoints.flat.mine(priya);
      expect(after!.mates.every((m) => m.welcomed), isTrue);
    });

    test('only the admin can create chores', () async {
      await expectLater(
        endpoints.chore.create(sam, 'Bins', week, today(), [samId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test(
      'a Turn whose day is over hands over even if its end call never ran',
      () async {
        await endpoints.chore.create(
          priya,
          'Dishes',
          const Duration(days: 1),
          today(),
          [priyaId, samId],
        );
        final first = await onlyActiveTurn();
        // A day passes, but the scheduled end call doesn't fire (a restart, a
        // sleeping server).
        final session = sessionBuilder.build();
        await Turn.db.updateRow(
          session,
          first
            ..day = today(-1)
            ..lastDay = today(-1),
        );

        // Just asking for the Turns catches up: yesterday's is Missed and
        // today's has started.
        final now = await onlyActiveTurn();
        expect(now.day, today());
        expect(now.mateId, samId);
        final old = await Turn.db.findById(session, first.id!);
        expect(old!.status, TurnStatus.missed);

        // Asking again changes nothing.
        expect((await onlyActiveTurn()).id, now.id);
      },
    );

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

    test('mates say Got it on a notice, but not on their own', () async {
      final notice = await endpoints.notice.post(sam, 'Boiler check Friday');
      await endpoints.notice.gotIt(alex, notice.id!);
      await endpoints.notice.gotIt(alex, notice.id!);
      expect((await endpoints.notice.list(priya)).single.gotItMateIds, [
        alexId,
      ]);
      await expectLater(
        endpoints.notice.gotIt(sam, notice.id!),
        throwsA(isA<FlatmatesException>()),
      );
      await endpoints.notice.delete(sam, notice.id!);
      expect(await NoticeGotIt.db.count(sessionBuilder.build()), 0);
    });

    test('mates get free colours and can\'t take a taken one', () async {
      final mates = (await endpoints.flat.mine(priya))!.mates;
      expect(mates.map((m) => m.color), [
        MateColor.tomato,
        MateColor.sky,
        MateColor.plum,
      ]);
      await expectLater(
        endpoints.flat.setMyColor(sam, MateColor.tomato),
        throwsA(isA<FlatmatesException>()),
      );
      expect(
        (await endpoints.flat.setMyColor(sam, MateColor.leaf)).color,
        MateColor.leaf,
      );
    });

    test('a notification switched off is not sent', () async {
      await endpoints.flat.setNotifications(
        sam,
        turnStarts: false,
        reminder: true,
        matesNotDone: true,
        notice: true,
        addedToRotation: true,
      );
      final sent = await Notifier.toMates(
        sessionBuilder.build(),
        [samId, alexId],
        title: 'Your Turn: Bins',
        body: '',
        kind: NotifyKind.turnStarts,
      );
      expect(sent.map((m) => m.id), [alexId]);
    });

    group('with pushes collected', () {
      setUp(() => Notifier.sent = []);
      tearDown(() => Notifier.sent = null);

      /// Runs every active Turn's scheduled [call], as at its time.
      Future<void> runAll(
        Future<void> Function(TestSessionBuilder, UuidValue) call,
      ) async {
        for (final t in await endpoints.chore.activeTurns(priya)) {
          await call(sessionBuilder, t.id!);
        }
      }

      test('the morning summary is one push per Mate', () async {
        const day = Duration(days: 1);
        for (final (chore, mate) in [
          ('Bins', samId),
          ('Dishes', samId),
          ('Hoover', alexId),
        ]) {
          await endpoints.chore.create(priya, chore, day, today(), [mate]);
        }
        Notifier.sent!.clear(); // pushes on creation if it's past 8:00

        await runAll(endpoints.futureCalls.turnCalls.started);
        expect(
          {for (final p in Notifier.sent!) p.mateId: p.title},
          {samId: 'Your Turns today', alexId: 'Your Turn: Hoover'},
        );
        expect(Notifier.sent, hasLength(2));
      });

      test('the evening push tells each Mate what is not Done', () async {
        // A fixed offset where it's 19:00 now, before the 21:00 push.
        final now = DateTime.now().toUtc();
        var minutes = 19 * 60 - (now.hour * 60 + now.minute);
        if (minutes <= -12 * 60) minutes += 24 * 60;
        if (minutes > 12 * 60) minutes -= 24 * 60;
        final offset =
            '${minutes < 0 ? '-' : '+'}'
            '${(minutes.abs() ~/ 60).toString().padLeft(2, '0')}'
            '${(minutes.abs() % 60).toString().padLeft(2, '0')}';
        final session = sessionBuilder.build();
        await Flat.db.updateRow(session, flat.flat..timezone = offset);
        final day = Day.today(offset);

        late Chore mop;
        for (final (name, mate) in [
          ('Bins', samId),
          ('Dishes', samId),
          ('Hoover', alexId),
          ('Mop', alexId),
        ]) {
          mop = await endpoints.chore.create(
            priya,
            name,
            const Duration(days: 1),
            day,
            [mate],
          );
        }
        final mopTurn = (await endpoints.chore.activeTurns(
          alex,
        )).singleWhere((t) => t.choreId == mop.id);
        await endpoints.chore.markDone(alex, mopTurn.id!);
        // Priya is Away today, so she isn't told about anyone's Turns.
        await Away.db.insertRow(
          session,
          Away(
            flatId: flat.flat.id!,
            mateId: priyaId,
            startDay: day,
            lastDay: day,
          ),
        );
        Notifier.sent!.clear();

        await runAll(endpoints.futureCalls.turnCalls.reminder);
        expect(Notifier.sent, [
          (
            mateId: samId,
            title: '3 hours left for Bins, Dishes',
            body: 'Also not Done yet: Alex (Hoover)',
          ),
          (
            mateId: alexId,
            title: '3 hours left for Hoover',
            body: 'Also not Done yet: Sam (Bins, Dishes)',
          ),
        ]);
      });

      test('a Done tells nobody, and neither does a Missed', () async {
        await endpoints.chore.create(priya, 'Bins', week, today(), [samId]);
        final turn = await onlyActiveTurn();
        Notifier.sent!.clear();
        await endpoints.chore.markDone(sam, turn.id!);
        await endpoints.chore.undoDone(sam, turn.id!);
        await endTurn(turn);
        expect(
          Notifier.sent!.where((p) => p.mateId != samId),
          isEmpty,
        );
      });
    });

    test('only the admin moves the morning summary, to before 21:00', () async {
      await expectLater(
        endpoints.flat.setMorningSummaryAt(sam, 7 * 60),
        throwsA(isA<FlatmatesException>()),
      );
      await expectLater(
        endpoints.flat.setMorningSummaryAt(priya, 21 * 60),
        throwsA(isA<FlatmatesException>()),
      );
      final moved = await endpoints.flat.setMorningSummaryAt(priya, 7 * 60);
      expect(moved.morningSummaryAt, 7 * 60);
    });

    test('a Done can be undone only by its mate, on its day', () async {
      await endpoints.chore.create(priya, 'Bins', week, today(), [priyaId]);
      final turn = await onlyActiveTurn();
      await endpoints.chore.markDone(priya, turn.id!);
      await expectLater(
        endpoints.chore.undoDone(sam, turn.id!),
        throwsA(isA<FlatmatesException>()),
      );
      final undone = await endpoints.chore.undoDone(priya, turn.id!);
      expect((undone.status, undone.doneAt), (TurnStatus.active, null));

      await endpoints.chore.markDone(priya, turn.id!);
      final session = sessionBuilder.build();
      final done = (await Turn.db.findById(session, turn.id!))!
        ..day = today(-1)
        ..lastDay = today(-1);
      await Turn.db.updateRow(session, done);
      await expectLater(
        endpoints.chore.undoDone(priya, turn.id!),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('the admin renames the flat and mates rename themselves', () async {
      await expectLater(
        endpoints.flat.rename(sam, 'Oak'),
        throwsA(isA<FlatmatesException>()),
      );
      expect((await endpoints.flat.rename(priya, '  Oak  ')).name, 'Oak');
      expect(
        (await endpoints.flat.setMyName(sam, 'Samuel')).displayName,
        'Samuel',
      );
      await expectLater(
        endpoints.flat.setMyName(sam, '  '),
        throwsA(isA<FlatmatesException>()),
      );
      await expectLater(
        endpoints.flat.setMyName(sam, 'x' * 41),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('swap debts are listed for the flat', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId, priyaId],
      );
      await endpoints.away.create(sam, today(), today());
      final debts = await endpoints.chore.swapDebts(priya);
      expect(
        debts.map((d) => (d.debtorMateId, d.creditorMateId)),
        [(samId, alexId)],
      );
    });

    test('events overlapping the range are listed', () async {
      final start = DateTime.utc(2030, 1, 1);
      await endpoints.event.create(
        sam,
        'Guests',
        null,
        start,
        allDay: true,
        endsAt: start.add(const Duration(days: 3)),
        tellFlat: true,
      );
      await endpoints.event.create(
        alex,
        'Plumber',
        null,
        start,
        allDay: false,
        tellFlat: false,
      );
      final events = await endpoints.event.between(
        priya,
        start.add(const Duration(days: 1)),
        start.add(const Duration(days: 2)),
      );
      expect(events.map((e) => (e.title, e.allDay)), [('Guests', true)]);
      await expectLater(
        endpoints.event.create(
          sam,
          'Oops',
          null,
          start,
          allDay: false,
          endsAt: start,
          tellFlat: false,
        ),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('the Away preview shows covers and paused turns', () async {
      await endpoints.chore.create(
        priya,
        'Bins',
        week,
        today(),
        [samId, alexId, priyaId],
      );
      final bins = (await onlyActiveTurn()).choreId;

      // Sam's open Turn today, covered by Alex under Swap.
      var effects = await endpoints.away.preview(sam, today(), today(1));
      expect(
        effects.map((e) => (e.choreId, e.day, e.coverMateId, e.newDay)),
        [(bins, today(), alexId, null)],
      );

      // Alex's projected Turn next week waits under Pause.
      await endpoints.flat.setAwayRule(priya, AwayRule.pause);
      effects = await endpoints.away.preview(alex, today(7), today(8));
      expect(
        effects.map((e) => (e.day, e.awayRule, e.coverMateId, e.newDay)),
        [(today(7), AwayRule.pause, null, today(9))],
      );

      // Nothing was saved.
      expect(await endpoints.away.list(priya), isEmpty);
      expect((await onlyActiveTurn()).mateId, samId);
    });
  });
}
