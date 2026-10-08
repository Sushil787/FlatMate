import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/action_runner.dart';
import '../../flat/application/flat_changes.dart';
import '../../flat/application/mate_directory.dart';
import '../data/grocery_repository.dart';

enum GroceryChange { add, setBought, remove }

/// A change to one Grocery item. For setBought, [item] already carries the
/// new boughtAt.
typedef GroceryOp = ({GroceryChange change, GroceryItem item});

/// A change the server refused, and what it said.
typedef GroceryRefusal = ({GroceryOp op, String message});

/// Whether [error] means the server couldn't be reached, rather than that
/// it said no.
bool isUnreachable(Object error) => error is ServerpodClientNetworkException;

/// The outbox: changes waiting to go, and the last one the server refused.
typedef OutboxState = ({List<GroceryOp> queued, GroceryRefusal? refused});

/// Grocery item changes on their way to the server. Changes made offline
/// wait in `queued`, oldest first, and go out in order on the next [flush].
/// Kept apart from GroceriesController so the queue survives that
/// controller being rebuilt on reconnect.
// ponytail: in memory only, so the queue is lost if the app is killed while
// offline. Persist it if that bites.
final groceryOutboxProvider = NotifierProvider<GroceryOutbox, OutboxState>(
  GroceryOutbox.new,
);

class GroceryOutbox extends Notifier<OutboxState> {
  Future<void>? _flushing;
  var _lastTempId = 0;

  @override
  OutboxState build() {
    ref.watch(currentFlatIdProvider);
    return (queued: const [], refused: null);
  }

  GroceryRepository get _repo => ref.read(groceryRepositoryProvider);

  /// A stand-in id for an item the server hasn't added yet.
  int tempId() => --_lastTempId;

  /// Sends [op] now, or queues it while offline (or behind changes already
  /// queued, to keep the order). Returns the server's item for an add sent
  /// now. If the server refuses, records it in `refused` and throws.
  Future<GroceryItem?> send(GroceryOp op) async {
    if (!ref.read(onlineProvider) ||
        state.queued.isNotEmpty ||
        (op.change != GroceryChange.add && op.item.id! < 0)) {
      _setQueued([...state.queued, op]);
      return null;
    }
    try {
      final saved = await _send(op);
      if (saved != null) _savedAs(op, saved);
      return saved;
    } catch (e) {
      if (!isUnreachable(e)) {
        _refuse(op, e);
        rethrow;
      }
      // Anything queued while this was in flight came after it.
      _setQueued([op, ...state.queued]);
      return null;
    }
  }

  /// Sends the queued changes in order, stopping while the server can't be
  /// reached. A change the server refuses is dropped and recorded.
  Future<void> flush() =>
      _flushing ??= _flush().whenComplete(() => _flushing = null);

  Future<void> _flush() async {
    while (state.queued.isNotEmpty) {
      final op = state.queued.first;
      try {
        final saved = await _send(op);
        _setQueued([...state.queued.where((o) => o != op)]);
        if (saved != null) _savedAs(op, saved);
      } catch (e) {
        if (isUnreachable(e)) return;
        _refuse(op, e);
      }
    }
  }

  void dismiss() => state = (queued: state.queued, refused: null);

  Future<GroceryItem?> _send(GroceryOp op) async {
    final item = op.item;
    switch (op.change) {
      case GroceryChange.add:
        return _repo.add(item.name, item.note);
      case GroceryChange.setBought:
        await _repo.setBought(item.id!, item.boughtAt != null);
      case GroceryChange.remove:
        await _repo.delete(item.id!);
    }
    return null;
  }

  /// Points queued changes to a just-added item at its real id.
  void _savedAs(GroceryOp add, GroceryItem saved) => _setQueued([
    for (final o in state.queued)
      o.item.id == add.item.id
          ? (change: o.change, item: o.item.copyWith(id: saved.id))
          : o,
  ]);

  void _refuse(GroceryOp op, Object error) => state = (
    queued: [
      for (final o in state.queued)
        // Changes to an item the server never added can't go through either.
        if (o != op &&
            !(op.change == GroceryChange.add && o.item.id == op.item.id))
          o,
    ],
    refused: (op: op, message: describeError(error)),
  );

  void _setQueued(List<GroceryOp> queued) =>
      state = (queued: queued, refused: state.refused);
}
