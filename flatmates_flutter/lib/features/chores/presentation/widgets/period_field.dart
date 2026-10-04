import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

enum PeriodUnit { hours, days, weeks }

/// Picks a Rotation period as a number and a unit, e.g. "2 weeks".
class PeriodField extends StatelessWidget {
  const PeriodField({super.key, required this.value, required this.onChanged});

  final Duration value;
  final ValueChanged<Duration> onChanged;

  static (int, PeriodUnit) split(Duration d) {
    if (d.inDays >= 7 && d.inDays % 7 == 0) {
      return (d.inDays ~/ 7, PeriodUnit.weeks);
    }
    if (d.inHours >= 24 && d.inHours % 24 == 0) {
      return (d.inDays, PeriodUnit.days);
    }
    return (d.inHours, PeriodUnit.hours);
  }

  static Duration join(int amount, PeriodUnit unit) => switch (unit) {
    PeriodUnit.hours => Duration(hours: amount),
    PeriodUnit.days => Duration(days: amount),
    PeriodUnit.weeks => Duration(days: 7 * amount),
  };

  @override
  Widget build(BuildContext context) {
    final (amount, unit) = split(value);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final unitLabel = switch (unit) {
      PeriodUnit.hours => amount == 1 ? 'hour' : 'hours',
      PeriodUnit.days => amount == 1 ? 'day' : 'days',
      PeriodUnit.weeks => amount == 1 ? 'week' : 'weeks',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: Insets.sm),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(Radii.md),
          ),
          child: Row(
            children: [
              IconButton.filledTonal(
                onPressed: amount > 1
                    ? () => onChanged(join(amount - 1, unit))
                    : null,
                icon: const Icon(Icons.remove_rounded),
              ),
              Expanded(
                child: Text(
                  '$amount $unitLabel',
                  textAlign: TextAlign.center,
                  style: text.titleLarge,
                ),
              ),
              IconButton.filledTonal(
                onPressed: amount < 99
                    ? () => onChanged(join(amount + 1, unit))
                    : null,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(height: Insets.md),
        SegmentedButton<PeriodUnit>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: PeriodUnit.hours, label: Text('Hours')),
            ButtonSegment(value: PeriodUnit.days, label: Text('Days')),
            ButtonSegment(value: PeriodUnit.weeks, label: Text('Weeks')),
          ],
          selected: {unit},
          onSelectionChanged: (s) => onChanged(join(amount, s.first)),
        ),
      ],
    );
  }
}
