import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';

/// "Fri 16 Oct", "Fri 16 to Mon 19 Oct" or "Fri 30 Oct to Mon 2 Nov" for
/// local days [first]..[last].
String dayRange(DateTime first, DateTime last) {
  final full = DateFormat('EEE d MMM');
  if (DateUtils.isSameDay(first, last)) return full.format(first);
  final sameMonth = first.year == last.year && first.month == last.month;
  final from = sameMonth
      ? DateFormat('EEE d').format(first)
      : full.format(first);
  return '$from to ${full.format(last)}';
}

/// Whole days from [a] to [b] (local midnights), safe across DST.
int daysBetween(DateTime a, DateTime b) => DateTime.utc(
  b.year,
  b.month,
  b.day,
).difference(DateTime.utc(a.year, a.month, a.day)).inDays;

/// A Monday-first month: weekday letters, then a [cell] for each day of
/// [month], blanks around it.
class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.month, required this.cell});

  final DateTime month;
  final Widget Function(DateTime day) cell;

  @override
  Widget build(BuildContext context) {
    final lead = DateTime(month.year, month.month).weekday - 1;
    final count = DateUtils.getDaysInMonth(month.year, month.month);
    final weeks = ((lead + count) / 7).ceil();
    Widget at(int i) {
      final d = i - lead + 1;
      return d < 1 || d > count
          ? const SizedBox.shrink()
          : cell(DateTime(month.year, month.month, d));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.only(bottom: Space.xs),
            child: Row(
              children: [
                for (final l in 'MTWTFSS'.split(''))
                  Expanded(
                    child: Text(
                      l,
                      textAlign: TextAlign.center,
                      style: context.text.labelMedium?.copyWith(
                        color: context.fm.inkSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        for (var w = 0; w < weeks; w++)
          Row(
            children: [
              for (var i = 0; i < 7; i++) Expanded(child: at(w * 7 + i)),
            ],
          ),
      ],
    );
  }
}

/// A pill to pick one option: ink when selected, [fill] otherwise.
class ChoicePill extends StatelessWidget {
  const ChoicePill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.fill = Colors.transparent,
    this.height = 40,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color fill;
  final double height;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      selected: selected,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: selected ? fm.ink : fill,
          foregroundColor: selected ? fm.surface : fm.ink,
          minimumSize: Size(0, height),
          padding: const EdgeInsets.symmetric(horizontal: Space.lg),
          textStyle: context.text.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
