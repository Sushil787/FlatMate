import 'package:flatmates_server/src/notify/digests.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:test/test.dart';

void main() {
  test('one Turn at its start reads as that Turn', () {
    expect(
      startPush([(chore: 'Bins', coveringFor: null)], when: 'this evening'),
      (title: 'Your Turn: Bins', body: 'It\'s yours this evening.'),
    );
    expect(
      startPush([(chore: 'Bins', coveringFor: 'Sam')], when: 'today'),
      (title: 'You\'re covering: Bins', body: 'Doing Sam\'s Turn today.'),
    );
  });

  test('several Turns at one Turn time make one push', () {
    expect(
      startPush([
        (chore: 'Bins', coveringFor: null),
        (chore: 'Dishes', coveringFor: 'Sam'),
      ], when: 'this morning'),
      (title: 'Your Turns this morning', body: 'Bins, Dishes (covering Sam)'),
    );
  });

  test('the reminder names the Chores and the Turn time', () {
    expect(reminderPush(['Bins', 'Dishes'], TurnTime.night), (
      title: 'Bins, Dishes: 1 hour left tonight',
      body: 'Done already? Tap to tell your Mates.',
    ));
  });

  test('Mates\' Turns not Done list each Mate, or nothing', () {
    expect(
      matesNotDonePush({
        'Sam': ['Hoover'],
        'Alex': ['Bins', 'Mop'],
      }),
      (title: 'Not Done yet', body: 'Sam: Hoover. Alex: Bins, Mop.'),
    );
    expect(matesNotDonePush(const {}), isNull);
  });

  test('the night summary leaves out what is empty', () {
    expect(
      nightSummaryPush(
        'Elm St',
        done: [(chore: 'Bins', who: 'you')],
        notDone: const [],
        tonight: [(chore: 'Recycling', who: 'Sam')],
      ),
      (
        title: 'Today in Elm St',
        body: 'Done: Bins (you). Still tonight: Recycling (Sam).',
      ),
    );
    expect(
      nightSummaryPush('Elm St', done: [], notDone: [], tonight: []),
      isNull,
    );
  });

  test('every Turn time\'s pushes stay clear of the Flat-wide ones', () {
    final flatWide = {matesNotDoneAt, nightSummaryAt};
    for (final t in TurnTime.values) {
      expect(t.startsAt < t.remindAt && t.remindAt < t.endsAt, isTrue);
      expect(flatWide.intersection({t.startsAt, t.remindAt}), isEmpty);
    }
  });
}
