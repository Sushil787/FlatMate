import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

EventRepository _eventRepository(Ref ref) =>
    EventRepository(ref.watch(clientProvider));

final eventRepositoryProvider = Provider<EventRepository>(_eventRepository);

class EventRepository {
  EventRepository(this._client);

  final Client _client;

  Future<List<FlatEvent>> between(DateTime from, DateTime to) =>
      _client.event.between(from, to);

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
