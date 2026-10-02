import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/section_header.dart';
import '../application/notices_controller.dart';
import 'widgets/notice_card.dart';

/// The Flat's notice board. Posting pings everyone.
@RoutePage()
class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  final _text = TextEditingController();
  bool _posting = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _post() async {
    if (_text.text.trim().isEmpty) return;
    setState(() => _posting = true);
    final ok = await runAction(
      context,
      () => ref.read(noticesControllerProvider.notifier).post(_text.text),
    );
    if (!mounted) return;
    setState(() => _posting = false);
    if (ok) _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticesControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Notice board')),
      body: Column(
        children: [
          Expanded(
            child: AsyncValueView(
              value: notices,
              onRetry: () => ref.invalidate(noticesControllerProvider),
              data: (list) {
                if (list.isEmpty) {
                  return const EmptyState(
                    icon: Icons.sticky_note_2_rounded,
                    title: 'The board is clear',
                    message:
                        'Post a note for the flat: parties, repairs, "who took my oat milk?". Everyone gets a ping.',
                  );
                }
                final pinned = list.where((n) => n.pinned).toList();
                final rest = list.where((n) => !n.pinned).toList();
                return RefreshIndicator(
                  onRefresh: ref
                      .read(noticesControllerProvider.notifier)
                      .refresh,
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: Insets.lg),
                    children: [
                      if (pinned.isNotEmpty) ...[
                        const SectionHeader(
                          'Pinned',
                          padding: EdgeInsets.fromLTRB(
                            Insets.lg,
                            Insets.sm,
                            Insets.lg,
                            Insets.sm,
                          ),
                        ),
                        for (final n in pinned) _padded(NoticeCard(notice: n)),
                      ],
                      if (rest.isNotEmpty) ...[
                        SectionHeader(
                          'Latest',
                          padding: EdgeInsets.fromLTRB(
                            Insets.lg,
                            pinned.isEmpty ? Insets.sm : Insets.lg,
                            Insets.lg,
                            Insets.sm,
                          ),
                        ),
                        for (final n in rest) _padded(NoticeCard(notice: n)),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Material(
            color: theme.colorScheme.surfaceContainerLowest,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(Insets.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _text,
                        minLines: 1,
                        maxLines: 5,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          hintText: 'Write a notice for everyone…',
                        ),
                      ),
                    ),
                    const SizedBox(width: Insets.sm),
                    IconButton.filled(
                      iconSize: 22,
                      style: IconButton.styleFrom(
                        minimumSize: const Size(52, 52),
                      ),
                      onPressed: _posting ? null : _post,
                      icon: const Icon(Icons.send_rounded),
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

  Widget _padded(Widget child) => Padding(
    padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.md),
    child: child,
  );
}
