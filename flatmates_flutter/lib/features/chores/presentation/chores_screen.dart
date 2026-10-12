import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../app/router.gr.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/day.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../away/application/aways_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../application/chore_turns.dart';
import '../application/chores_controller.dart';
import '../domain/chore_turns.dart';
import 'chore_editor_sheet.dart';
import '../../../core/widgets/app_icon.dart';

/// Every Chore: whose Turn it is, who is next, and the Rotation period.
@RoutePage()
class ChoresScreen extends ConsumerWidget {
  const ChoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final cards = ref.watch(choresNowProvider);

    final list = RefreshIndicator(
      onRefresh: ref.read(choresControllerProvider.notifier).refresh,
      child: ScreenList(
        underAdd: directory.amAdmin,
        children: [
          const ScreenHeader('Chores'),
          AsyncValueView(
            value: cards,
            onRetry: () => ref.invalidate(choresControllerProvider),
            data: (cards) => cards.isEmpty
                ? _NoChores(admin: directory.amAdmin)
                : Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [for (final c in cards) _ChoreCard(c)],
                  ),
          ),
        ],
      ),
    );
    if (!directory.amAdmin) return list;
    return Stack(
      children: [
        list,
        AddButton(
          tooltip: 'Create a Chore',
          label: 'Add Chore',
          onPressed: () => showChoreEditor(context),
        ),
      ],
    );
  }
}

class _NoChores extends StatelessWidget {
  const _NoChores({required this.admin});

  final bool admin;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Space.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Space.xs,
          children: [
            Text('No Chores yet', style: context.text.titleMedium),
            Text(
              admin
                  ? 'Create the first one with +. Turns take care of themselves.'
                  : 'Your Admin sets up Chores. They\'ll show up here.',
              style: context.text.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoreCard extends ConsumerWidget {
  const _ChoreCard(this.now);

  final ChoreNow now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final turn = now.turn;
    final chore = now.chore;
    final period = periodLabel(chore.period);
    final mine = now.dueToday && directory.isMe(turn!.mateId);
    final covered = turn?.coveringForMateId;

    final tag = switch (turn) {
      _ when now.doneToday => const Tag.done('Done today'),
      Turn() when covered != null => const Tag('Swap', tone: TagTone.away),
      _ when now.dueToday => const Tag('Due today', tone: TagTone.due),
      _ when now.missed != null => const Tag.missed('Missed yesterday'),
      Turn(:final day) => Tag('Due ${dayName(day)}'),
      null => null,
    };

    final notes = <String>[];
    Widget who;
    if (turn == null) {
      who = Text('No Turn planned', style: context.text.bodySmall);
    } else if (covered != null) {
      who = _Swap(turn: turn, covered: covered);
      final debt = ref
          .watch(swapDebtsProvider)
          .value
          ?.where(
            (d) =>
                d.choreId == chore.id &&
                d.debtorMateId == covered &&
                d.creditorMateId == turn.mateId,
          )
          .firstOrNull;
      notes.add(
        debt == null
            ? period
            : '${_owes(directory, covered, turn.mateId)} one Turn back · $period',
      );
    } else {
      who = _WhoNext(turn: turn, next: now.next, period: period);
    }
    if (now.missed case final missed?) {
      final whose = directory.isMe(missed.mateId)
          ? 'Your'
          : '${directory.realNameOf(missed.mateId)}\'s';
      notes.add(
        '$whose Turn ended without a Done. It happens. The Rotation moved on.',
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.card),
        side: mine ? BorderSide(color: fm.primary, width: 2) : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => context.router.push(ChoreDetailRoute(choreId: chore.id!)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: Space.sm,
                runSpacing: Space.xs,
                children: [
                  Text(
                    chore.name,
                    style: context.text.titleLarge?.copyWith(fontSize: 18),
                  ),
                  ?tag,
                ],
              ),
              who,
              for (final n in notes) Text(n, style: context.text.bodySmall),
            ],
          ),
        ),
      ),
    );
  }

  static String _owes(MateDirectory d, int debtor, int creditor) {
    if (d.isMe(debtor)) return 'You owe ${d.realNameOf(creditor)}';
    if (d.isMe(creditor)) return '${d.realNameOf(debtor)} owes you';
    return '${d.realNameOf(debtor)} owes ${d.realNameOf(creditor)}';
  }
}

/// "(M) Your Turn → (S) Sam next      Every 3 days"
class _WhoNext extends ConsumerWidget {
  const _WhoNext({
    required this.turn,
    required this.next,
    required this.period,
  });

  final Turn turn;
  final Turn? next;
  final String period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final soft = context.text.bodySmall;
    final strong = soft?.copyWith(
      color: context.fm.ink,
      fontWeight: FontWeight.w700,
    );
    return Row(
      children: [
        Expanded(
          child: Wrap(
            spacing: Space.sm,
            runSpacing: Space.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _Pair(
                avatar: MateAvatar(turn.mateId, size: 32),
                text: Text(
                  directory.isMe(turn.mateId)
                      ? 'Your Turn'
                      : directory.realNameOf(turn.mateId),
                  style: strong,
                ),
              ),
              if (next case final next?) ...[
                ExcludeSemantics(
                  child: AppIcon(
                    HugeIcons.strokeRoundedArrowRight02,
                    size: 16,
                    color: context.fm.inkSoft,
                  ),
                ),
                _Pair(
                  avatar: MateAvatar(next.mateId, size: Sizes.avatarSm),
                  text: Text(
                    '${directory.nameOf(next.mateId)} next',
                    style: soft,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: Space.sm),
        Text(period, style: soft),
      ],
    );
  }
}

/// "(P) Priya covers  (J) Jonas is Away · back in 3 days"
class _Swap extends ConsumerWidget {
  const _Swap({required this.turn, required this.covered});

  final Turn turn;
  final int covered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final today = Day.fromLocal(DateTime.now());
    final away = awayOn(
      ref.watch(awaysControllerProvider).value,
      covered,
      today,
    );
    final coverer = directory.isMe(turn.mateId)
        ? 'You cover'
        : '${directory.realNameOf(turn.mateId)} covers';
    final name = directory.isMe(covered)
        ? 'You'
        : directory.realNameOf(covered);
    final String status;
    if (away == null) {
      status = 'for $name';
    } else {
      final back = away.lastDay.difference(today).inDays + 1;
      status =
          '$name ${directory.isMe(covered) ? 'are' : 'is'} Away · back '
          '${back == 1 ? 'tomorrow' : 'in $back days'}';
    }
    final style = context.text.bodySmall;
    return Wrap(
      spacing: Space.md,
      runSpacing: Space.xs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _Pair(
          avatar: MateAvatar(turn.mateId, size: 32),
          text: Text(
            coverer,
            style: style?.copyWith(color: fm.ink, fontWeight: FontWeight.w700),
          ),
        ),
        _Pair(
          avatar: MateAvatar(
            covered,
            size: Sizes.avatarSm,
            away: away != null,
          ),
          text: Text(
            status,
            style: style?.copyWith(
              color: away == null ? null : fm.awayFg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _Pair extends StatelessWidget {
  const _Pair({required this.avatar, required this.text});

  final Widget avatar;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(width: Space.sm),
        Flexible(child: text),
      ],
    );
  }
}
