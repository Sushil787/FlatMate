import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/status_pill.dart';
import '../../domain/chores_overview.dart';

/// The pill describing where a Turn is: done, due, upcoming, missed.
class TurnStatusPill extends StatelessWidget {
  const TurnStatusPill({super.key, required this.turn});

  final Turn? turn;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.colors;
    final turn = this.turn;

    if (turn == null) {
      return StatusPill(
        label: 'Idle',
        background: scheme.surfaceContainerHigh,
        foreground: scheme.onSurfaceVariant,
      );
    }
    return switch (turn.status) {
      TurnStatus.done => StatusPill(
        label: 'Done',
        icon: Icons.check_rounded,
        background: colors.successContainer,
        foreground: colors.success,
      ),
      TurnStatus.missed => StatusPill(
        label: 'Missed',
        icon: Icons.close_rounded,
        background: scheme.errorContainer,
        foreground: scheme.error,
      ),
      TurnStatus.active when !turn.hasStarted => StatusPill(
        label: 'Starts ${Fmt.day(turn.startsAt)}',
        icon: Icons.schedule_rounded,
        background: scheme.surfaceContainerHigh,
        foreground: scheme.onSurfaceVariant,
      ),
      TurnStatus.active
          when turn.endsAt.difference(DateTime.now()) <
              const Duration(hours: 6) =>
        StatusPill(
          label: 'Due in ${Fmt.remaining(turn.endsAt)}',
          icon: Icons.local_fire_department_rounded,
          background: colors.warningContainer,
          foreground: colors.warning,
        ),
      TurnStatus.active => StatusPill(
        label: 'Due in ${Fmt.remaining(turn.endsAt)}',
        background: scheme.primaryContainer,
        foreground: scheme.onPrimaryContainer,
      ),
    };
  }
}
