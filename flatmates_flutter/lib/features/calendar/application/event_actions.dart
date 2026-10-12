import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/action_notifier.dart';
import 'calendar_providers.dart';

/// Adding an Event.
final addEventProvider = AsyncNotifierProvider.autoDispose<AddEvent, void>(
  AddEvent.new,
);

class AddEvent extends ActionNotifier {
  Future<bool> run({
    required String title,
    String? note,
    required DateTime startsAt,
    required bool allDay,
    DateTime? endsAt,
    required bool tellFlat,
  }) => guard(
    () => ref
        .read(eventsControllerProvider.notifier)
        .add(
          title: title,
          note: note,
          startsAt: startsAt,
          allDay: allDay,
          endsAt: endsAt,
          tellFlat: tellFlat,
        ),
  );
}

/// Deleting an Event, by Event id.
final deleteEventProvider = AsyncNotifierProvider.autoDispose
    .family<DeleteEvent, void, int>(DeleteEvent.new);

class DeleteEvent extends ActionNotifier {
  DeleteEvent(this.eventId);

  final int eventId;

  Future<bool> run() =>
      guard(() => ref.read(eventsControllerProvider.notifier).delete(eventId));
}
