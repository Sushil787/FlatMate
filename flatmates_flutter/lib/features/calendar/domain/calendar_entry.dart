import 'package:flatmates_client/flatmates_client.dart';

import '../../../core/utils/day.dart';

/// Something shown on the calendar.
sealed class CalendarEntry {
  const CalendarEntry();

  DateTime get start;
  DateTime get end;

  /// Whether this entry should be listed under [day] (local time).
  bool isOn(DateTime day);
}

class TurnEntry extends CalendarEntry {
  const TurnEntry(this.turn, this.choreName);

  final Turn turn;
  final String choreName;

  /// Projected Turns aren't stored yet, so they have no id.
  bool get isPlanned => turn.id == null;

  @override
  DateTime get start => turn.startsAt.toLocal();
  @override
  DateTime get end => turn.endsAt.toLocal();

  /// Turns longer than a day show on their first and last day only, so a
  /// weekly chore doesn't fill every cell.
  @override
  bool isOn(DateTime day) {
    if (!_overlaps(start, end, day)) return false;
    if (end.difference(start) <= const Duration(days: 1)) return true;
    return _sameDay(start, day) || _sameDay(end, day);
  }
}

class AwayEntry extends CalendarEntry {
  const AwayEntry(this.away);

  final Away away;

  @override
  DateTime get start => away.startsAt.toLocal();
  @override
  DateTime get end => away.endsAt.toLocal();

  @override
  bool isOn(DateTime day) => _overlaps(start, end, day);
}

class EventEntry extends CalendarEntry {
  const EventEntry(this.event);

  final FlatEvent event;

  @override
  DateTime get start => event.startsAt.toLocal();
  @override
  DateTime get end => event.startsAt.toLocal();

  @override
  bool isOn(DateTime day) => _sameDay(start, day);
}

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool _overlaps(DateTime start, DateTime end, DateTime day) {
  final dayStart = DateTime(day.year, day.month, day.day);
  final dayEnd = dayStart.add(const Duration(days: 1));
  return start.isBefore(dayEnd) && end.isAfter(dayStart);
}
