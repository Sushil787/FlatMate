import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../away/application/aways_controller.dart';
import '../../chores/application/chores_controller.dart';
import '../../chores/data/chore_repository.dart';
import '../../flat/application/mate_directory.dart';
import '../data/event_repository.dart';
import '../domain/calendar_entry.dart';

part 'calendar_providers.g.dart';

/// Every calendar entry around the month containing [month]: real and
/// planned Turns, Events and Away periods.
@riverpod
Future<List<CalendarEntry>> calendarMonth(Ref ref, DateTime month) async {
  ref.watch(currentFlatIdProvider);
  // Include the neighbouring weeks the month grid shows.
  final from = DateTime(month.year, month.month).subtract(
    const Duration(days: 7),
  );
  final to = DateTime(month.year, month.month + 1).add(const Duration(days: 7));

  final (turns, events) = await (
    ref.watch(choreRepositoryProvider).turnsBetween(from, to),
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

/// Adding and removing Events.
@Riverpod(keepAlive: true)
class EventsController extends _$EventsController {
  @override
  void build() {}

  Future<void> add({
    required String title,
    String? note,
    required DateTime startsAt,
  }) async {
    await ref
        .read(eventRepositoryProvider)
        .create(title: title, note: note, startsAt: startsAt);
    ref.invalidate(calendarMonthProvider);
  }

  Future<void> delete(int eventId) async {
    await ref.read(eventRepositoryProvider).delete(eventId);
    ref.invalidate(calendarMonthProvider);
  }
}
