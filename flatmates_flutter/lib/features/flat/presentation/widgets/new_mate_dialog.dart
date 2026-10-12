import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/action_runner.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../chores/application/chores_controller.dart';
import '../../application/flat_actions.dart';
import '../../application/mate_directory.dart';

/// Admin only: tells them [mate] joined and lets them pick the Chores to add
/// the new Mate to. Closing it without answering asks again next time.
Future<void> showNewMateDialog(BuildContext context, Mate mate) =>
    showDialog<void>(
      context: context,
      builder: (_) => _NewMateDialog(mate: mate),
    );

class _NewMateDialog extends ConsumerStatefulWidget {
  const _NewMateDialog({required this.mate});

  final Mate mate;

  @override
  ConsumerState<_NewMateDialog> createState() => _NewMateDialogState();
}

class _NewMateDialogState extends ConsumerState<_NewMateDialog> {
  /// The Chores ticked; null until they load, then all of them.
  Set<int>? _picked;
  String? _error;

  // Errors show in the dialog: a snackbar would sit behind it.
  Future<void> _answer(List<int> choreIds) async {
    setState(() => _error = null);
    try {
      final ran = await ref
          .read(welcomeMateProvider(widget.mate.id!).notifier)
          .run(choreIds);
      if (ran && mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) setState(() => _error = describeError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final name = widget.mate.displayName;
    final flatName = ref.watch(mateDirectoryProvider).flat.name;
    final chores = ref.watch(choresControllerProvider).value?.chores;
    final busy = ref.watch(welcomeMateProvider(widget.mate.id!)).isLoading;
    final picked = _picked ??= chores?.map((c) => c.id!).toSet();

    return AlertDialog(
      icon: MateAvatar(widget.mate.id, size: 48),
      title: Text('$name joined $flatName'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(switch (chores) {
              null => 'Loading Chores…',
              [] => 'There are no Chores yet. Add $name when you make one.',
              _ => 'Add $name to these Chores? They go last in each Rotation.',
            }),
            if (chores != null)
              for (final chore in chores)
                CheckboxListTile(
                  value: picked!.contains(chore.id),
                  onChanged: busy
                      ? null
                      : (on) => setState(
                          () => on!
                              ? picked.add(chore.id!)
                              : picked.remove(chore.id),
                        ),
                  title: Text(chore.name),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
            if (_error != null)
              Semantics(
                liveRegion: true,
                child: Text(
                  _error!,
                  style: context.text.bodySmall?.copyWith(
                    color: fm.dangerFg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        if (chores?.isNotEmpty ?? false) ...[
          TextButton(
            onPressed: busy ? null : () => _answer(const []),
            style: TextButton.styleFrom(foregroundColor: fm.ink),
            child: const Text('Later'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: busy || picked!.isEmpty
                ? null
                : () => _answer(picked.toList()),
            child: Text(
              'Add to ${picked!.length} '
              '${picked.length == 1 ? 'Chore' : 'Chores'}',
            ),
          ),
        ] else
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: busy || chores == null ? null : () => _answer(const []),
            child: const Text('OK'),
          ),
      ],
    );
  }
}
