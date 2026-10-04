import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

part 'event_repository.g.dart';

@Riverpod(keepAlive: true)
EventRepository eventRepository(Ref ref) => EventRepository(ref.watch(clientProvider));

class EventRepository {
  EventRepository(this._client);

  final Client _client;

  Future<List<FlatEvent>> between(DateTime from, DateTime to) =>
      _client.event.between(from, to);

  Future<FlatEvent> create({
    required String title,
    String? note,
    required DateTime startsAt,
  }) => _client.event.create(title, note, startsAt, null);

  Future<void> delete(int eventId) => _client.event.delete(eventId);
}
