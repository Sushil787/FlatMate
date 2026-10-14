import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../flat/application/mate_directory.dart';
import '../application/notice_actions.dart';
import '../application/notices_controller.dart';
import '../../../core/widgets/app_icon.dart';

/// The Flat's notice board: Notices with Got it, and a composer docked at
/// the bottom. Posting pings everyone.
@RoutePage()
class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _post() async {
    if (_text.text.trim().isEmpty) return;
    final ok = await runAction(
      context,
      () => ref.read(postNoticeProvider.notifier).run(_text.text),
    );
    if (ok && mounted) _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticesControllerProvider);
    final me = ref.watch(mateDirectoryProvider).me.id;
    final fm = context.fm;
    const header = ScreenHeader('Notice board', back: true);

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(Space.lg, Space.lg, Space.lg, 0),
              child: header,
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: AsyncValueView(
                value: notices,
                onRetry: () => ref.invalidate(noticesControllerProvider),
                data: (list) {
                  Notice? newest;
                  for (final n in list.where((n) => n.isNewFor(me))) {
                    if (newest == null ||
                        n.createdAt.isAfter(newest.createdAt)) {
                      newest = n;
                    }
                  }
                  return RefreshIndicator(
                    onRefresh: ref
                        .read(noticesControllerProvider.notifier)
                        .refresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(Space.lg),
                      itemCount: list.isEmpty ? 1 : list.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: Space.md),
                      itemBuilder: (_, i) {
                        if (list.isEmpty) return const _Empty();
                        final n = list[i];
                        return _NoticeCard(
                          key: ValueKey(n.id),
                          notice: n,
                          highlight: n == newest,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: fm.surface,
              border: Border(top: BorderSide(color: fm.line)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Space.lg,
                  Space.md,
                  Space.lg,
                  Space.md,
                ),
                child: Row(
                  children: [
                    MateAvatar(me),
                    const SizedBox(width: Space.sm),
                    Expanded(
                      child: TextField(
                        controller: _text,
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        style: context.text.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Post a Notice to the Flat…',
                          fillColor: fm.ground,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          enabledBorder: _pill(fm.line),
                          focusedBorder: _pill(fm.ink),
                        ),
                      ),
                    ),
                    const SizedBox(width: Space.sm),
                    IconButton(
                      tooltip: 'Post Notice',
                      onPressed: ref.watch(postNoticeProvider).isLoading
                          ? null
                          : _post,
                      icon: const AppIcon(HugeIcons.strokeRoundedArrowUp02),
                      style: IconButton.styleFrom(
                        backgroundColor: fm.primary,
                        foregroundColor: fm.onPrimary,
                        disabledBackgroundColor: fm.fillQuiet,
                        fixedSize: const Size.square(52),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static OutlineInputBorder _pill(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(26),
    borderSide: BorderSide(color: color, width: 2),
  );
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Space.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('No Notices yet', style: context.text.titleMedium),
            const SizedBox(height: Space.xs),
            Text(
              'Post one below: a party, a repair, a parcel. Everyone in the Flat gets a ping.',
              style: context.text.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

enum _NoticeAction { pin, unpin, delete }

/// A Notice: author, text, and who said Got it. [highlight] marks the
/// newest one I haven't said Got it to.
class _NoticeCard extends ConsumerWidget {
  const _NoticeCard({super.key, required this.notice, required this.highlight});

  final Notice notice;
  final bool highlight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final id = notice.id!;
    final acting =
        ref.watch(pinNoticeProvider(id)).isLoading ||
        ref.watch(deleteNoticeProvider(id)).isLoading;
    final fm = context.fm;
    final me = directory.me.id;
    final mine = directory.isMe(notice.mateId);
    final canDelete = mine || directory.amAdmin;
    final iGotIt = notice.gotItMateIds?.contains(me) ?? false;

    // Only active Mates count; the author can't say Got it.
    final readers = {
      for (final m in directory.mates)
        if (m.id != notice.mateId) m.id!,
    };
    final got = [...?notice.gotItMateIds].where(readers.contains).toList();
    final everyone = readers.isNotEmpty && readers.every(got.contains);
    final others = got.where((id) => id != me).toList();
    final summary = everyone
        ? 'Everyone has seen this'
        : others.isEmpty
        ? null
        : '${Fmt.and(others.map(directory.realNameOf).toList())} got it';

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      decoration: BoxDecoration(
        color: fm.surface,
        borderRadius: BorderRadius.circular(Radii.card),
        border: Border.all(
          color: highlight ? fm.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MateAvatar(notice.mateId),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      directory.nameOf(notice.mateId),
                      style: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      Fmt.ago(notice.createdAt),
                      style: context.text.bodySmall,
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  if (notice.isNewFor(me))
                    const Tag('New', tone: TagTone.fresh),
                  if (notice.pinned) const Tag('Pinned'),
                ],
              ),
              if (directory.amAdmin || canDelete)
                PopupMenuButton<_NoticeAction>(
                  tooltip: 'More for this Notice',
                  icon: AppIcon(
                    HugeIcons.strokeRoundedMoreVertical,
                    color: fm.inkSoft,
                  ),
                  enabled: !acting,
                  onSelected: (action) => _act(context, ref, action),
                  itemBuilder: (_) => [
                    if (directory.amAdmin)
                      notice.pinned
                          ? const PopupMenuItem(
                              value: _NoticeAction.unpin,
                              child: Text('Unpin'),
                            )
                          : const PopupMenuItem(
                              value: _NoticeAction.pin,
                              child: Text('Pin to the top'),
                            ),
                    if (canDelete)
                      const PopupMenuItem(
                        value: _NoticeAction.delete,
                        child: Text('Delete'),
                      ),
                  ],
                )
              else
                const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: Space.sm),
          Padding(
            padding: const EdgeInsets.only(right: Space.sm),
            child: Text(
              notice.text,
              style: context.text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          if (!mine || summary != null) ...[
            const SizedBox(height: Space.sm),
            Wrap(
              spacing: Space.sm,
              runSpacing: Space.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (!mine)
                  TextButton(
                    onPressed: iGotIt || ref.watch(gotItProvider(id)).isLoading
                        ? null
                        : () => runAction(
                            context,
                            () => ref
                                .read(gotItProvider(id).notifier)
                                .run(notice),
                          ),
                    style: TextButton.styleFrom(
                      backgroundColor: fm.fillQuiet,
                      foregroundColor: fm.ink,
                      disabledBackgroundColor: fm.doneBg,
                      disabledForegroundColor: fm.doneFg,
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      tapTargetSize: MaterialTapTargetSize.padded,
                      textStyle: context.text.bodySmall?.copyWith(
                        fontWeight: iGotIt ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                    child: Text(iGotIt ? 'You got it' : 'Got it'),
                  ),
                if (!everyone && others.isNotEmpty)
                  AvatarStack(mateIds: others, size: 20),
                if (summary != null)
                  Text(summary, style: context.text.bodySmall),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _act(
    BuildContext context,
    WidgetRef ref,
    _NoticeAction action,
  ) async {
    if (action == _NoticeAction.delete) {
      final yes = await confirm(
        context,
        title: 'Delete this Notice?',
        message: 'It goes from the board for everyone in the Flat.',
        confirmLabel: 'Delete',
        destructive: true,
      );
      if (!yes || !context.mounted) return;
    }
    await runAction(
      context,
      () => switch (action) {
        _NoticeAction.pin =>
          ref.read(pinNoticeProvider(notice.id!).notifier).run(notice, true),
        _NoticeAction.unpin =>
          ref.read(pinNoticeProvider(notice.id!).notifier).run(notice, false),
        _NoticeAction.delete =>
          ref.read(deleteNoticeProvider(notice.id!).notifier).run(notice),
      },
    );
  }
}
