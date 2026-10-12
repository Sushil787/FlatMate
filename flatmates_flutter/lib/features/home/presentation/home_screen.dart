import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../app/router.gr.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../board/application/notices_controller.dart';
import '../../chores/application/chore_actions.dart';
import '../../chores/application/chore_turns.dart';
import '../../chores/domain/chore_turns.dart';
import '../../chores/application/chores_controller.dart';
import '../../chores/domain/chores_overview.dart';
import '../../chores/presentation/chore_editor_sheet.dart';
import '../../flat/application/mate_directory.dart';
import '../../groceries/application/groceries_controller.dart';
import 'widgets/home_empty.dart';
import 'widgets/home_skeleton.dart';
import 'widgets/turn_card.dart';
import '../../../core/widgets/app_icon.dart';

/// Home: the signed-in Mate's Turn today and what they've done, the latest
/// Notice beside the Grocery items to buy, and what's next in the Flat.
@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    // The Turn card and Done today both come from the Chore cards, which
    // Mark Done and Undo change at once: the screen moves in one step.
    return AsyncValueView(
      value: ref.watch(choresNowProvider),
      loading: const HomeSkeleton(),
      onRetry: () => ref.invalidate(choresControllerProvider),
      data: (cards) {
        // Loaded first: the cards are built from it.
        final overview = ref.watch(choresControllerProvider).requireValue;
        if (overview.chores.isEmpty) {
          return HeaderScroll(
            header: _Header(directory: directory),
            children: [
              if (directory.amAdmin &&
                  directory.mates.length == 1 &&
                  directory.flat.inviteExpiresAt.isAfter(
                    DateTime.now().toUtc(),
                  ))
                InviteCard(
                  meId: directory.me.id!,
                  flatName: directory.flat.name,
                  inviteCode: directory.flat.inviteCode,
                ),
              NoChoresCard(amAdmin: directory.amAdmin),
              if (directory.amAdmin)
                PrimaryButton(
                  label: 'Create a Chore',
                  icon: HugeIcons.strokeRoundedAdd01,
                  background: context.fm.heroCard,
                  foreground: context.fm.onHeroCard,
                  onPressed: () => showChoreEditor(context),
                ),
            ],
          );
        }

        final me = directory.me.id!;
        // Only a Turn on today: one whose day is over is Missed, even if the
        // server hasn't said so yet.
        final now = DateTime.now();
        final mine = cards.where((c) => directory.isMe(c.turn?.mateId));
        final myTurn = [
          for (final c in mine)
            if (c.dueToday && c.turn!.endsAt.isAfter(now)) (c.chore, c.turn!),
        ].firstOrNull;
        final doneToday = [
          for (final c in mine)
            if (c.doneToday) c,
        ];
        final doneIds = {for (final c in doneToday) c.chore.id};
        final upNext = [
          for (final c in overview.chores)
            if (overview.turnFor(c) case final t?
                when c.id != myTurn?.$1.id && !doneIds.contains(c.id))
              (c, t),
        ]..sort((a, b) => a.$2.startsAt.compareTo(b.$2.startsAt));

        return HeaderScroll(
          header: _Header(directory: directory),
          children: [
            if (myTurn case (final chore, final turn))
              TurnCard(
                chore: chore,
                endsAt: turn.endsAt,
                nextLabel: _nextLabel(directory, chore),
                busy: ref.watch(markDoneProvider(turn.id!)).isLoading,
                onDone: () => runAction(
                  context,
                  ref.read(markDoneProvider(turn.id!).notifier).run,
                ),
              )
            else if (doneToday.isEmpty)
              _NoTurnCard(overview: overview, me: me),
            if (doneToday.isNotEmpty) _DoneToday(doneToday),
            const _NoticeAndGroceries(),
            if (upNext.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionTitle(
                    'Up next in the Flat',
                    action: 'All Chores',
                    onAction: () => context.navigateTo(const ChoresRoute()),
                  ),
                  const SizedBox(height: Space.sm),
                  RowCard(
                    children: [
                      for (final (chore, turn) in upNext.take(3))
                        _UpNextRow(
                          chore: chore,
                          turn: turn,
                          who: directory.nameOf(turn.mateId),
                        ),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  /// "Sam is next": the Mate after the latest Turn's slot in the Rotation.
  static String _nextLabel(MateDirectory directory, Chore chore) {
    if (chore.rotation.isEmpty) return 'Nobody is next';
    final next =
        chore.rotation[(chore.rotationIndex + 1) % chore.rotation.length];
    return directory.isMe(next)
        ? 'You\'re next again'
        : '${directory.realNameOf(next)} is next';
  }
}

/// The Flat's name over "Hi Maya", with the avatar that opens Settings
/// on the right. See [CollapsingHeader].
class _Header extends StatelessWidget {
  const _Header({required this.directory});

  final MateDirectory directory;

  @override
  Widget build(BuildContext context) {
    return CollapsingHeader(
      eyebrow: directory.flat.name,
      title: 'Hi ${directory.me.displayName.trim().split(' ').first}',
      trailing: (shrink) => IconButton(
        tooltip: 'Profile and settings',
        padding: EdgeInsets.zero,
        onPressed: () => context.router.push(const SettingsRoute()),
        icon: MateAvatar(directory.me.id, size: 44 - 8 * shrink),
      ),
    );
  }
}

/// The signed-in Mate's Turns marked Done today, each with Undo while the
/// day lasts.
class _DoneToday extends ConsumerWidget {
  const _DoneToday(this.done);

  final List<ChoreNow> done;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Done today'),
        const SizedBox(height: Space.sm),
        RowCard(
          children: [
            for (final c in done)
              AppRow(
                leading: Container(
                  width: Sizes.avatarMd,
                  height: Sizes.avatarMd,
                  // The active tab's soft lime.
                  decoration: BoxDecoration(
                    color: fm.primaryTint,
                    shape: BoxShape.circle,
                  ),
                  child: AppIcon(
                    HugeIcons.strokeRoundedTick02,
                    size: 18,
                    color: fm.onPrimaryTint,
                  ),
                ),
                title: Text(
                  c.chore.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                meta: Text(
                  c.turn!.doneAt == null
                      ? 'Done'
                      : 'Done · ${Fmt.ago(c.turn!.doneAt!)}',
                ),
                trailing: _UndoButton(c.turn!.id!),
              ),
          ],
        ),
      ],
    );
  }
}

class _UndoButton extends ConsumerWidget {
  const _UndoButton(this.turnId);

  final int turnId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final undoing = ref.watch(undoDoneProvider(turnId)).isLoading;
    return TextButton(
      onPressed: undoing
          ? null
          : () => runAction(
              context,
              ref.read(undoDoneProvider(turnId).notifier).run,
            ),
      style: TextButton.styleFrom(
        foregroundColor: context.fm.ink,
        textStyle: context.text.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: undoing
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Undo'),
    );
  }
}

/// When it isn't the signed-in Mate's Turn today: when their next one is.
class _NoTurnCard extends StatelessWidget {
  const _NoTurnCard({required this.overview, required this.me});

  final ChoresOverview overview;
  final int me;

  @override
  Widget build(BuildContext context) {
    final next = overview.openTurnsOf(me).firstOrNull;
    return RowCard(
      children: [
        AppRow(
          leading: AppIcon(
            HugeIcons.strokeRoundedTick02,
            color: context.fm.inkSoft,
          ),
          title: const Text('No Turn for you today'),
          meta: Text(
            next == null
                ? 'Nothing coming up for you yet.'
                : 'Next: ${next.$1.name} · ${_when(next.$2).day}',
          ),
          onTap: next == null
              ? null
              : () => context.router.push(
                  ChoreDetailRoute(choreId: next.$1.id!),
                ),
        ),
      ],
    );
  }
}

class _UpNextRow extends StatelessWidget {
  const _UpNextRow({
    required this.chore,
    required this.turn,
    required this.who,
  });

  final Chore chore;
  final Turn turn;
  final String who;

  @override
  Widget build(BuildContext context) {
    final when = _when(turn);
    return AppRow(
      leading: MateAvatar(turn.mateId),
      title: Text(chore.name),
      meta: Text('$who · ${when.relative}'),
      trailing: turn.hasStarted
          ? const Tag('Due today', tone: TagTone.due)
          : Tag(when.day),
      onTap: () => context.router.push(ChoreDetailRoute(choreId: chore.id!)),
    );
  }
}

/// When [turn] starts: "today"/"tomorrow"/"in 3 days", and "Thu" (or
/// "Thu 15 Oct" when more than a week out).
({String relative, String day}) _when(Turn turn) {
  final today = DateUtils.dateOnly(DateTime.now());
  final days = (turn.startsAt.difference(today).inHours / 24).round();
  final relative = switch (days) {
    <= 0 => 'today',
    1 => 'tomorrow',
    _ => 'in $days days',
  };
  final day = days <= 0
      ? 'Today'
      : days < 7
      ? DateFormat.E().format(turn.startsAt)
      : Fmt.day(turn.startsAt);
  return (relative: relative, day: day);
}

/// The latest Notice (¾) beside the open Grocery item count (¼), equal
/// heights. Above "Up next" so a Notice doesn't read as a Chore thing.
class _NoticeAndGroceries extends StatelessWidget {
  const _NoticeAndGroceries();

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: _LatestNoticeCard()),
          SizedBox(width: Space.md),
          Expanded(child: _GroceriesCard()),
        ],
      ),
    );
  }
}

