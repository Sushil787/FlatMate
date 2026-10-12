import 'package:intl/intl.dart';

import 'day.dart';

/// Human-friendly date, time and duration text.
abstract final class Fmt {
  static String dateTime(DateTime t) =>
      DateFormat('EEE d MMM · HH:mm').format(t.toLocal());

  static String day(DateTime t) => DateFormat('EEE d MMM').format(t.toLocal());

  /// A range of stored days (see day.dart): "Sun 18 Oct" or
  /// "Sun 18 Oct → Tue 20 Oct".
  static String days(DateTime first, DateTime last) {
    final a = day(Day.local(first));
    return first == last ? a : '$a → ${day(Day.local(last))}';
  }

  static String time(DateTime t) => DateFormat('HH:mm').format(t.toLocal());

  static String monthYear(DateTime t) => DateFormat('MMMM y').format(t);

  /// "1 week", "3 days".
  static String period(Duration d) {
    if (d.inDays >= 7 && d.inDays % 7 == 0) {
      final w = d.inDays ~/ 7;
      return w == 1 ? '1 week' : '$w weeks';
    }
    return d.inDays == 1 ? '1 day' : '${d.inDays} days';
  }

  /// "2d 4h", "3h", "45m": time left until [t].
  static String remaining(DateTime t, {DateTime? now}) {
    final d = t.difference(now ?? DateTime.now());
    if (d.isNegative) return '0m';
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    final h = d.inHours % 24;
    return '${d.inDays}d${h > 0 ? ' ${h}h' : ''}';
  }

  /// "just now", "5m ago", "3h ago", or the date.
  static String ago(DateTime t) {
    final d = DateTime.now().difference(t.toLocal());
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    if (d.inDays < 7) return '${d.inDays}d ago';
    return day(t);
  }

  /// "Sam", "Sam and Priya", "Sam, Priya and Jonas".
  static String and(List<String> names) => names.length < 2
      ? names.join()
      : '${names.sublist(0, names.length - 1).join(', ')} and ${names.last}';

  static String greeting([DateTime? now]) {
    final h = (now ?? DateTime.now()).hour;
    if (h < 12) return 'Good morning';
    if (h < 18) return 'Good afternoon';
    return 'Good evening';
  }
}
