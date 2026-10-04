import 'package:flatmates_client/flatmates_client.dart';

/// Mirrors the server's day.dart: a calendar day travels as 12:00 UTC on
/// that date. Read its year/month/day; never call `.toLocal()` on it.
abstract final class Day {
  /// The day [d] falls on, in the phone's time.
  static DateTime fromLocal(DateTime d) =>
      DateTime.utc(d.year, d.month, d.day, 12);

  /// Local midnight at the start of [day].
  static DateTime local(DateTime day) => DateTime(day.year, day.month, day.day);

  /// Local midnight at the end of [day].
  static DateTime localEnd(DateTime day) =>
      DateTime(day.year, day.month, day.day + 1);
}

/// When a Turn starts and ends in the phone's time.
extension TurnTimes on Turn {
  DateTime get startsAt => Day.local(day);
  DateTime get endsAt => Day.localEnd(lastDay);
}

/// When an Away starts and ends in the phone's time.
extension AwayTimes on Away {
  DateTime get startsAt => Day.local(startDay);
  DateTime get endsAt => Day.localEnd(lastDay);
}
