import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/banners.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../flat/application/mate_directory.dart';
import '../../application/groceries_controller.dart';
import '../../../../core/widgets/app_icon.dart';

/// One Grocery item: tap to tick it off (or back on), swipe left to remove.
/// Shows who added it, or who ticked it off.
class GroceryRow extends ConsumerWidget {
  const GroceryRow({super.key, required this.item});

  final GroceryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final controller = ref.read(groceriesControllerProvider.notifier);
    final ticked = item.boughtAt != null;
    final by = ticked ? item.boughtByMateId : item.addedByMateId;
    final name = directory.nameOf(by);
    // Just added by another Mate: highlight it as it arrives.
    final justNow =
        !ticked &&
        !directory.isMe(by) &&
        DateTime.now().difference(item.createdAt) < const Duration(minutes: 1);

    final row = InkWell(
      onTap: () => runAction(context, () => controller.toggle(item)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Sizes.touchMin),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.lg,
            vertical: Space.sm,
          ),
          child: Row(
            children: [
              _Checkbox(ticked: ticked),
              const SizedBox(width: Space.md),
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: Space.md,
                  runSpacing: Space.xs,
                  children: [
                    Text(
                      item.note == null
                          ? item.name
                          : '${item.name}, ${item.note}',
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: ticked ? FontWeight.w400 : FontWeight.w600,
                        color: ticked ? fm.inkSoft : fm.ink,
                        decoration: ticked ? TextDecoration.lineThrough : null,
                        decorationColor: fm.inkSoft,
                      ),
                    ),
                    Text(
                      ticked
                          ? '$name ticked it'
                          : justNow
                          ? '$name · just now'
                          : name,
                      style: context.text.labelMedium?.copyWith(
                        fontWeight: justNow ? FontWeight.w700 : FontWeight.w400,
                        color: justNow ? fm.ink : fm.inkSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Space.md),
              ExcludeSemantics(child: MateAvatar(by, size: Sizes.avatarSm)),
            ],
          ),
        ),
      ),
    );

    return MergeSemantics(
      child: Semantics(
        checked: ticked,
        customSemanticsActions: {
          const CustomSemanticsAction(label: 'Remove'): () =>
              runAction(context, () => controller.remove(item)),
        },
        child: Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.endToStart,
          background: ColoredBox(
            color: fm.dangerBg,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: Space.xl),
                child: Text(
                  'Remove',
                  style: context.text.labelLarge?.copyWith(
                    fontSize: 14,
                    color: fm.dangerFg,
                  ),
                ),
              ),
            ),
          ),
          onDismissed: (_) => runAction(context, () => controller.remove(item)),
          // Opaque, so the Remove behind only shows where the row slid away.
          child: Material(
            color: fm.surface,
            child: FreshHighlight(fresh: justNow, child: row),
          ),
        ),
      ),
    );
  }
}

/// 24px rounded box; Leaf green with a tick once ticked off.
class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.ticked});

  final bool ticked;

  @override
  Widget build(BuildContext context) {
    final leaf = mateColors[3];
    return AnimatedContainer(
      duration: Timing.standard,
      curve: Timing.curve,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: ticked ? leaf.fill : null,
        borderRadius: BorderRadius.circular(8),
        border: ticked ? null : Border.all(color: context.fm.inkSoft, width: 2),
      ),
      child: ticked
          ? AppIcon(HugeIcons.strokeRoundedTick02, size: 14, color: leaf.onFill)
          : null,
    );
  }
}
