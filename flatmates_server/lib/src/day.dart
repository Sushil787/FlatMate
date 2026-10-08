import 'dart:io';

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

  /// "+0545", "+05:45", "-3", "GMT+5:45": what some phones report instead
  /// of a zone name.
  static final _offset = RegExp(
    r'^(?:UTC|GMT)?([+-])(\d{1,2})(?::?(\d{2}))?$',
  );

  static tz.Location? _find(String timezone) {
    if (!_loaded) {
      tzdata.initializeTimeZones();
      _loaded = true;
    }
    if (timezone == 'UTC') return tz.UTC;
    try {
      return tz.getLocation(timezone);
    } on tz.LocationNotFoundException {
      final m = _offset.firstMatch(timezone);
      if (m == null) return null;
      final minutes = int.parse(m[2]!) * 60 + int.parse(m[3] ?? '0');
      final sign = m[1] == '-' ? -1 : 1;
      // ponytail: a fixed offset ignores daylight saving; right for places
      // without it (Nepal), an hour off half the year elsewhere. Phones
      // that send a zone name don't hit this.
      return tz.Location(
        timezone,
        [tz.minTime],
        [0],
        [
          tz.TimeZone(
            Duration(minutes: sign * minutes),
            isDst: false,
            abbreviation: timezone,
          ),
        ],
      );
    }
  }

  static tz.Location _location(String timezone) {
    final location = _find(timezone);
    if (location != null) return location;
    // Flat creation rejects these; one stored before that check would
    // otherwise silently run on UTC days.
    stderr.writeln('Unknown timezone "$timezone"; using UTC days.');
    return tz.UTC;
  }

  static bool isKnown(String timezone) => _find(timezone) != null;

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
