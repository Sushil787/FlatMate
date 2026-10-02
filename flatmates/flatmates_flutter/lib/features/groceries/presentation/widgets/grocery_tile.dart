import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../flat/application/mate_directory.dart';
import '../../application/groceries_controller.dart';

/// One grocery item: tap to tick, swipe to delete.
class GroceryTile extends ConsumerWidget {
  const GroceryTile({super.key, required this.item});

  final GroceryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final controller = ref.read(groceriesControllerProvider.notifier);
    final theme = Theme.of(context);
    final colors = context.colors;
    final bought = item.boughtAt != null;

    final subtitle = bought
        ? 'Bought by ${directory.nameOf(item.boughtByMateId)}'
        : [?item.note, 'added by ${directory.nameOf(item.addedByMateId)}']
              .join(' · ');

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: Insets.xl),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
      onDismissed: (_) => runAction(context, () => controller.delete(item)),
      child: Material(
        color: bought
            ? theme.colorScheme.surfaceContainerLow
            : theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Radii.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(Radii.md),
          onTap: () => runAction(
            context,
            () => controller.toggle(item, directory.me.id!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bought ? colors.success : Colors.transparent,
                    border: Border.all(
                      color: bought ? colors.success : theme.colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: bought
                      ? Icon(Icons.check_rounded, size: 18, color: colors.onSuccess)
                      : null,
                ),
                const SizedBox(width: Insets.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          decoration: bought ? TextDecoration.lineThrough : null,
                          color: bought
                              ? theme.colorScheme.onSurfaceVariant
                              : null,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
