import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../away/presentation/away_rule_text.dart';
import '../../application/my_flat_controller.dart';

/// Admin-only: chooses the Flat-wide Away rule.
class AwayRulePicker extends ConsumerWidget {
  const AwayRulePicker({super.key, required this.current});

  final AwayRule current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final rule in AwayRule.values)
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.sm),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: rule == current
                    ? scheme.primaryContainer
                    : scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(Radii.md),
                border: Border.all(
                  color: rule == current ? scheme.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(Radii.md),
                onTap: rule == current
                    ? null
                    : () => runAction(
                        context,
                        () => ref
                            .read(myFlatControllerProvider.notifier)
                            .setAwayRule(rule),
                        success: 'Away rule set to ${rule.label}',
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(Insets.lg),
                  child: Row(
                    children: [
                      Icon(
                        rule.icon,
                        color: rule == current
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: Insets.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(rule.label, style: text.titleMedium),
                            Text(rule.explanation, style: text.bodySmall),
                          ],
                        ),
                      ),
                      if (rule == current)
                        Icon(Icons.check_circle_rounded, color: scheme.primary),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
