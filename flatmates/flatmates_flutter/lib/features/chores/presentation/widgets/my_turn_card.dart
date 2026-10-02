import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/countdown_ring.dart';
import '../../../flat/application/mate_directory.dart';
import '../../application/chores_controller.dart';
import '../../domain/chores_overview.dart';

/// The hero card for one of the user's own open Turns.
class MyTurnCard extends ConsumerStatefulWidget {
  const MyTurnCard({super.key, required this.chore, required this.turn});

  final Chore chore;
  final Turn turn;

  @override
  ConsumerState<MyTurnCard> createState() => _MyTurnCardState();
}

class _MyTurnCardState extends ConsumerState<MyTurnCard> {
  bool _busy = false;

  Future<void> _markDone() async {
    setState(() => _busy = true);
    await runAction(
      context,
      () => ref
          .read(choresControllerProvider.notifier)
          .markDone(widget.turn.id!),
      success: 'Nice! ${widget.chore.name} is done.',
    );
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final directory = ref.watch(mateDirectoryProvider);
    final turn = widget.turn;
    final started = turn.hasStarted;
    final covering = turn.coveringForMateId;

    return Container(
      decoration: BoxDecoration(
        gradient: context.colors.heroGradient,
        borderRadius: BorderRadius.circular(Radii.lg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(Insets.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      started ? 'YOUR TURN' : 'UP NEXT FOR YOU',
                      style: text.labelSmall?.copyWith(
                        color: Colors.white70,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: Insets.xs),
                    Text(
                      widget.chore.name,
                      style: text.headlineSmall?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: Insets.xs),
                    Text(
                      started
                          ? 'Due ${Fmt.dateTime(turn.endsAt)}'
                          : 'Starts ${Fmt.dateTime(turn.startsAt)}',
                      style: text.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    if (covering != null) ...[
                      const SizedBox(height: Insets.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(Radii.pill),
                        ),
                        child: Text(
                          'Covering for ${directory.realNameOf(covering)}',
                          style: text.labelSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: Insets.md),
              CountdownRing(
                progress: started ? turn.elapsed : 0,
                label: Fmt.remaining(started ? turn.endsAt : turn.startsAt),
                caption: started ? 'left' : 'to start',
              ),
            ],
          ),
          if (started) ...[
            const SizedBox(height: Insets.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _busy ? null : _markDone,
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Mark as done'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shown in place of the hero card when the user has nothing due.
class AllClearCard extends StatelessWidget {
  const AllClearCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.xl),
      decoration: BoxDecoration(
        color: colors.successContainer,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colors.success,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.done_all_rounded, color: colors.onSuccess),
          ),
          const SizedBox(width: Insets.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You\'re all clear', style: text.titleMedium),
                Text(
                  'Nothing is waiting on you right now.',
                  style: text.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
