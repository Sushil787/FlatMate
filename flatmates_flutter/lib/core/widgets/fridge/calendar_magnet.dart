import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';
import 'magnet_screen.dart';
import 'note.dart';

/// What a day on the calendar has: an Event, someone Away, or the end of
/// one of your Turns.
enum CalendarMark { event, away, turn }

/// This week, Monday to Sunday, on a strip torn from a wall calendar, with
/// a dot for each kind of entry a day has.
class CalendarMagnet extends StatelessWidget {
  const CalendarMagnet({
    super.key,
    required this.today,
    this.marks = const {},
    this.color,
    this.tilt = 0,
    this.onTap,
  });

  final DateTime today;

  /// Keyed by local date (no time of day).
  final Map<DateTime, Set<CalendarMark>> marks;

  /// The magnets' colour, which today is circled in too.
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;

  static const _weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  /// Lines of the printed grid.
  static const _grid = Color(0x1F1E2235);

  /// The start of [today]'s week, the key for its first day in [marks].
  static DateTime mondayOf(DateTime today) {
    final day = DateUtils.dateOnly(today);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    final f = context.fridge;
    final c = color ?? f.calendar;
    final markColor = {
      CalendarMark.event: c,
      CalendarMark.away: const Color(0xFFF59E0B),
      CalendarMark.turn: f.chores,
    };
    final day = DateUtils.dateOnly(today);
    final monday = mondayOf(today);
    return Note(
      section: FridgeSection.calendar,
      tilt: tilt,
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
      pins: [
        (0.02, Magnet.smiley(color: c)),
        (0.98, Magnet.smiley(color: c)),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'This week',
              style: NoteText.title.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 1, color: _grid),
          const SizedBox(height: 4),
          IntrinsicHeight(
            child: Row(
              children: [
                for (var i = 0; i < 7; i++) ...[
                  if (i > 0)
                    const VerticalDivider(width: 1, thickness: 1, color: _grid),
                  Expanded(
                    child: _Day(
                      weekday: _weekdays[i],
                      date: DateUtils.addDaysToDate(monday, i),
                      isToday: i == day.weekday - 1,
                      marks: [
                        for (final m in CalendarMark.values)
                          if (marks[DateUtils.addDaysToDate(monday, i)]
                                  ?.contains(m) ??
                              false)
                            markColor[m]!,
                      ],
                      color: c,
                    ),
                  ),
                ],
              ],
            ),
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

  /// The colours of the day's marks, in [CalendarMark] order.
  final List<Color> marks;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekday, style: NoteText.eyebrow.copyWith(letterSpacing: 0)),
        const SizedBox(height: 4),
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          // Circled in pen.
          decoration: isToday
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                )
              : null,
          child: Text(
            '${date.day}',
            style: NoteText.small.copyWith(
              fontSize: 14,
              color: NoteText.ink,
              fontWeight: FontWeight.w800,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3,
            children: [
              for (final m in marks)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: m),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
