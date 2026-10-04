import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/illustration.dart';
import '../../flat/application/mate_directory.dart';
import '../application/aways_controller.dart';
import 'away_rule_text.dart';

/// Opens the "Going away?" sheet.
Future<void> showAwaySheet(BuildContext context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (_) => const _AwaySheet(),
);

class _AwaySheet extends ConsumerStatefulWidget {
  const _AwaySheet();

  @override
  ConsumerState<_AwaySheet> createState() => _AwaySheetState();
}

class _AwaySheetState extends ConsumerState<_AwaySheet> {
  DateTimeRange? _range;
  bool _busy = false;

  Future<void> _pick() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      // Away can't be backdated.
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange: _range,
      helpText: 'When will you be away?',
    );
    if (range != null) setState(() => _range = range);
  }

  Future<void> _save() async {
    final range = _range!;
    final start = Day.fromLocal(range.start);
    final end = Day.fromLocal(range.end);
    setState(() => _busy = true);
    final ok = await runAction(
      context,
      () => ref.read(awaysControllerProvider.notifier).markAway(start, end),
      success: 'You\'re marked away. Have a good trip!',
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final rule = ref.watch(mateDirectoryProvider).flat.awayRule;
    final theme = Theme.of(context);
    final colors = context.colors;
    final range = _range;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Insets.xl,
          0,
          Insets.xl,
          Insets.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Illustration(
              icon: Icons.flight_takeoff_rounded,
              size: 120,
              color: colors.away,
            ),
            const SizedBox(height: Insets.md),
            Text(
              'Going away?',
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Insets.lg),
            Container(
              padding: const EdgeInsets.all(Insets.lg),
              decoration: BoxDecoration(
                color: colors.warningContainer,
                borderRadius: BorderRadius.circular(Radii.md),
              ),
              child: Row(
                children: [
                  Icon(rule.icon, color: colors.onWarningContainer),
                  const SizedBox(width: Insets.md),
                  Expanded(
                    child: Text(
                      'Your flat uses ${rule.label}: ${rule.explanation}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onWarningContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.lg),
            OutlinedButton.icon(
              onPressed: _pick,
              icon: const Icon(Icons.date_range_rounded),
              label: Text(
                range == null
                    ? 'Choose dates'
                    : '${Fmt.day(range.start)} → ${Fmt.day(range.end)}',
              ),
            ),
            const SizedBox(height: Insets.md),
            FilledButton(
              onPressed: range == null || _busy ? null : _save,
              child: const Text('Mark me away'),
            ),
          ],
        ),
      ),
    );
  }
}
