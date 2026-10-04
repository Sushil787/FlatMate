import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../flat/application/mate_directory.dart';
import '../data/grocery_repository.dart';

part 'groceries_controller.g.dart';

/// The Flat's grocery list: items to buy, plus items bought in the last day.
@Riverpod(keepAlive: true)
class GroceriesController extends _$GroceriesController {
  GroceryRepository get _repo => ref.read(groceryRepositoryProvider);

  @override
  Future<List<GroceryItem>> build() {
    ref.watch(currentFlatIdProvider);
    return ref.watch(groceryRepositoryProvider).list();
  }

  Future<void> refresh() async => state = await AsyncValue.guard(_repo.list);

  /// Adds an item. "Milk - 2L" puts "2L" in the note.
  Future<void> add(String input) async {
    final parts = input.trim().split(RegExp(r'\s+-\s+'));
    await _repo.add(
      parts.first,
      parts.length > 1 ? parts.sublist(1).join(' - ') : null,
    );
    await refresh();
  }

  /// Ticks or unticks an item, updating the list straight away.
  Future<void> toggle(GroceryItem item, int myMateId) async {
    final bought = item.boughtAt == null;
    final previous = state;
    state = AsyncData([
      for (final g in state.value ?? const <GroceryItem>[])
        if (g.id == item.id)
          g.copyWith(
            boughtAt: bought ? DateTime.now().toUtc() : null,
            boughtByMateId: bought ? myMateId : null,
          )
        else
          g,
    ]);
    try {
      await _repo.setBought(item.id!, bought);
    } catch (_) {
      state = previous;
      rethrow;
    }
    await refresh();
  }

  Future<void> delete(GroceryItem item) async {
    final previous = state;
    state = AsyncData([
      for (final g in state.value ?? const <GroceryItem>[])
        if (g.id != item.id) g,
    ]);
    try {
      await _repo.delete(item.id!);
    } catch (_) {
      state = previous;
      rethrow;
    }
  }
}
