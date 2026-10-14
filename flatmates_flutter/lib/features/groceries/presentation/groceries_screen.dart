import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/layout.dart';
import '../application/groceries_controller.dart';
import 'widgets/grocery_row.dart';
import '../../../core/widgets/app_icon.dart';

/// The Flat's one shared grocery list, with a quick-entry field docked
/// above the nav. Updates live.
@RoutePage()
class GroceriesScreen extends ConsumerStatefulWidget {
  const GroceriesScreen({super.key});

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _add([String? name]) {
    final text = (name ?? _input.text).trim();
    if (text.isEmpty) return;
    if (name == null) _input.clear();
    runAction(
      context,
      () => ref.read(groceriesControllerProvider.notifier).add(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final groceries = ref.watch(groceriesControllerProvider);
    final open = groceries.value?.where((g) => g.boughtAt == null).length;
    final status = open == null ? null : '$open to buy';

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Space.screenMargin,
              Space.lg,
              Space.screenMargin,
              0,
            ),
            child: ScreenHeader(
              'Groceries',
              subtitle: status == null
                  ? null
                  : Text(
                      status,
                      style: context.text.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: fm.inkSoft,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: groceries,
              onRetry: () => ref.invalidate(groceriesControllerProvider),
              data: (items) => items.isEmpty
                  ? _Empty(onAdd: _add)
                  // Newest first.
                  : _List(items: items.reversed.toList()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Space.screenMargin,
              10,
              Space.screenMargin,
              10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppField(
                    controller: _input,
                    hint: 'Add a Grocery item…',
                    radius: 28,
                    textInputAction: TextInputAction.done,
                    // Keep the keyboard up for the next item.
                    onEditingComplete: () {},
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: Space.sm),
                CircleButton(
                  icon: HugeIcons.strokeRoundedAdd01,
                  tooltip: 'Add item',
                  primary: true,
                  size: Sizes.buttonPrimary,
                  onPressed: _add,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _List extends ConsumerWidget {
  const _List({required this.items});

  final List<GroceryItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(groceriesControllerProvider.notifier);
    final open = items.where((g) => g.boughtAt == null).toList();
    final ticked = items.where((g) => g.boughtAt != null).toList();

    Widget card(List<GroceryItem> rows) => Card(
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(),
            GroceryRow(
              key: ValueKey(rows[i].id),
              item: rows[i],
            ),
          ],
        ],
      ),
    );

    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          Space.screenMargin,
          Space.xs,
          Space.screenMargin,
          Space.md,
        ),
        children: [
          if (open.isNotEmpty) card(open),
          if (ticked.isNotEmpty) ...[
            const SizedBox(height: Space.sm),
            Padding(
              padding: const EdgeInsets.only(left: Space.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ticked off today',
                      style: context.text.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => runAction(context, controller.clearTicked),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Space.sm,
                      ),
                      textStyle: context.text.labelLarge?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    child: const Text('Clear ticked'),
                  ),
                ],
              ),
            ),
            card(ticked),
          ],
        ],
      ),
    );
  }
}

/// Nothing on the list yet: the basket, and a few one-tap adds.
class _Empty extends StatelessWidget {
  const _Empty({required this.onAdd});

  final ValueChanged<String> onAdd;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.screenMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Space.sm,
                      vertical: Space.lg,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Radii.hero),
                            color: fm.primaryTint,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(Space.md),
                            child: AppIcon(
                              HugeIcons.strokeRoundedShoppingBasket01,
                              color: fm.primary.withValues(alpha: 0.8),
                              size: Sizes.avatarLg,
                            ),
                          ),
                        ),
                        const SizedBox(height: Space.md),
                        Text(
                          'The list is empty. The fridge is not our problem yet.',
                          style: context.text.headlineMedium,
                        ),
                        const SizedBox(height: Space.md),
                        Text(
                          'Add the first Grocery item. Every Mate sees it '
                          'straight away and anyone can tick it off.',
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: fm.inkSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Space.xs),
                  child: Text(
                    'Quick add',
                    style: context.text.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: Space.sm),
                Wrap(
                  spacing: Space.sm,
                  runSpacing: Space.sm,
                  children: [
                    for (final name in ['Milk', 'Bread', 'Eggs', 'Toilet roll'])
                      PillButton(
                        label: '+ $name',
                        onPressed: () => onAdd(name),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
