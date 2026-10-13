import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_database/serverpod_database.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';

EventRepository _eventRepository(Ref ref) => EventRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final eventRepositoryProvider = Provider<EventRepository>(_eventRepository);

class EventRepository {
  EventRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// Events overlapping [from]..[to], by start (the server's query).
  Future<List<FlatEvent>> between(DateTime from, DateTime to) {
    Expression where(FlatEventTable t) =>
        (t.startsAt < to) &
        ((t.endsAt > from) | (t.endsAt.equals(null) & (t.startsAt >= from)));
    return _cache.read(
      'event:${from.toIso8601String()}:${to.toIso8601String()}',
      () => _client.event.between(from, to),
      load: (db) =>
          FlatEvent.db.find(db, where: where, orderBy: (t) => t.startsAt),
      clear: (db, tx) =>
          FlatEvent.db.deleteWhere(db, where: where, transaction: tx),
      insert: (db, tx, events) async {
        final ids = {for (final e in events) e.id!};
        if (ids.isNotEmpty) {
          await FlatEvent.db.deleteWhere(
            db,
            where: (t) => t.id.inSet(ids),
            transaction: tx,
          );
        }
        await FlatEvent.db.insert(db, events, transaction: tx);
      },
    );
  }

  Future<FlatEvent> create({
    required String title,
    String? note,
    required DateTime startsAt,
    required bool allDay,
    DateTime? endsAt,
    required bool tellFlat,
  }) => _client.event.create(
    title,
    note,
    startsAt,
    allDay: allDay,
    endsAt: endsAt,
    tellFlat: tellFlat,
  );

  Future<void> delete(UuidValue eventId) => _client.event.delete(eventId);
}
