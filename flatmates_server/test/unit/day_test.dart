import 'package:flatmates_server/src/day.dart';
import 'package:test/test.dart';

void main() {
  test('a fixed offset some phones send works like the zone name', () {
    for (final offset in ['+0545', '+05:45', 'GMT+5:45']) {
      expect(Day.isKnown(offset), isTrue, reason: offset);
      expect(Day.today(offset), Day.today('Asia/Kathmandu'), reason: offset);
      expect(
        Day.start(offset, Day.of(2026, 10, 8)),
        DateTime.utc(2026, 10, 7, 18, 15),
        reason: offset,
      );
    }
    expect(
      Day.start('-0300', Day.of(2026, 10, 8)),
      DateTime.utc(2026, 10, 8, 3),
    );
  });

  test('a name that is neither a zone nor an offset is unknown', () {
    expect(Day.isKnown('Mars/Phobos'), isFalse);
    expect(Day.isKnown('UTC'), isTrue);
  });
}
