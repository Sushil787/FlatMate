import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';

GroceryRepository _groceryRepository(Ref ref) => GroceryRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final groceryRepositoryProvider = Provider<GroceryRepository>(
  _groceryRepository,
);

class GroceryRepository {
  GroceryRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// Items to buy and ones ticked off in the last day, oldest first.
  Future<List<GroceryItem>> list() => _cache.read(
    'grocery',
    _client.grocery.list,
    load: (db) => GroceryItem.db.find(db, orderBy: (t) => t.createdAt),
    clear: (db, tx) => GroceryItem.db.deleteWhere(
      db,
      where: (t) => t.id.notEquals(null),
      transaction: tx,
    ),
    insert: (db, tx, items) =>
        GroceryItem.db.insert(db, items, transaction: tx),
  );

  Future<GroceryItem> add(String name, String? note) =>
      _client.grocery.add(name, note);

  Future<GroceryItem> setBought(UuidValue itemId, bool bought) =>
      _client.grocery.setBought(itemId, bought);

  Future<void> delete(UuidValue itemId) => _client.grocery.delete(itemId);
}
