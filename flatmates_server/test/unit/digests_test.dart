import 'package:flatmates_server/src/notify/digests.dart';
import 'package:test/test.dart';

void main() {
  test('one Turn in the morning reads as that Turn', () {
    expect(
      morningPush([(chore: 'Bins', coveringFor: null)], due: 'in 16h'),
      (title: 'Your Turn: Bins', body: 'It\'s yours, due in 16h.'),
    );
    expect(
      morningPush([(chore: 'Bins', coveringFor: 'Sam')], due: 'in 16h'),
      (title: 'You\'re covering: Bins', body: 'Doing Sam\'s turn, due in 16h.'),
    );
  });

  test('several Turns in the morning make one push', () {
    expect(
      morningPush([
        (chore: 'Bins', coveringFor: null),
        (chore: 'Dishes', coveringFor: 'Sam'),
      ], due: 'in 16h'),
      (title: 'Your Turns today', body: 'Bins, Dishes (covering Sam)'),
    );
  });

  test('the evening push lists my Turns, then my Mates\' ones', () {
    final others = {
      'Sam': ['Hoover'],
      'Alex': ['Bins', 'Mop'],
    };
    expect(
      eveningPush(['Dishes'], const {}, hoursLeft: 3),
      (
        title: '3 hours left for Dishes',
        body: 'Done already? Tap to tell your Mates.',
      ),
    );
    expect(
      eveningPush(['Dishes', 'Plants'], others, hoursLeft: 3),
      (
        title: '3 hours left for Dishes, Plants',
        body: 'Also not Done yet: Sam (Hoover), Alex (Bins, Mop)',
      ),
    );
    expect(
      eveningPush(const [], others, hoursLeft: 3),
      (
        title: 'Not Done yet',
        body: 'Sam (Hoover), Alex (Bins, Mop). 3 hours left.',
      ),
    );
    expect(eveningPush(const [], const {}, hoursLeft: 3), isNull);
  });
}
