import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_header.dart';
import '../../auth/application/auth_controller.dart';
import '../../away/application/aways_controller.dart';
import '../../away/presentation/away_rule_text.dart';
import '../../away/presentation/away_sheet.dart';
import '../application/mate_directory.dart';
import '../application/my_flat_controller.dart';
import 'widgets/away_rule_picker.dart';
import 'widgets/invite_card.dart';
import 'widgets/mate_tile.dart';

/// The Flat: invite code, Away, Mates, Admin settings and account.
@RoutePage()
class FlatScreen extends ConsumerWidget {
  const FlatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final aways = ref.watch(awaysControllerProvider).value ?? const [];
    final myAways = aways.where((a) => directory.isMe(a.mateId)).toList();
    final theme = Theme.of(context);
    final flat = directory.flat;

    return Scaffold(
      appBar: AppBar(title: Text(flat.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(Insets.lg, 0, Insets.lg, Insets.xxl),
        children: [
          if (directory.amAdmin) InviteCard(code: flat.inviteCode),
          const SectionHeader(
            'Away',
            padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
          ),
          Card(
            child: Column(
              children: [
                for (final a in myAways)
                  ListTile(
                    leading: Icon(
                      Icons.flight_takeoff_rounded,
                      color: context.colors.away,
                    ),
                    title: Text(
                      '${Fmt.day(a.startsAt)} → ${Fmt.day(a.endsAt.subtract(const Duration(seconds: 1)))}',
                    ),
                    trailing: a.startsAt.isAfter(DateTime.now())
                        ? TextButton(
                            onPressed: () => runAction(
                              context,
                              () => ref
                                  .read(awaysControllerProvider.notifier)
                                  .cancel(a.id!),
                              success: 'Away cancelled',
                            ),
                            child: const Text('Cancel'),
                          )
                        : Text(
                            'Now',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: context.colors.away,
                            ),
                          ),
                  ),
                ListTile(
                  leading: Icon(
                    Icons.add_circle_outline_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Mark me away'),
                  subtitle: Text(
                    'Flat rule: ${flat.awayRule.label}',
                    style: theme.textTheme.bodySmall,
                  ),
                  onTap: () => showAwaySheet(context),
                ),
              ],
            ),
          ),
          SectionHeader(
            'Mates · ${directory.mates.length}',
            padding: const EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
          ),
          Card(
            child: Column(
              children: [
                for (final m in directory.mates) MateTile(mate: m),
              ],
            ),
          ),
          if (directory.amAdmin) ...[
            const SectionHeader(
              'When someone is away',
              padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
            ),
            AwayRulePicker(current: flat.awayRule),
          ],
          const SectionHeader(
            'Account',
            padding: EdgeInsets.fromLTRB(0, Insets.xl, 0, Insets.sm),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    color: theme.colorScheme.error,
                  ),
                  title: const Text('Leave flat'),
                  subtitle:
                      directory.amAdmin && directory.mates.length > 1
                          ? const Text('Make someone else admin first.')
                          : null,
                  onTap: () => _leave(context, ref),
                ),
                ListTile(
                  leading: const Icon(Icons.power_settings_new_rounded),
                  title: const Text('Sign out'),
                  onTap: () =>
                      ref.read(authControllerProvider.notifier).signOut(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _leave(BuildContext context, WidgetRef ref) async {
    final yes = await confirm(
      context,
      title: 'Leave this flat?',
      message: 'Your open turns go to the next mate in each rotation.',
      confirmLabel: 'Leave',
      destructive: true,
    );
    if (!yes || !context.mounted) return;
    await runAction(
      context,
      () => ref.read(myFlatControllerProvider.notifier).leave(),
    );
  }
}
