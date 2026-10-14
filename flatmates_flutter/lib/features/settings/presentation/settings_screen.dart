import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/theme_mode_provider.dart';
import '../../../core/services/push_service.dart';
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
        radius: 32,
        onTap: mine
            ? null
            : () => runAction(
                context,
                () => ref
                    .read(myFlatControllerProvider.notifier)
                    .setMyColor(color),
              ),
        child: Container(
          // 3px ink ring, 2px off the face, on my colour.
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: mine ? context.fm.ink : Colors.transparent,
              width: 3,
            ),
          ),
          child: Avatar(
            name: swatch.name,
            colorIndex: color.index,
            size: Sizes.avatarLg,
          ),
        ),
      ),
    );
  }
}

/// Which pushes the Mate gets, in the words of what the server sends, and
/// whether this phone shows them at all.
class _NotificationsCard extends ConsumerWidget {
  const _NotificationsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final me = directory.me;
    String clock(int minutes) =>
        TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60).format(context);
    void save(Mate wanted) => runAction(
      context,
      () =>
          ref.read(myFlatControllerProvider.notifier).setNotifications(wanted),
    );
    final switches = [
      (
        'My Turn starts',
        'When its Turn time starts, or when a Turn passes to me',
        me.notifyTurnStarts,
        (bool v) => me.copyWith(notifyTurnStarts: v),
      ),
      (
        'Reminder if my Turn isn\'t Done',
        'An hour before its Turn time ends',
        me.notifyReminder,
        (bool v) => me.copyWith(notifyReminder: v),
      ),
      (
        'Mates\' Turns not Done',
        'At ${clock(matesNotDoneAt)}, unless I\'m Away',
        me.notifyMatesNotDone,
        (bool v) => me.copyWith(notifyMatesNotDone: v),
      ),
      (
        'Night summary',
        'At ${clock(nightSummaryAt)}: what got Done today and what didn\'t',
        me.notifyNightSummary,
        (bool v) => me.copyWith(notifyNightSummary: v),
      ),
      (
        'New Notice',
        'When a Mate posts on the Notice board',
        me.notifyNotice,
        (bool v) => me.copyWith(notifyNotice: v),
      ),
      (
        'Added to a Rotation',
        'When the Admin adds me to a Chore',
        me.notifyAddedToRotation,
        (bool v) => me.copyWith(notifyAddedToRotation: v),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.lg, 14, Space.lg, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text('Notifications', style: context.text.titleMedium),
            ),
            if (ref.watch(pushAllowedProvider).value == false)
              const _PhoneOff(),
            for (final (i, (title, detail, on, change))
                in switches.indexed) ...[
              if (i > 0) const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(title, style: context.text.titleSmall),
                subtitle: Text(detail, style: context.text.bodySmall),
                value: on,
                onChanged: (v) => save(change(v)),
              ),
            ],
            const SizedBox(height: Space.xs),
            Text(
              'Mates joining, Events a Mate tells the Flat about, and '
              'becoming the Admin always come through.',
              style: context.text.bodySmall?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

/// This phone doesn't show the app's notifications: the soft ask again, for
/// whoever said "Not now" in onboarding.
class _PhoneOff extends ConsumerStatefulWidget {
  const _PhoneOff();

  @override
  ConsumerState<_PhoneOff> createState() => _PhoneOffState();
}

class _PhoneOffState extends ConsumerState<_PhoneOff> {
  bool _asking = false;

  Future<void> _turnOn() async {
    setState(() => _asking = true);
    final allowed = await ref.read(pushServiceProvider).ask();
    ref.invalidate(pushAllowedProvider);
    if (!mounted) return;
    setState(() => _asking = false);
    // Denied before: the phone won't ask again, only its settings can.
    if (!allowed) {
      showMessage(
        ScaffoldMessenger.of(context),
        'Your phone has notifications off for Flatmates. Turn them on in '
        'its Settings.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Container(
      margin: const EdgeInsets.only(top: Space.md, bottom: Space.xs),
      padding: const EdgeInsets.all(Space.md),
      decoration: BoxDecoration(
        color: fm.ground,
        borderRadius: BorderRadius.circular(Radii.input),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Off on this phone',
                  style: context.text.titleSmall,
                ),
                Text(
                  'None of these reach you until they\'re on.',
                  style: context.text.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.sm),
          FilledButton(
            onPressed: _asking ? null : _turnOn,
            // The theme's buttons are full width; this one sits in a row.
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, Sizes.buttonSecondary),
              padding: const EdgeInsets.symmetric(horizontal: Space.lg),
            ),
            child: const Text('Turn on'),
          ),
        ],
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
