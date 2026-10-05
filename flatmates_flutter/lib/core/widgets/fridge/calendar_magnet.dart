import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';

/// What a day on the calendar has: an Event, someone Away, or the end of
/// one of your Turns.
enum CalendarMark { event, away, turn }

/// This week, Monday to Sunday, with a dot for each kind of entry a day has.
class CalendarMagnet extends StatelessWidget {
  const CalendarMagnet({
    super.key,
    required this.today,
    this.marks = const {},
    this.color,
    this.tilt = 0,
    this.onTap,
    this.heroTag,
  });

  final DateTime today;

  /// Keyed by local date (no time of day).
  final Map<DateTime, Set<CalendarMark>> marks;
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;
  final Object? heroTag;

  /// Dot colours that read on the coloured plastic.
  static const markColor = {
    CalendarMark.event: Colors.white,
    CalendarMark.away: Color(0xFFFBBF24),
    CalendarMark.turn: Color(0xFF5EEAD4),
  };

  static const _weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  /// The start of [today]'s week, the key for its first day in [marks].
  static DateTime mondayOf(DateTime today) {
    final day = DateUtils.dateOnly(today);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.fridge.calendar;
    final day = DateUtils.dateOnly(today);
    final monday = mondayOf(today);
    return Magnet(
      color: c,
      tilt: tilt,
      onTap: onTap,
      heroTag: heroTag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('This week', style: MagnetText.title),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: _Day(
                    weekday: _weekdays[i],
                    date: DateUtils.addDaysToDate(monday, i),
                    isToday: i == day.weekday - 1,
                    marks:
                        marks[DateUtils.addDaysToDate(monday, i)] ?? const {},
                    color: c,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.weekday,
    required this.date,
    required this.isToday,
    required this.marks,
    required this.color,
  });

  final String weekday;
  final DateTime date;
  final bool isToday;
  final Set<CalendarMark> marks;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekday, style: MagnetText.eyebrow.copyWith(letterSpacing: 0)),
        const SizedBox(height: 4),
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: isToday
              ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
              : null,
          child: Text(
            '${date.day}',
            style: MagnetText.small.copyWith(
              color: isToday ? color : Colors.white,
              fontWeight: FontWeight.w800,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              for (final m in CalendarMark.values)
                if (marks.contains(m))
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CalendarMagnet.markColor[m],
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
