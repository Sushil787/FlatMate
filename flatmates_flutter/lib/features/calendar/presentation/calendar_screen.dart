import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/banners.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../flat/application/mate_directory.dart';
import '../../away/application/away_actions.dart';
import '../application/calendar_providers.dart';
import '../application/event_actions.dart';
import '../domain/calendar_entry.dart';
import 'widgets/add_event_sheet.dart';
import 'widgets/month_grid.dart';
import '../../../core/widgets/app_icon.dart';

/// The Flat's calendar: Events and who is Away, as a month grid and a
/// "Coming up" list.
@RoutePage()
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime? _selected;

  void _shiftMonth(int by) => setState(() {
    _month = DateTime(_month.year, _month.month + by);
    _selected = null;
  });

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    final value = ref.watch(calendarMonthProvider(_month));
    final next = ref.watch(
      calendarMonthProvider(DateTime(_month.year, _month.month + 1)),
    );
    // Turns live on the Chores tab; the calendar shows Events and Aways.
    // The two months' windows overlap, so key entries by id.
    final all = {
      for (final e in [...?value.value, ...?next.value])
        if (e case EventEntry(:final event))
          'e${event.id}': e
        else if (e case AwayEntry(:final away))
          'a${away.id}': e,
    }.values.toList();

    final inThisMonth =
        today.year == _month.year && today.month == _month.month;
    final from = _selected ?? (inThisMonth ? today : _month);
    DateTime shownOn(CalendarEntry e) =>
        e.start.isBefore(from) ? from : e.start;
    final upcoming =
        all.where((e) => e.isOn(from) || e.start.isAfter(from)).toList()
          ..sort((a, b) {
            final byDay = DateUtils.dateOnly(
              shownOn(a),
            ).compareTo(DateUtils.dateOnly(shownOn(b)));
            return byDay != 0 ? byDay : a.start.compareTo(b.start);
          });

    return Stack(
      children: [
        ScreenList(
          underAdd: true,
          children: [
            ScreenHeader(
              DateFormat(
                _month.year == today.year ? 'MMMM' : 'MMMM y',
              ).format(_month),
            ),
            if (value.hasError && !value.hasValue)
              ErrorCard(
                title: 'Couldn\'t load the calendar',
                message: describeError(value.error!),
                onRetry: () => ref.invalidate(calendarMonthProvider(_month)),
              ),
            GestureDetector(
              onHorizontalDragEnd: (d) {
                final v = d.primaryVelocity ?? 0;
                if (v.abs() > 200) _shiftMonth(v < 0 ? 1 : -1);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Space.sm,
                    Space.md,
                    Space.sm,
                    0,
                  ),
                  child: Column(
                    children: [
                      MonthGrid(
                        month: _month,
                        cell: (d) => _DayCell(
                          day: d,
                          today: DateUtils.isSameDay(d, today),
                          selected: DateUtils.isSameDay(
                            d,
                            _selected ?? today,
                          ),
                          event: all.any((e) => e is EventEntry && e.isOn(d)),
                          away: all.any((e) => e is AwayEntry && e.isOn(d)),
                          onTap: () => setState(() => _selected = d),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Previous month',
                            icon: const AppIcon(
                              HugeIcons.strokeRoundedArrowLeft01,
                            ),
                            onPressed: () => _shiftMonth(-1),
                          ),
                          const Expanded(child: _Legend()),
                          IconButton(
                            tooltip: 'Next month',
                            icon: const AppIcon(
                              HugeIcons.strokeRoundedArrowRight01,
                            ),
                            onPressed: () => _shiftMonth(1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SectionTitle('Coming up'),
            if (upcoming.isEmpty)
              RowCard(
                children: [
                  AppRow(
                    title: Text(
                      value.isLoading ? 'Loading…' : 'Nothing coming up',
                    ),
                    meta: const Text('Add an Event so the Flat knows.'),
                  ),
                ],
              )
            else
              RowCard(
                children: [
                  for (final e in upcoming)
                    _AgendaRow(entry: e, day: shownOn(e), today: today),
                ],
              ),
          ],
        ),
        AddButton(
          tooltip: 'Add Event',
          label: 'Add Event',
          onPressed: () => showAddEventSheet(
            context,
            day: _selected != null && !_selected!.isBefore(today)
                ? _selected
                : null,
          ),
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.today,
    required this.selected,
    required this.event,
    required this.away,
    required this.onTap,
  });

  final DateTime day;
  final bool today, selected, event, away;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      button: true,
      selected: selected,
      excludeSemantics: true,
      label: [
        DateFormat('EEEE d MMMM').format(day),
        if (today) 'today',
        if (event) 'Event',
        if (away) 'A Mate is Away',
      ].join(', '),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.chip),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Sizes.touchMin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? fm.ink : null,
                  border: today && !selected
                      ? Border.all(color: fm.ink, width: 2)
                      : null,
                ),
                child: Text(
                  '${day.day}',
                  style: context.text.titleSmall?.copyWith(
                    fontSize: 14,
                    color: selected ? fm.surface : fm.ink,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 3,
                  children: [
                    if (event) _Mark.event(fm),
                    if (away) _Mark.away(fm),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Event dot or the Away bar.
class _Mark extends StatelessWidget {
  // The design's Event dot (#6E8F00) isn't a token; link is the theme's
  // nearest lime-on-light colour and stays visible in dark mode.
  _Mark.event(FlatmatesColors fm) : color = fm.link, width = 6;
  _Mark.away(FlatmatesColors fm) : color = fm.awayFg, width = 12;

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: 6,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(3),
    ),
  );
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    Widget item(Widget mark, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        mark,
        Flexible(
          child: Text(
            label,
            style: context.text.bodySmall?.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: Space.lg,
      runSpacing: Space.xs,
      children: [
        item(_Mark.event(fm), 'Event'),
        item(_Mark.away(fm), 'A Mate is Away'),
      ],
    );
  }
}

/// "FRI 9 · Plumber 10am · 10:00 · added by Jonas" or "Jonas is Away".
/// Tapping lets the creator (or the Admin) delete an Event, and lets a Mate
/// cancel their own Away before it starts.
class _AgendaRow extends ConsumerWidget {
  const _AgendaRow({
    required this.entry,
    required this.day,
    required this.today,
  });

  final CalendarEntry entry;
  final DateTime day;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final awayEntry = entry is AwayEntry;
    final accent = awayEntry ? fm.awayFg : null;

    final (
      String title,
      String meta,
      String? note,
      Widget avatar,
      onTap,
    ) = switch (entry) {
      EventEntry(:final event) => (
        event.title,
        [
          if (!event.allDay)
            Fmt.time(event.startsAt)
          else if (event.endsAt == null)
            'All day'
          else
            'Until ${Fmt.day(event.endsAt!.toLocal().subtract(const Duration(hours: 12)))}',
          'added by ${directory.isMe(event.mateId) ? 'you' : directory.realNameOf(event.mateId)}',
        ].join(' · '),
        event.note,
        MateAvatar(event.mateId, size: Sizes.avatarSm),
        directory.isMe(event.mateId) || directory.amAdmin
            ? () async {
                final ok = await confirm(
                  context,
                  title: 'Delete this Event?',
                  message: '${event.title} comes off the Flat\'s calendar.',
                  confirmLabel: 'Delete Event',
                  destructive: true,
                );
                if (!ok || !context.mounted) return;
                await runAction(
                  context,
                  ref.read(deleteEventProvider(event.id!).notifier).run,
                );
              }
            : null,
      ),
      AwayEntry(:final away) => (
        directory.isMe(away.mateId)
            ? 'You are Away'
            : '${directory.realNameOf(away.mateId)} is Away',
        dayRange(Day.local(away.startDay), Day.local(away.lastDay)),
        null,
        MateAvatar(away.mateId, size: Sizes.avatarSm, away: true),
        directory.isMe(away.mateId) && away.startsAt.isAfter(today)
            ? () async {
                final ok = await confirm(
                  context,
                  title: 'Cancel this Away?',
                  message: 'Your Turns go back to how they were planned.',
                  confirmLabel: 'Cancel Away',
                );
                if (!ok || !context.mounted) return;
                await runAction(
                  context,
                  ref.read(cancelAwayProvider(away.id!).notifier).run,
                  success: 'Away cancelled',
                );
              }
            : null,
      ),
      TurnEntry() => throw StateError('Turns are not listed here'),
    };

    return AppRow(
      onTap: onTap,
      leading: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 40),
        child: Column(
          children: [
            Text(
              DateFormat('EEE').format(day).toUpperCase(),
              style: context.text.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: accent ?? fm.inkSoft,
              ),
            ),
            Text(
              '${day.day}',
              style: context.text.titleMedium?.copyWith(
                fontSize: 18,
                color: accent,
              ),
            ),
          ],
        ),
      ),
      title: Text(title, style: TextStyle(color: accent)),
      meta: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(meta),
          if (note != null && note.isNotEmpty)
            Text(note, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
      trailing: avatar,
    );
  }
}
