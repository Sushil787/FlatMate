import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';

/// Events on the Flat's shared calendar.
class EventEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<FlatEvent>> between(
    Session session,
    DateTime from,
    DateTime to,
  ) async {
    final (:me, :flat) = await requireMate(session);
    return FlatEvent.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) & (t.startsAt < to) & (t.startsAt >= from),
      orderBy: (t) => t.startsAt,
    );
  }

  Future<FlatEvent> create(
    Session session,
    String title,
    String? note,
    DateTime startsAt,
    DateTime? endsAt,
  ) async {
    final (:me, :flat) = await requireMate(session);
    if (title.trim().isEmpty) fail('Give the event a title.');
    if (endsAt != null && !endsAt.isAfter(startsAt)) {
      fail('The event must end after it starts.');
    }
    final event = await FlatEvent.db.insertRow(
      session,
      FlatEvent(
        flatId: flat.id!,
        mateId: me.id!,
        title: title.trim(),
        note: (note?.trim().isEmpty ?? true) ? null : note!.trim(),
        startsAt: startsAt.toUtc(),
        endsAt: endsAt?.toUtc(),
      ),
    );
    await broadcast(session, flat.id!, FlatChangeKind.events);
    return event;
  }

  /// Deletes an Event; only its creator or the Admin can.
  Future<void> delete(Session session, int eventId) async {
    final (:me, :flat) = await requireMate(session);
    final event = await FlatEvent.db.findById(session, eventId);
    if (event == null || event.flatId != flat.id) fail('Event not found.');
    if (event.mateId != me.id && flat.adminMateId != me.id) {
      fail('Only whoever added it or the admin can delete this.');
    }
    await FlatEvent.db.deleteRow(session, event);
    await broadcast(session, flat.id!, FlatChangeKind.events);
  }
}
