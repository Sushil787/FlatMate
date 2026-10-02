import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../flat/application/mate_directory.dart';
import '../../application/notices_controller.dart';

enum _NoticeAction { pin, unpin, delete }

/// A notice, styled like a note on the fridge; pinned ones stand out.
class NoticeCard extends ConsumerWidget {
  const NoticeCard({super.key, required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final theme = Theme.of(context);
    final colors = context.colors;
    final canDelete = directory.isMe(notice.mateId) || directory.amAdmin;
    final controller = ref.read(noticesControllerProvider.notifier);

    final background = notice.pinned
        ? colors.warningContainer
        : theme.colorScheme.surfaceContainerLowest;
    final foreground = notice.pinned
        ? colors.onWarningContainer
        : theme.colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: notice.pinned
            ? null
            : Border.all(color: theme.colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.fromLTRB(Insets.lg, Insets.md, Insets.xs, Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MateAvatar(
                mateId: notice.mateId,
                name: directory.realNameOf(notice.mateId),
                size: 30,
              ),
              const SizedBox(width: Insets.sm),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: directory.nameOf(notice.mateId),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: foreground,
                        ),
                      ),
                      TextSpan(
                        text: '  ·  ${Fmt.ago(notice.createdAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foreground.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (notice.pinned)
                Icon(Icons.push_pin_rounded, size: 18, color: foreground),
              if (directory.amAdmin || canDelete)
                PopupMenuButton<_NoticeAction>(
                  icon: Icon(Icons.more_horiz_rounded, color: foreground),
                  onSelected: (action) => runAction(
                    context,
                    () => switch (action) {
                      _NoticeAction.pin => controller.setPinned(notice, true),
                      _NoticeAction.unpin => controller.setPinned(notice, false),
                      _NoticeAction.delete => controller.delete(notice),
                    },
                  ),
                  itemBuilder: (_) => [
                    if (directory.amAdmin)
                      notice.pinned
                          ? const PopupMenuItem(
                              value: _NoticeAction.unpin,
                              child: Text('Unpin'),
                            )
                          : const PopupMenuItem(
                              value: _NoticeAction.pin,
                              child: Text('Pin to top'),
                            ),
                    if (canDelete)
                      const PopupMenuItem(
                        value: _NoticeAction.delete,
                        child: Text('Delete'),
                      ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: Insets.sm),
          Padding(
            padding: const EdgeInsets.only(right: Insets.md),
            child: Text(
              notice.text,
              style: theme.textTheme.bodyLarge?.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
