import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/day.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../away/application/aways_controller.dart';
import '../../../flat/application/mate_directory.dart';
import '../../application/calendar_providers.dart';
import '../../domain/calendar_entry.dart';

/// Colour that marks each kind of entry on the calendar.
Color entryColor(BuildContext context, CalendarEntry entry) => switch (entry) {
  TurnEntry() => Theme.of(context).colorScheme.primary,
  AwayEntry() => context.colors.away,
  EventEntry() => context.colors.event,
};

/// One entry in the selected day's list, with a coloured accent bar.
class CalendarEntryTile extends ConsumerWidget {
  const CalendarEntryTile({super.key, required this.entry});

  final CalendarEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final theme = Theme.of(context);
    final accent = entryColor(context, entry);

    final (
      IconData icon,
      String title,
      String subtitle,
      int? mateId,
      Widget? action,
    ) = switch (entry) {
      TurnEntry(:final turn, :final choreName, :final isPlanned) => (
        Icons.cleaning_services_rounded,
        '$choreName · ${directory.nameOf(turn.mateId)}',
        [
          Fmt.days(turn.day, turn.lastDay),
          if (turn.coveringForMateId != null)
            'Covering for ${directory.realNameOf(turn.coveringForMateId)}',
          if (isPlanned) 'Planned',
          if (turn.status == TurnStatus.done) 'Done',
          if (turn.status == TurnStatus.missed) 'Missed',
        ].join(' · '),
        turn.mateId,
        null,
      ),
      AwayEntry(:final away) => (
        Icons.flight_takeoff_rounded,
        '${directory.nameOf(away.mateId)} away',
        Fmt.days(away.startDay, away.lastDay),
        away.mateId,
        directory.isMe(away.mateId) && away.startsAt.isAfter(DateTime.now())
            ? TextButton(
                onPressed: () => runAction(
                  context,
                  () => ref
                      .read(awaysControllerProvider.notifier)
                      .cancel(away.id!),
                  success: 'Away cancelled',
                ),
                child: const Text('Cancel'),
              )
            : null,
      ),
      EventEntry(:final event) => (
        Icons.celebration_rounded,
        event.title,
        [
          Fmt.time(event.startsAt),
          'added by ${directory.nameOf(event.mateId)}',
          ?event.note,
        ].join(' · '),
        null,
        directory.isMe(event.mateId) || directory.amAdmin
            ? IconButton(
                tooltip: 'Delete event',
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () => runAction(
                  context,
                  () => ref
                      .read(eventsControllerProvider.notifier)
                      .delete(event.id!),
                ),
              )
            : null,
      ),
    };

    return Card(
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5, color: accent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Insets.md),
                child: Row(
                  children: [
                    mateId != null
                        ? MateAvatar(
                            mateId: mateId,
                            name: directory.realNameOf(mateId),
                            size: 36,
                          )
                        : CircleAvatar(
                            radius: 18,
                            backgroundColor: accent.withValues(alpha: 0.15),
                            child: Icon(icon, color: accent, size: 18),
                          ),
                    const SizedBox(width: Insets.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(icon, size: 14, color: accent),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  title,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ?action,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
