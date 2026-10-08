import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/theme_mode_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../auth/application/auth_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../../flat/application/flat_actions.dart';
import '../../flat/application/my_flat_controller.dart';
import '../../flat/presentation/widgets/name_sheet.dart';

/// Profile, Mate colour, notifications, appearance, Sign out.
@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(Space.lg),
                children: const [
                  ScreenHeader('Profile and settings', back: true),
                  SizedBox(height: Space.xs),
                  _ProfileCard(),
                  SizedBox(height: Space.md),
                  _NotificationsCard(),
                  SizedBox(height: Space.md),
                  _AppearanceCard(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Space.lg,
                Space.sm,
                Space.lg,
                Space.xl,
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: ref.watch(signOutProvider).isLoading
                    ? null
                    : () => runAction(
                        context,
                        ref.read(signOutProvider.notifier).run,
                      ),
                child: const Text('Sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends ConsumerWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final directory = ref.watch(mateDirectoryProvider);
    final me = directory.me;
    final email = ref.watch(myProfileProvider).value?.email;
    final taken = {
      for (final m in directory.mates)
        if (m.id != me.id) m.color,
    };
    final takenNames = [
      for (final c in MateColor.values)
        if (taken.contains(c)) mateColors[c.index].name,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.lg, 14, Space.lg, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                MateAvatar(me.id, size: 56),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(me.displayName, style: context.text.titleLarge),
                      Text(
                        email == null ? 'Google' : '$email · Google',
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Space.sm),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: fm.ground,
                    foregroundColor: fm.ink,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    textStyle: context.text.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => showNameSheet(
                    context,
                    title: 'Your name',
                    label: 'What your Mates see',
                    initial: me.displayName,
                    saving: renameMeProvider,
                    save: (name) =>
                        ref.read(renameMeProvider.notifier).run(name),
                  ),
                  child: const Text('Edit'),
                ),
              ],
            ),
            const SizedBox(height: Space.md),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Your colour',
                  style: context.text.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  children: [
                    for (final c in MateColor.values)
                      if (!taken.contains(c))
                        _Swatch(color: c, mine: c == me.color),
                  ],
                ),
              ],
            ),
            if (takenNames.isNotEmpty) ...[
              const SizedBox(height: Space.xs),
              Text(
                '${Fmt.and(takenNames)} ${takenNames.length == 1 ? 'is' : 'are'} taken by your Mates.',
                style: context.text.bodySmall?.copyWith(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Swatch extends ConsumerWidget {
  const _Swatch({required this.color, required this.mine});

  final MateColor color;
  final bool mine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final swatch = mateColors[color.index];
    return Semantics(
      button: true,
      selected: mine,
      label: swatch.name,
      excludeSemantics: true,
      child: InkResponse(
        radius: 24,
        onTap: mine
            ? null
            : () => runAction(
                context,
                () => ref
                    .read(myFlatControllerProvider.notifier)
                    .setMyColor(color),
              ),
        child: SizedBox.square(
          dimension: Sizes.touchMin,
          child: Center(
            child: Container(
              // 3px ink ring, 2px off the swatch, on my colour.
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: mine ? context.fm.ink : Colors.transparent,
                  width: 3,
                ),
              ),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: swatch.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationsCard extends ConsumerWidget {
  const _NotificationsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(mateDirectoryProvider).me;
    void save(Mate wanted) => runAction(
      context,
      () =>
          ref.read(myFlatControllerProvider.notifier).setNotifications(wanted),
    );
    final switches = [
      (
        'My Turn starts',
        me.notifyTurnStarts,
        (bool v) => me.copyWith(notifyTurnStarts: v),
      ),
      (
        'Reminder 3 hours before my Turn ends',
        me.notifyReminder,
        (bool v) => me.copyWith(notifyReminder: v),
      ),
      (
        'A Turn was Missed',
        me.notifyMissed,
        (bool v) => me.copyWith(notifyMissed: v),
      ),
      (
        'New Notice',
        me.notifyNotice,
        (bool v) => me.copyWith(notifyNotice: v),
      ),
      (
        'Added to a Rotation',
        me.notifyAddedToRotation,
        (bool v) => me.copyWith(notifyAddedToRotation: v),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.lg, 14, Space.lg, Space.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text('Notifications', style: context.text.titleMedium),
            ),
            for (final (i, (label, on, change)) in switches.indexed) ...[
              if (i > 0) const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(label, style: context.text.titleSmall),
                value: on,
                onChanged: (v) => save(change(v)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AppearanceCard extends ConsumerWidget {
  const _AppearanceCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final current = ref.watch(themeModeControllerProvider);
    const modes = [
      (ThemeMode.system, 'System'),
      (ThemeMode.light, 'Light'),
      (ThemeMode.dark, 'Dark'),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Space.lg,
          Space.md,
          Space.lg,
          Space.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text('Appearance', style: context.text.titleMedium),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(Space.xs),
              decoration: BoxDecoration(
                color: fm.ground,
                borderRadius: BorderRadius.circular(Radii.nav),
              ),
              child: Row(
                children: [
                  for (final (mode, label) in modes)
                    Expanded(
                      child: Semantics(
                        inMutuallyExclusiveGroup: true,
                        selected: mode == current,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: mode == current
                                ? fm.ink
                                : Colors.transparent,
                            foregroundColor: mode == current
                                ? fm.surface
                                : fm.ink,
                            minimumSize: const Size(0, Sizes.touchMin),
                            padding: const EdgeInsets.symmetric(
                              horizontal: Space.xs,
                            ),
                            textStyle: context.text.titleSmall?.copyWith(
                              fontSize: 14,
                              fontWeight: mode == current
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          ),
                          onPressed: () => ref
                              .read(themeModeControllerProvider.notifier)
                              .set(mode),
                          child: Text(label),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Text size follows your phone\'s setting.',
              style: context.text.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
