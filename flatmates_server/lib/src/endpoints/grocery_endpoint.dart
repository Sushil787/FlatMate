import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';

/// How long bought items stay visible before dropping off the list.
const boughtVisibleFor = Duration(hours: 24);

/// The Flat's single shared grocery list. Changes update open apps live;
/// nothing here sends a push.
class GroceryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Items still to buy, plus items bought in the last 24 hours.
  Future<List<GroceryItem>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final cutoff = DateTime.now().toUtc().subtract(boughtVisibleFor);
    return GroceryItem.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          (t.boughtAt.equals(null) | (t.boughtAt > cutoff)),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<GroceryItem> add(Session session, String name, String? note) async {
    final (:me, :flat) = await requireMate(session);
    if (name.trim().isEmpty) fail('What do we need?');
    final item = await GroceryItem.db.insertRow(
      session,
      GroceryItem(
        flatId: flat.id!,
        name: name.trim(),
        note: (note?.trim().isEmpty ?? true) ? null : note!.trim(),
        addedByMateId: me.id!,
      ),
    );
    await broadcast(session, flat.id!, FlatChangeKind.groceries);
    return item;
  }

  /// Ticks an item as bought by the caller, or unticks it.
  Future<GroceryItem> setBought(
    Session session,
    int itemId,
    bool bought,
  ) async {
    final (:me, :flat) = await requireMate(session);
    final item = await _find(session, flat, itemId);
    item
      ..boughtByMateId = bought ? me.id : null
      ..boughtAt = bought ? DateTime.now().toUtc() : null;
    await GroceryItem.db.updateRow(session, item);
    await broadcast(session, flat.id!, FlatChangeKind.groceries);
    return item;
  }

  Future<void> delete(Session session, int itemId) async {
    final (:me, :flat) = await requireMate(session);
    final item = await _find(session, flat, itemId);
    await GroceryItem.db.deleteRow(session, item);
    await broadcast(session, flat.id!, FlatChangeKind.groceries);
  }

  Future<GroceryItem> _find(Session session, Flat flat, int itemId) async {
    final item = await GroceryItem.db.findById(session, itemId);
    if (item == null || item.flatId != flat.id) fail('Item not found.');
    return item;
  }
}
