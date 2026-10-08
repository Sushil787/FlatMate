import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

GroceryRepository _groceryRepository(Ref ref) =>
    GroceryRepository(ref.watch(clientProvider));

final groceryRepositoryProvider = Provider<GroceryRepository>(
  _groceryRepository,
);

class GroceryRepository {
  GroceryRepository(this._client);

  final Client _client;

  Future<List<GroceryItem>> list() => _client.grocery.list();

  Future<GroceryItem> add(String name, String? note) =>
      _client.grocery.add(name, note);

  Future<GroceryItem> setBought(int itemId, bool bought) =>
      _client.grocery.setBought(itemId, bought);

  Future<void> delete(int itemId) => _client.grocery.delete(itemId);
}
