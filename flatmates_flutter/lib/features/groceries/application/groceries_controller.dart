import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flat/application/mate_directory.dart';
import '../data/grocery_repository.dart';

/// The Flat's grocery list: items to buy, plus items ticked off in the last
/// day, oldest first. Ticking and removing show straight away and roll back
/// if the server refuses.
final groceriesControllerProvider =
    AsyncNotifierProvider<GroceriesController, List<GroceryItem>>(
      GroceriesController.new,
    );

class GroceriesController extends AsyncNotifier<List<GroceryItem>> {
  GroceryRepository get _repo => ref.read(groceryRepositoryProvider);
  int get _me => ref.read(mateDirectoryProvider).me.id!;

  @override
  Future<List<GroceryItem>> build() {
    ref.watch(currentFlatIdProvider);
    return ref.watch(groceryRepositoryProvider).list();
  }

  Future<void> refresh() async => state = await AsyncValue.guard(_repo.list);

  Future<void> add(String name) async {
    final saved = await _repo.add(name.trim(), null);
    state = AsyncData([...?state.value, saved]);
  }

  /// Ticks an item off, or back on.
  Future<void> toggle(GroceryItem item) {
    final bought = item.boughtAt == null;
    return _change(
      [
        for (final g in state.value ?? const <GroceryItem>[])
          g.id == item.id
              ? g.copyWith(
                  boughtAt: bought ? DateTime.now().toUtc() : null,
                  boughtByMateId: bought ? _me : null,
                )
              : g,
      ],
      () => _repo.setBought(item.id!, bought),
    );
  }

  Future<void> remove(GroceryItem item) => _change(
    [
      for (final g in state.value ?? const <GroceryItem>[])
        if (g.id != item.id) g,
    ],
    () => _repo.delete(item.id!),
  );

  Future<void> clearTicked() async {
    for (final item in [...?state.value?.where((g) => g.boughtAt != null)]) {
      await remove(item);
    }
  }

  /// Shows [changed] at once, then runs [send]; rolls back on error.
  Future<void> _change(
    List<GroceryItem> changed,
    Future<void> Function() send,
  ) async {
    final before = state.value;
    if (before == null) return;
    state = AsyncData(changed);
    try {
      await send();
    } catch (_) {
      state = AsyncData(before);
      rethrow;
    }
  }
}
