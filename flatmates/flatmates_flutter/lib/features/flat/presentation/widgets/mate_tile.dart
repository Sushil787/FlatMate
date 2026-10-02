import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/action_runner.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../../core/widgets/status_pill.dart';
import '../../application/mate_directory.dart';
import '../../application/my_flat_controller.dart';

enum _MateAction { makeAdmin, remove }

/// A Mate in the Flat, with Admin actions for the Admin.
class MateTile extends ConsumerWidget {
  const MateTile({super.key, required this.mate});

  final Mate mate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final scheme = Theme.of(context).colorScheme;
    final isMe = directory.isMe(mate.id);

    return ListTile(
      leading: MateAvatar(mateId: mate.id, name: mate.displayName),
      title: Text(isMe ? '${mate.displayName} (you)' : mate.displayName),
      subtitle: directory.isAdmin(mate.id) ? null : const Text('Mate'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (directory.isAdmin(mate.id))
            StatusPill(
              label: 'Admin',
              icon: Icons.star_rounded,
              background: scheme.primaryContainer,
              foreground: scheme.onPrimaryContainer,
            ),
          if (directory.amAdmin && !isMe)
            PopupMenuButton<_MateAction>(
              onSelected: (action) => _act(context, ref, action),
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: _MateAction.makeAdmin,
                  child: Text('Make admin'),
                ),
                PopupMenuItem(
                  value: _MateAction.remove,
                  child: Text('Remove from flat'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _act(
    BuildContext context,
    WidgetRef ref,
    _MateAction action,
  ) async {
    final controller = ref.read(myFlatControllerProvider.notifier);
    final yes = await confirm(
      context,
      title: switch (action) {
        _MateAction.makeAdmin => 'Make ${mate.displayName} admin?',
        _MateAction.remove => 'Remove ${mate.displayName}?',
      },
      message: switch (action) {
        _MateAction.makeAdmin =>
          'They\'ll manage chores and invites. You\'ll be a regular mate.',
        _MateAction.remove =>
          'Their open turns go to the next mate in each rotation.',
      },
      confirmLabel: switch (action) {
        _MateAction.makeAdmin => 'Make admin',
        _MateAction.remove => 'Remove',
      },
      destructive: action == _MateAction.remove,
    );
    if (!yes || !context.mounted) return;
    await runAction(
      context,
      () => switch (action) {
        _MateAction.makeAdmin => controller.transferAdmin(mate.id!),
        _MateAction.remove => controller.removeMate(mate.id!),
      },
    );
  }
}
