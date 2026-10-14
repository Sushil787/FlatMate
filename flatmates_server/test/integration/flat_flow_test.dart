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

    Future<Chore> createChore(
      TestSessionBuilder who,
      String name,
      Duration period,
      DateTime startDay,
      List<UuidValue> rotation, [
      TurnTime turnTime = TurnTime.evening,
    ]) => endpoints.chore.create(
      who,
      name,
      period,
      startDay,
      rotation,
      turnTime,
    );

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
      final turns = await endpoints.chore.currentTurns(priya);
      expect(turns, hasLength(1));
      return turns.single;
    }

    test('the creator is the admin and everyone is a mate', () async {
      final mine = await endpoints.flat.mine(alex);
      expect(mine!.flat.adminMateId, priyaId);
      expect(mine.mates.map((m) => m.displayName), ['Priya', 'Sam', 'Alex']);
    });

    test('a new Mate has not onboarded until they finish, once', () async {
      expect((await endpoints.flat.mine(sam))!.me.onboardedAt, isNull);
      final first = await endpoints.flat.finishOnboarding(sam);
      expect(first.onboardedAt, isNotNull);
      final again = await endpoints.flat.finishOnboarding(sam);
      expect(again.onboardedAt, first.onboardedAt);
      // Only Sam's own Mate changes.
      expect((await endpoints.flat.mine(alex))!.me.onboardedAt, isNull);
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
      final bins = await createChore(
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
        createChore(sam, 'Bins', week, today(), [samId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test(
      'a Turn whose day is over hands over even if its end call never ran',
      () async {
        await createChore(
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
      await createChore(
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
      await createChore(
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
      await createChore(
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
      await createChore(
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
      await createChore(
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

    test('a Mate can\'t be Away twice on the same day', () async {
      await endpoints.away.create(sam, today(3), today(5));
      await expectLater(
        endpoints.away.create(sam, today(5), today(6)),
        throwsA(isA<FlatmatesException>()),
      );
      // Someone else's Away on those days is fine.
      await endpoints.away.create(alex, today(3), today(5));
      expect(await endpoints.away.list(priya), hasLength(2));
    });

    test(
      'turnsBetween lists real Turns only; currentTurns the latest',
      () async {
        final bins = await createChore(
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
        expect(turns.map((t) => t.mateId), [priyaId]);
        expect(turns.single.id, isNotNull);

        final current = await endpoints.chore.currentTurns(priya);
        expect(current.single.choreId, bins.id);
        await endpoints.chore.markDone(priya, current.single.id!);
        // Still today's Turn once it's Done: the app projects from it.
        expect(
          (await endpoints.chore.currentTurns(priya)).single.status,
          TurnStatus.done,
        );
      },
    );

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
      await createChore(
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
        createChore(priya, 'Bins', week, today(-1), [priyaId]),
        throwsA(isA<FlatmatesException>()),
      );
    });

    test('a turn ends at midnight in the flat\'s timezone', () async {
      await createChore(priya, 'Bins', week, today(), [priyaId]);
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
      expect(
        [for (final g in await endpoints.notice.gotIts(priya)) g.mateId],
        [
          alexId,
        ],
      );
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
        for (final t in await endpoints.chore.currentTurns(priya)) {
          await call(sessionBuilder, t.id!);
        }
      }

      /// Moves the Flat to a fixed offset where it's [minutes] after
      /// midnight now, and returns that day.
      Future<DateTime> clockAt(int minutes) async {
        final now = DateTime.now().toUtc();
        var shift = minutes - (now.hour * 60 + now.minute);
        if (shift <= -12 * 60) shift += 24 * 60;
        if (shift > 12 * 60) shift -= 24 * 60;
        final offset =
            '${shift < 0 ? '-' : '+'}'
            '${(shift.abs() ~/ 60).toString().padLeft(2, '0')}'
            '${(shift.abs() % 60).toString().padLeft(2, '0')}';
        await Flat.db.updateRow(
          sessionBuilder.build(),
          flat.flat..timezone = offset,
        );
        return Day.today(offset);
      }

      /// Makes daily Chores starting [day], one per (name, Mate, Turn time).
      Future<List<Chore>> chores(
        DateTime day,
        List<(String, UuidValue, TurnTime)> list,
      ) async => [
        for (final (name, mate, time) in list)
          await createChore(
            priya,
            name,
            const Duration(days: 1),
            day,
            [mate],
            time,
          ),
      ];

      Future<void> markDone(TestSessionBuilder who, Chore chore) async {
        final turn = (await endpoints.chore.currentTurns(
          who,
        )).singleWhere((t) => t.choreId == chore.id);
        await endpoints.chore.markDone(who, turn.id!);
      }

      test('a Turn time starts with one push per Mate', () async {
        final day = await clockAt(16 * 60 + 50);
        await chores(day, [
          ('Bins', samId, TurnTime.evening),
          ('Dishes', samId, TurnTime.evening),
          ('Hoover', alexId, TurnTime.evening),
          // Its Turn time is over: announced on creation, not now.
          ('Plants', samId, TurnTime.morning),
        ]);
        Notifier.sent!.clear();

        await runAll(endpoints.futureCalls.turnCalls.started);
        expect(
          {for (final p in Notifier.sent!) p.mateId: p.title},
          {samId: 'Your Turns this evening', alexId: 'Your Turn: Hoover'},
        );
        expect(Notifier.sent, hasLength(2));
      });

      test('the reminder comes an hour before the Turn time ends, for '
          'Turns not Done', () async {
        final day = await clockAt(19 * 60 + 55);
        final list = await chores(day, [
          ('Bins', samId, TurnTime.evening),
          ('Dishes', samId, TurnTime.evening),
          ('Hoover', alexId, TurnTime.evening),
          ('Mop', alexId, TurnTime.evening),
          // Its reminder was this morning.
          ('Plants', samId, TurnTime.morning),
        ]);
        await markDone(alex, list[3]);
        Notifier.sent!.clear();

        await runAll(endpoints.futureCalls.turnCalls.reminder);
        expect(Notifier.sent, [
          (
            mateId: samId,
            title: 'Bins, Dishes: 1 hour left this evening',
            body: 'Done already? Tap to tell your Mates.',
          ),
          (
            mateId: alexId,
            title: 'Hoover: 1 hour left this evening',
            body: 'Done already? Tap to tell your Mates.',
          ),
        ]);
      });

      test(
        'at 18:00 Mates hear about earlier Turns not Done, unless Away',
        () async {
          final day = await clockAt(17 * 60 + 55);
          final list = await chores(day, [
            ('Bins', samId, TurnTime.morning),
            ('Hoover', alexId, TurnTime.afternoon),
            ('Mop', alexId, TurnTime.afternoon),
            // Still has its Turn time to go.
            ('Dishes', samId, TurnTime.evening),
          ]);
          await markDone(alex, list[2]);
          await Away.db.insertRow(
            sessionBuilder.build(),
            Away(
              flatId: flat.flat.id!,
              mateId: priyaId,
              startDay: day,
              lastDay: day,
            ),
          );
          Notifier.sent!.clear();

          await runAll(endpoints.futureCalls.turnCalls.matesNotDone);
          expect(Notifier.sent, [
            (mateId: samId, title: 'Not Done yet', body: 'Alex: Hoover.'),
            (mateId: alexId, title: 'Not Done yet', body: 'Sam: Bins.'),
          ]);
        },
      );

      test(
        'the night summary tells everyone who wants it about the day',
        () async {
          final day = await clockAt(21 * 60 + 55);
          final list = await chores(day, [
            ('Bins', samId, TurnTime.evening),
            ('Hoover', alexId, TurnTime.morning),
            ('Recycling', alexId, TurnTime.night),
          ]);
          await markDone(sam, list[0]);
          await endpoints.flat.setNotifications(
            priya,
            turnStarts: true,
            reminder: true,
            notice: true,
            addedToRotation: true,
            nightSummary: false,
          );
          Notifier.sent!.clear();

          await runAll(endpoints.futureCalls.turnCalls.nightSummary);
          expect(Notifier.sent, [
            (
              mateId: samId,
              title: 'Today in Elm St',
              body:
                  'Done: Bins (you). Not Done: Hoover (Alex). '
                  'Still tonight: Recycling (Alex).',
            ),
            (
              mateId: alexId,
              title: 'Today in Elm St',
              body:
                  'Done: Bins (Sam). Not Done: Hoover (you). '
                  'Still tonight: Recycling (you).',
            ),
          ]);
        },
      );

      test('a Done tells nobody, and neither does a Missed', () async {
        await createChore(priya, 'Bins', week, today(), [samId]);
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

    test('a Done can be undone only by its mate, on its day', () async {
      await createChore(priya, 'Bins', week, today(), [priyaId]);
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
      await createChore(
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
  });
}
