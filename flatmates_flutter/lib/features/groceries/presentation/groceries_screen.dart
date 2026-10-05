import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/fridge/magnet_screen.dart';
import '../../../core/widgets/section_header.dart';
import '../application/groceries_controller.dart';
import 'widgets/grocery_tile.dart';

/// The Flat's one shared grocery list. Updates live; never pushes.
@RoutePage()
class GroceriesScreen extends ConsumerStatefulWidget
    implements AutoRouteWrapper {
  const GroceriesScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      MagnetScreen(section: FridgeSection.groceries, child: this);

  @override
  ConsumerState<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends ConsumerState<GroceriesScreen> {
  final _input = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _input.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    if (_input.text.trim().isEmpty) return;
    final ok = await runAction(
      context,
      () => ref.read(groceriesControllerProvider.notifier).add(_input.text),
    );
    if (ok) {
      _input.clear();
      _focus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final groceries = ref.watch(groceriesControllerProvider);
    final theme = Theme.of(context);
    final toBuy = groceries.value?.where((g) => g.boughtAt == null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          if (toBuy != null && toBuy > 0)
            Padding(
              padding: const EdgeInsets.only(right: Insets.lg),
              child: Center(
                child: Text(
                  '$toBuy to buy',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.lg,
              0,
              Insets.lg,
              Insets.md,
            ),
            child: TextField(
              controller: _input,
              focusNode: _focus,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _add(),
              decoration: InputDecoration(
                hintText: 'Add an item, e.g. "Milk - 2L"',
                prefixIcon: const Icon(Icons.add_shopping_cart_rounded),
                suffixIcon: IconButton(
                  onPressed: _add,
                  icon: const Icon(Icons.arrow_upward_rounded),
                ),
              ),
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: groceries,
              onRetry: () => ref.invalidate(groceriesControllerProvider),
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.shopping_basket_rounded,
                    title: 'Nothing needed',
                    message:
                        'Add what the flat is running low on. Whoever\'s at the shop ticks it off.',
                  );
                }
                final pending = items.where((g) => g.boughtAt == null).toList();
                final bought = items.where((g) => g.boughtAt != null).toList();
                return RefreshIndicator(
                  onRefresh: ref
                      .read(groceriesControllerProvider.notifier)
                      .refresh,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      Insets.lg,
                      0,
                      Insets.lg,
                      Insets.xl,
                    ),
                    children: [
                      for (final item in pending) ...[
                        GroceryTile(item: item),
                        const SizedBox(height: Insets.sm),
                      ],
                      if (bought.isNotEmpty) ...[
                        const SectionHeader(
                          'Bought · clears after 24h',
                          padding: EdgeInsets.fromLTRB(
                            0,
                            Insets.lg,
                            0,
                            Insets.sm,
                          ),
                        ),
                        for (final item in bought) ...[
                          GroceryTile(item: item),
                          const SizedBox(height: Insets.sm),
                        ],
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
