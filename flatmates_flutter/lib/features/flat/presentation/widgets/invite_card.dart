import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/action_runner.dart';
import '../../application/my_flat_controller.dart';

/// Admin-only: the Flat's Invite code, with copy and regenerate.
class InviteCard extends ConsumerWidget {
  const InviteCard({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(Insets.xl),
      decoration: BoxDecoration(
        gradient: context.colors.heroGradient,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.vpn_key_rounded, color: Colors.white),
              const SizedBox(width: Insets.sm),
              Expanded(
                child: Text(
                  'Invite your flatmates',
                  style: text.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.lg),
          Row(
            children: [
              for (final char in code.characters)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(vertical: Insets.md),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(Radii.sm),
                    ),
                    child: Text(
                      char,
                      textAlign: TextAlign.center,
                      style: text.headlineSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Insets.md),
          Text(
            'They enter this code after signing in and join as mates.',
            style: text.bodySmall?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: Insets.lg),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(0, 44),
                  ),
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: const Text('Copy code'),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invite code copied')),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: Insets.sm),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('New code'),
                onPressed: () async {
                  final yes = await confirm(
                    context,
                    title: 'Make a new code?',
                    message: 'The current code stops working.',
                    confirmLabel: 'New code',
                  );
                  if (!yes || !context.mounted) return;
                  await runAction(
                    context,
                    () => ref
                        .read(myFlatControllerProvider.notifier)
                        .regenerateInvite(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