/// The newest Notice, or a nudge to post one; opens the Notice board.
class _LatestNoticeCard extends ConsumerWidget {
  const _LatestNoticeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final notices = ref.watch(noticesControllerProvider).value ?? const [];
    final latest = notices.isEmpty
        ? null
        : notices.reduce((a, b) => b.createdAt.isAfter(a.createdAt) ? b : a);
    final who = ref.watch(mateDirectoryProvider).nameOf(latest?.mateId);
    final meta = context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600);
    return Card(
      child: InkWell(
        onTap: () => context.router.push(const BoardRoute()),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (latest == null)
                Text(
                  'Notice board',
                  style: meta?.copyWith(
                    color: fm.link,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                Row(
                  children: [
                    MateAvatar(latest.mateId, size: Sizes.avatarSm),
                    const SizedBox(width: Space.sm),
                    Expanded(
                      child: Text(
                        '$who · ${Fmt.ago(latest.createdAt)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: meta,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: Space.sm),
              if (latest == null) ...[
                Text(
                  'Nothing on the board.',
                  style: context.text.bodyMedium,
                ),
                Text(
                  'Post a Notice',
                  style: context.text.bodyMedium?.copyWith(
                    color: fm.inkSoft,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ] else
                Text(
                  latest.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodyMedium?.copyWith(height: 1.35),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The basket and how many Grocery items are open; opens the Groceries tab.
class _GroceriesCard extends ConsumerWidget {
  const _GroceriesCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final items = ref.watch(groceriesControllerProvider).value ?? const [];
    final open = items.where((g) => g.boughtAt == null).length;
    return Semantics(
      button: true,
      label: open == 1 ? '1 Grocery item to buy' : '$open Grocery items to buy',
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          onTap: () => context.navigateTo(const GroceriesRoute()),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Space.xs,
              vertical: 14,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon(
                  HugeIcons.strokeRoundedShoppingBasket01,
                  size: 24,
                  color: fm.link,
                ),
                const SizedBox(height: Space.sm),
                FittedBox(
                  child: Text(
                    '$open',
                    style: context.text.headlineMedium?.copyWith(height: 1),
                  ),
                ),
                Text('to buy', style: context.text.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
