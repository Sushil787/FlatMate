import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Calendar days (Turns, Chore start, Away) are stored as 12:00 UTC on that
/// date. Adding `Duration(days: n)` in UTC never crosses a DST change, so
/// the date can't drift. Read `.year/.month/.day`; never call `.toLocal()`.
abstract final class Day {
  static DateTime of(int year, int month, int day) =>
      DateTime.utc(year, month, day, 12);

  /// Normalises a day sent by the app (its date fields are the day).
  static DateTime from(DateTime d) => of(d.year, d.month, d.day);

  static DateTime add(DateTime day, int days) => day.add(Duration(days: days));

  static DateTime later(DateTime a, DateTime b) => a.isAfter(b) ? a : b;

  /// Days from [a] to [b].
  static int between(DateTime a, DateTime b) => b.difference(a).inDays;

  static bool _loaded = false;

  static tz.Location _location(String timezone) {
    if (!_loaded) {
      tzdata.initializeTimeZones();
      _loaded = true;
    }
    try {
      return tz.getLocation(timezone);
    } on tz.LocationNotFoundException {
      return tz.UTC;
    }
  }

  static bool isKnown(String timezone) =>
      _location(timezone) != tz.UTC || timezone == 'UTC';

  /// Today in [timezone].
  static DateTime today(String timezone) {
    final now = tz.TZDateTime.now(_location(timezone));
    return of(now.year, now.month, now.day);
  }

  /// The instant [day] begins (local midnight) in [timezone], in UTC.
  static DateTime start(String timezone, DateTime day) => tz.TZDateTime(
    _location(timezone),
    day.year,
    day.month,
    day.day,
  ).toUtc();

  /// The instant [day] ends (the next local midnight) in [timezone], in UTC.
  static DateTime end(String timezone, DateTime day) =>
      start(timezone, add(day, 1));
}
