import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../../away/application/aways_controller.dart';
import '../../chores/application/chores_controller.dart';
import '../../chores/data/chore_repository.dart';
import '../../flat/application/mate_directory.dart';
import '../data/event_repository.dart';
import '../domain/calendar_entry.dart';

/// Every calendar entry around the month containing [month]: real and
/// planned Turns, Events and Away periods.
Future<List<CalendarEntry>> _calendarMonth(Ref ref, DateTime month) async {
  ref.watch(currentFlatIdProvider);
  // Include the neighbouring weeks the month grid shows.
  final from = DateTime(month.year, month.month).subtract(
    const Duration(days: 7),
  );
  final to = DateTime(month.year, month.month + 1).add(const Duration(days: 7));

  final (turns, events) = await (
    ref
        .watch(choreRepositoryProvider)
        .turnsBetween(Day.fromLocal(from), Day.fromLocal(to)),
    ref.watch(eventRepositoryProvider).between(from, to),
  ).wait;
  final chores = await ref.watch(choresControllerProvider.future);
  final aways = await ref.watch(awaysControllerProvider.future);

  return [
    for (final e in events) EventEntry(e),
    for (final a in aways) AwayEntry(a),
    for (final t in turns)
      TurnEntry(t, chores.choreById(t.choreId)?.name ?? 'Chore'),
  ];
}

final calendarMonthProvider = FutureProvider.autoDispose
    .family<List<CalendarEntry>, DateTime>(_calendarMonth);

/// Adding and removing Events.
final eventsControllerProvider = NotifierProvider<EventsController, void>(
  EventsController.new,
);

class EventsController extends Notifier<void> {
  @override
  void build() {}

  Future<void> add({
    required String title,
    String? note,
    required DateTime startsAt,
    required bool allDay,
    DateTime? endsAt,
    required bool tellFlat,
  }) async {
    await ref
        .read(eventRepositoryProvider)
        .create(
          title: title,
          note: note,
          startsAt: startsAt,
          allDay: allDay,
          endsAt: endsAt,
          tellFlat: tellFlat,
        );
    ref.invalidate(calendarMonthProvider);
  }

  Future<void> delete(int eventId) async {
    await ref.read(eventRepositoryProvider).delete(eventId);
    ref.invalidate(calendarMonthProvider);
  }
}
