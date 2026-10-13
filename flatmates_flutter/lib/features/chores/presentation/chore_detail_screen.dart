import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../away/presentation/away_rule_text.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../away/application/aways_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../application/chore_turns.dart';
import '../application/chore_actions.dart';
import '../application/chores_controller.dart';
import '../domain/chore_turns.dart';
import 'chore_editor_sheet.dart';

/// A Chore's Rotation, Turns done per Mate, and Turn history.
@RoutePage()
class ChoreDetailScreen extends ConsumerStatefulWidget {
  const ChoreDetailScreen({super.key, required this.choreId});

  /// Typed, so only a real Chore id can be passed in; not in the URL.
  final UuidValue choreId;

  @override
  ConsumerState<ChoreDetailScreen> createState() => _ChoreDetailScreenState();
}

class _ChoreDetailScreenState extends ConsumerState<ChoreDetailScreen> {
  Future<void> _edit() async {
    await showChoreEditor(context, choreId: widget.choreId);
    // Deleted from the editor: nothing left to show.
    if (mounted &&
        ref.read(choresControllerProvider).value?.choreById(widget.choreId) ==
            null) {
      context.router.maybePop();
    }
  }

  void _markDone(UuidValue turnId) =>
      runAction(context, ref.read(markDoneProvider(turnId).notifier).run);

  @override
  Widget build(BuildContext context) {
    final directory = ref.watch(mateDirectoryProvider);
    final overview = ref.watch(choresControllerProvider);
    final history = ref.watch(choreHistoryProvider(widget.choreId));
    final turn = history.value?.current;
    final today = Day.fromLocal(DateTime.now());
    final myTurn =
        turn != null &&
        turn.id != null &&
        turn.status == TurnStatus.active &&
        directory.isMe(turn.mateId) &&
        history.value!.isToday(turn);

    return Scaffold(
      bottomNavigationBar: myTurn
          ? SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              child: PrimaryButton(
                icon: HugeIcons.strokeRoundedTick02,
                busy: ref.watch(markDoneProvider(turn.id!)).isLoading,
                label: turn.lastDay.isAtSameMomentAs(today)
                    ? 'Mark Done · your Turn ends 23:59'
                    : 'Mark Done · your Turn ends '
                          '${DateFormat('EEE').format(Day.local(turn.lastDay))} 23:59',
                onPressed: () => _markDone(turn.id!),
              ),
            )
          : null,
      body: AsyncValueView(
        value: overview,
        onRetry: () => ref.invalidate(choresControllerProvider),
        header: const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Space.screenMargin,
              Space.lg,
              Space.screenMargin,
              0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleButton.back(tooltip: 'Back to Chores'),
            ),
          ),
        ),
        data: (overview) {
          final chore = overview.choreById(widget.choreId);
          return ScreenList(
            underNav: false,
            gap: 14,
            children: [
              Row(
                children: [
                  const CircleButton.back(tooltip: 'Back to Chores'),
                  const Spacer(),
                  if (directory.amAdmin && chore != null)
                    PillButton(label: 'Edit', onPressed: _edit),
                ],
              ),
              if (chore == null)
                Text(
                  'This Chore no longer exists.',
                  style: context.text.bodyMedium,
                )
              else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Space.sm,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        chore.name,
                        style: context.text.displaySmall?.copyWith(
                          fontSize: 34,
                          height: 1.05,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: Space.sm,
                      runSpacing: Space.sm,
                      children: [
                        Tag(
                          'Rotation period · '
                          '${periodLabel(chore.period).toLowerCase()}',
                          tone: TagTone.plain,
                        ),
                        Tag(
                          'Away rule · ${directory.flat.awayRule.label}',
                          tone: TagTone.plain,
                        ),
                      ],
                    ),
                  ],
                ),
                AsyncValueView(
                  value: history,
                  onRetry: () =>
                      ref.invalidate(choreHistoryProvider(widget.choreId)),
                  data: (history) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 14,
                    children: [
                      _RotationCard(chore: chore, history: history),
                      _HistoryCard(history: history),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// Each Mate in the Rotation with their Turns done in the last 8 weeks.
class _RotationCard extends ConsumerWidget {
  const _RotationCard({required this.chore, required this.history});

  final Chore chore;
  final ChoreHistory history;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final aways = ref.watch(awaysControllerProvider).value;
    final debts = ref.watch(swapDebtsProvider).value ?? const [];
    final current = history.current;

    Widget cell(UuidValue id) {
      final away = awayOn(aways, id, history.today) != null;
      final now =
          current != null && current.mateId == id && history.isToday(current);
      final next = history.nextDayOf(id);
      final when = now
          ? 'now'
          : away
          ? 'Away'
          : next == null
          ? null
          : dayName(next);
      final owes = debts
          .where((d) => d.choreId == chore.id && d.debtorMateId == id)
          .length;
      final name = directory.nameOf(id);
      return Column(
        spacing: 6,
        children: [
          // Keeps the row aligned whether or not the lime ring is drawn.
          SizedBox.square(
            dimension: Sizes.avatarLg + 10,
            child: Center(
              child: MateAvatar(
                id,
                size: Sizes.avatarLg,
                away: away,
                turn: now,
              ),
            ),
          ),
          Text(
            when == null ? name : '$name · $when',
            textAlign: TextAlign.center,
            style: context.text.bodySmall?.copyWith(
              color: away ? fm.awayFg : fm.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${history.doneBy(id)} done${owes > 0 ? ' · owes $owes' : ''}',
            textAlign: TextAlign.center,
            style: context.text.bodySmall,
          ),
        ],
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Space.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Space.md,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: Space.sm,
              children: [
                Semantics(
                  header: true,
                  child: Text('Rotation', style: context.text.titleMedium),
                ),
                Text('Turns done, last 8 weeks', style: context.text.bodySmall),
              ],
            ),
            LayoutBuilder(
              builder: (context, box) {
                final width = (box.maxWidth - Space.sm * 3) / 4;
                return Wrap(
                  spacing: Space.sm,
                  runSpacing: Space.md,
                  children: [
                    for (final id in chore.rotation.toSet())
                      SizedBox(width: width, child: cell(id)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Done and Missed Turns, newest first.
class _HistoryCard extends ConsumerWidget {
  const _HistoryCard({required this.history});

  final ChoreHistory history;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final past = history.past;
    final soft = context.text.bodySmall?.copyWith(fontSize: 14);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.lg, Space.md, Space.lg, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Semantics(
                header: true,
                child: Text('Turn history', style: context.text.titleMedium),
              ),
            ),
            if (past.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Space.md),
                child: Text('No Turns yet.', style: context.text.bodySmall),
              ),
            for (var i = 0; i < past.length; i++) ...[
              if (i > 0) const Divider(),
              AppRow(
                minHeight: 48,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 52),
                      child: Text(
                        DateFormat('d MMM').format(Day.local(past[i].day)),
                        style: soft,
                      ),
                    ),
                    const SizedBox(width: Space.md),
                    MateAvatar(past[i].mateId, size: Sizes.avatarSm),
                  ],
                ),
                title: Text.rich(
                  TextSpan(
                    text: directory.nameOf(past[i].mateId),
                    children: [
                      if (past[i].coveringForMateId case final covered?)
                        TextSpan(
                          text: ' covered ${directory.nameOf(covered)}',
                          style: soft?.copyWith(fontWeight: FontWeight.w400),
                        ),
                    ],
                  ),
                ),
                trailing: past[i].status == TurnStatus.done
                    ? const Tag('Done', tone: TagTone.done)
                    : const Tag('Missed', tone: TagTone.missed),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
