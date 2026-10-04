import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

part 'grocery_repository.g.dart';

@Riverpod(keepAlive: true)
GroceryRepository groceryRepository(Ref ref) => GroceryRepository(ref.watch(clientProvider));

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
