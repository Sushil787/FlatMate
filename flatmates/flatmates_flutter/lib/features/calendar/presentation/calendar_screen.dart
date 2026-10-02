import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state.dart';
import '../../away/presentation/away_sheet.dart';
import '../application/calendar_providers.dart';
import '../domain/calendar_entry.dart';
import 'widgets/calendar_entry_tile.dart';
import 'widgets/new_event_sheet.dart';

/// One calendar for the Flat: Turns (including planned ones), Away periods
/// and Events.
@RoutePage()
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();

  DateTime get _month => DateTime(_focused.year, _focused.month);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = ref.watch(calendarMonthProvider(_month));
    final all = entries.value ?? const <CalendarEntry>[];
    List<CalendarEntry> on(DateTime day) =>
        all.where((e) => e.isOn(day)).toList()
          ..sort((a, b) => a.start.compareTo(b.start));
    final today = on(_selected);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Insets.sm),
            child: FilledButton.tonalIcon(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
              onPressed: () => showAwaySheet(context),
              icon: const Icon(Icons.flight_takeoff_rounded, size: 18),
              label: const Text('I\'m away'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add event',
        onPressed: () => showNewEventSheet(context, _selected),
        child: const Icon(Icons.add_rounded),
      ),
      body: Column(
        children: [
          Padding(
            padding: Insets.screen,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(bottom: Insets.sm),
                child: TableCalendar<CalendarEntry>(
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focused,
                  selectedDayPredicate: (d) => isSameDay(d, _selected),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  eventLoader: on,
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: theme.textTheme.titleMedium!,
                    titleTextFormatter: (date, _) => Fmt.monthYear(date),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: theme.textTheme.labelSmall!,
                    weekendStyle: theme.textTheme.labelSmall!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) =>
                        events.isEmpty ? null : _Markers(events: events),
                  ),
                  onDaySelected: (selected, focused) => setState(() {
                    _selected = selected;
                    _focused = focused;
                  }),
                  onPageChanged: (focused) =>
                      setState(() => _focused = focused),
                ),
              ),
            ),
          ),
          const _Legend(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.lg,
              Insets.sm,
              Insets.lg,
              Insets.sm,
            ),
            child: Row(
              children: [
                Text(Fmt.day(_selected), style: theme.textTheme.titleMedium),
                const Spacer(),
                if (entries.isLoading)
                  const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),
          Expanded(
            child: today.isEmpty
                ? const EmptyState(
                    compact: true,
                    icon: Icons.wb_sunny_rounded,
                    title: 'A free day',
                    message: 'No turns, trips or events.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      Insets.lg,
                      0,
                      Insets.lg,
                      96,
                    ),
                    itemCount: today.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: Insets.sm),
                    itemBuilder: (_, i) => CalendarEntryTile(entry: today[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Up to one dot per kind of entry on a day.
class _Markers extends StatelessWidget {
  const _Markers({required this.events});

  final List<CalendarEntry> events;

  @override
  Widget build(BuildContext context) {
    final kinds = <Type, CalendarEntry>{
      for (final e in events) e.runtimeType: e,
    };
    return Positioned(
      bottom: 4,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final e in kinds.values)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color: entryColor(context, e),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Turns', Theme.of(context).colorScheme.primary),
      ('Away', context.colors.away),
      ('Events', context.colors.event),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.lg,
        vertical: Insets.sm,
      ),
      child: Row(
        children: [
          for (final (label, color) in items) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(width: Insets.lg),
          ],
        ],
      ),
    );
  }
}
