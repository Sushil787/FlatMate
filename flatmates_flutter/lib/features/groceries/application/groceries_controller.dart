import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flat/application/flat_changes.dart';
import '../../flat/application/mate_directory.dart';
import '../data/grocery_repository.dart';
import 'grocery_outbox.dart';

/// The Flat's grocery list: items to buy, plus items ticked off in the last
/// day, oldest first. Changes show straight away; changes made offline wait
/// in the [GroceryOutbox] and are sent once the server is back.
final groceriesControllerProvider =
    AsyncNotifierProvider<GroceriesController, List<GroceryItem>>(
      GroceriesController.new,
    );

class GroceriesController extends AsyncNotifier<List<GroceryItem>> {
  GroceryOutbox get _outbox => ref.read(groceryOutboxProvider.notifier);
  int get _me => ref.read(mateDirectoryProvider).me.id!;

  /// When the list last came from the server.
  DateTime? lastSynced;

  @override
  Future<List<GroceryItem>> build() {
    ref.watch(currentFlatIdProvider);
    ref.listen(onlineProvider, (_, online) {
      if (online) ref.invalidateSelf();
    });
    return _load();
  }

  Future<void> refresh() async => state = await AsyncValue.guard(_load);

  /// Sends what's queued, then fetches the list with anything still queued
  /// laid over it. Offline, keeps showing what we have.
  Future<List<GroceryItem>> _load() async {
    await _outbox.flush();
    try {
      final items = await ref.read(groceryRepositoryProvider).list();
      lastSynced = DateTime.now();
      return ref
          .read(groceryOutboxProvider)
          .queued
          .fold<List<GroceryItem>>(
            items,
            _withChange,
          );
    } catch (e) {
      final last = state.value;
      if (last == null || !isUnreachable(e)) rethrow;
      return last;
    }
  }

  Future<void> add(String name) => _change(
    GroceryChange.add,
    GroceryItem(
      id: _outbox.tempId(),
      flatId: ref.read(currentFlatIdProvider)!,
      name: name.trim(),
      addedByMateId: _me,
      createdAt: DateTime.now().toUtc(),
    ),
  );

  /// Ticks an item off, or back on.
  Future<void> toggle(GroceryItem item) {
    final bought = item.boughtAt == null;
    return _change(
      GroceryChange.setBought,
      item.copyWith(
        boughtAt: bought ? DateTime.now().toUtc() : null,
        boughtByMateId: bought ? _me : null,
      ),
    );
  }

  Future<void> remove(GroceryItem item) => _change(GroceryChange.remove, item);

  Future<void> clearTicked() async {
    for (final item in [...?state.value?.where((g) => g.boughtAt != null)]) {
      await remove(item);
    }
  }

  /// Tries the change the server refused once more.
  Future<void> retry() async {
    final refused = ref.read(groceryOutboxProvider).refused;
    if (refused == null) return;
    _outbox.dismiss();
    await _change(refused.op.change, refused.op.item);
  }

  /// Shows the change straight away, then sends or queues it. A refusal
  /// shows from the outbox, so this never throws.
  Future<void> _change(GroceryChange change, GroceryItem item) async {
    final op = (change: change, item: item);
    state = AsyncData(_withChange(state.value ?? const [], op));
    try {
      final saved = await _outbox.send(op);
      if (saved != null) {
        state = AsyncData([
          for (final g in state.value ?? const <GroceryItem>[])
            g.id == item.id ? saved : g,
        ]);
      }
    } catch (_) {
      await refresh();
    }
  }
}

List<GroceryItem> _withChange(List<GroceryItem> items, GroceryOp op) =>
    switch (op.change) {
      GroceryChange.add => [...items, op.item],
      GroceryChange.setBought => [
        for (final g in items) g.id == op.item.id ? op.item : g,
      ],
      GroceryChange.remove => [
        for (final g in items)
          if (g.id != op.item.id) g,
      ],
    };
