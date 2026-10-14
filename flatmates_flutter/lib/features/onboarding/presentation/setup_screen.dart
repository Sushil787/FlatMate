import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/services/push_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../away/presentation/away_rule_text.dart';
import '../../away/presentation/away_sheet.dart';
import '../../calendar/presentation/widgets/month_grid.dart';
import '../../chores/presentation/chore_editor_sheet.dart';
import '../../flat/application/flat_actions.dart';
import '../../flat/application/mate_directory.dart';
import '../../home/presentation/widgets/home_empty.dart';
import '../../home/presentation/widgets/turn_card.dart';
import '../application/practice.dart';
import 'notifications_ask.dart';
import 'step_layout.dart';

enum _Step { chore, invite, welcome, done, away, notifications }

/// Onboarding, straight after creating or joining a Flat, until the Mate
/// finishes it (saved on the server as their onboardedAt). A practice run
/// of the main things on the real screens, with a pretend Flat that's
/// never saved (see [practiceProvider]): the Admin makes a Chore and shares
/// the real Invite; everyone marks a Turn Done and marks themselves Away.
/// Then the notifications soft ask, if the phone hasn't allowed them.
@RoutePage()
class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  int _index = 0;
  bool _asking = false;

  /// Saves onboardedAt; Home opens as soon as the app has it.
  Future<void> _finish() =>
      runAction(context, ref.read(finishOnboardingProvider.notifier).run);

  void _next(List<_Step> steps) =>
      _index + 1 < steps.length ? setState(() => _index++) : _finish();

  Future<void> _turnOn() async {
    setState(() => _asking = true);
    await ref.read(pushServiceProvider).ask();
    ref.invalidate(pushAllowedProvider);
    await _finish();
    if (mounted) setState(() => _asking = false);
  }

  @override
  Widget build(BuildContext context) {
    final directory = ref.watch(practiceProvider).directory;
    final askFirst = ref.watch(pushAllowedProvider).value == false;
    final steps = [
      if (directory.amAdmin) ...[_Step.chore, _Step.invite] else _Step.welcome,
      _Step.done,
      _Step.away,
      if (askFirst) _Step.notifications,
    ];
    final at = _index.clamp(0, steps.length - 1);
    final step = steps[at];
    final finishing = ref.watch(finishOnboardingProvider).isLoading;
    final nextLabel = at == steps.length - 1 ? 'Start using Flatmates' : 'Next';
    void next() => _next(steps);

    return PopScope(
      canPop: at == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _index = at - 1);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Space.screenMargin,
              Space.lg,
              Space.screenMargin,
              Space.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: Space.sm,
                  runSpacing: Space.sm,
                  children: [
                    _Dots(count: steps.length, at: at),
                    if (step case _Step.chore || _Step.done || _Step.away)
                      const Tag('Practice · nothing is saved'),
                  ],
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Timing.delayed,
                    child: KeyedSubtree(
                      key: ValueKey(step),
                      child: switch (step) {
                        _Step.chore => _ChoreStep(onNext: next),
                        _Step.invite => _InviteStep(onNext: next),
                        _Step.welcome => _WelcomeStep(onNext: next),
                        _Step.done => _DoneStep(
                          nextLabel: nextLabel,
                          busy: finishing,
                          onNext: next,
                        ),
                        _Step.away => _AwayStep(
                          nextLabel: nextLabel,
                          busy: finishing,
                          onNext: next,
                        ),
                        _Step.notifications => NotificationsAsk(
                          asking: _asking || finishing,
                          onYes: _turnOn,
                          onNo: _finish,
                        ),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "You, Maya and Sam".
String _names(MateDirectory directory, Iterable<UuidValue?> ids) {
  final names = [for (final id in ids) directory.nameOf(id)];
  return names.length < 2
      ? names.join()
      : '${names.take(names.length - 1).join(', ')} and ${names.last}';
}

/// A Mate of the practice Flat, which may be a pretend one.
Widget _avatar(MateDirectory directory, UuidValue? id) => Avatar(
  name: directory.realNameOf(id),
  colorIndex: directory.colorIndexOf(id),
);

/// Admin: make a Chore in the real editor, on the practice Flat.
class _ChoreStep extends ConsumerWidget {
  const _ChoreStep({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final practice = ref.watch(practiceProvider);
    final directory = practice.directory;
    final chore = practice.chore;
    final others = [
      for (final m in directory.mates)
        if (!directory.isMe(m.id)) m.id,
    ];
    Widget pick(String label, {String? name}) => TextButton(
      onPressed: () => showAppSheet(
        context,
        ChoreEditorView(
          name: name,
          directory: directory,
          saving: false,
          onSave: ref.read(practiceProvider.notifier).saveChore,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: fm.surface,
        foregroundColor: fm.ink,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        textStyle: context.text.titleSmall?.copyWith(fontSize: 14),
      ),
      child: Text(label),
    );

    return StepLayout(
      title: 'Make a Chore. You\'re not spared either.',
      body: chore == null
          ? 'Pick one to try. As the Admin you make the Chores, and you\'re '
                'in the Rotation like everyone: you go first, then '
                '${_names(directory, others)}.'
          : 'That\'s a Chore: the Rotation passes it on, one Turn at a time. '
                'Make your real ones from the Chores tab.',
      content: chore == null
          ? Wrap(
              spacing: Space.sm,
              runSpacing: Space.sm,
              children: [
                for (final name in NoChoresCard.suggestions)
                  pick('+ $name', name: name),
                pick('Something else'),
              ],
            )
          : RowCard(
              children: [
                AppRow(
                  leading: _avatar(directory, chore.rotation.first),
                  title: Text(chore.name),
                  meta: Text(
                    '${everyLabel(chore.period)} · ${chore.turnTime.label} · '
                    '${_names(directory, chore.rotation)}',
                  ),
                ),
              ],
            ),
      action: PrimaryButton(
        label: 'Next',
        onPressed: chore == null ? null : onNext,
      ),
    );
  }
}

/// Admin: share the real Invite (the same card Home shows). Sharing saves
/// nothing.
class _InviteStep extends ConsumerWidget {
  const _InviteStep({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    return StepLayout(
      content: InviteCard(
        meId: directory.me.id!,
        flatName: directory.flat.name,
        inviteCode: directory.flat.inviteCode,
      ),
      body:
          'This one\'s real: your Mates join with this code. It works for '
          '7 days, and you can make a new one in the Flat tab.',
      action: PrimaryButton(label: 'Next', onPressed: onNext),
    );
  }
}

/// A Mate who joined: who's here, and that the Admin adds them to Chores.
class _WelcomeStep extends ConsumerWidget {
  const _WelcomeStep({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final admin = directory.realNameOf(directory.flat.adminMateId);
    return StepLayout(
      art: ExcludeSemantics(
        child: Wrap(
          spacing: Space.sm,
          runSpacing: Space.sm,
          children: [
            for (final m in directory.mates)
              MateAvatar(m.id, size: Sizes.avatarLg),
          ],
        ),
      ),
      title: 'You\'re in ${directory.flat.name}.',
      body:
          'You\'re not spared from the Chores either: $admin will add you '
          'to a Rotation soon. First, a quick practice run. Nothing you do '
          'in it is saved.',
      action: PrimaryButton(label: 'Next', onPressed: onNext),
    );
  }
}

/// Everyone: the real Turn card on the practice Chore, and Mark Done.
class _DoneStep extends ConsumerWidget {
  const _DoneStep({
    required this.nextLabel,
    required this.busy,
    required this.onNext,
  });

  final String nextLabel;
  final bool busy;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final practice = ref.watch(practiceProvider);
    final directory = practice.directory;
    final chore = practice.chore!;
    final next = chore.rotation.length > 1
        ? directory.realNameOf(chore.rotation[1])
        : null;
    final now = DateTime.now();

    return StepLayout(
      title: 'Your Turn? Do it, then Mark Done.',
      body:
          'On the day of your Turn, this card is on Home. If the day ends '
          'before you mark it Done, the Turn is Missed.',
      content: practice.done
          ? RowCard(
              children: [
                AppRow(
                  leading: Container(
                    width: Sizes.avatarMd,
                    height: Sizes.avatarMd,
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
                  title: Text(chore.name),
                  meta: Text(next == null ? 'Done' : 'Done · $next is next'),
                ),
              ],
            )
          : TurnCard(
              chore: chore,
              endsAt: DateTime(now.year, now.month, now.day + 1),
              nextLabel: next == null ? 'Nobody is next' : '$next is next',
              busy: false,
              onDone: ref.read(practiceProvider.notifier).markDone,
            ),
      action: PrimaryButton(
        label: nextLabel,
        busy: busy,
        onPressed: practice.done ? onNext : null,
      ),
    );
  }
}

/// Everyone: the real Away sheet on the practice Flat, with the real
/// planner showing who covers.
class _AwayStep extends ConsumerWidget {
  const _AwayStep({
    required this.nextLabel,
    required this.busy,
    required this.onNext,
  });

  final String nextLabel;
  final bool busy;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final practice = ref.watch(practiceProvider);
    final run = ref.read(practiceProvider.notifier);
    final directory = practice.directory;
    final rule = directory.flat.awayRule;
    final chore = practice.chore!;
    final away = practice.aways.lastOrNull;
    Widget effects(DateTime startDay, DateTime lastDay) => AwayEffectsView(
      effects: AsyncData(run.awayEffects(startDay, lastDay)),
      directory: directory,
      choreName: (_) => chore.name,
    );

    return StepLayout(
      title: 'Going away? Mark yourself Away.',
      body:
          'Do it before you go, from the Flat tab. Your Flat\'s Away rule is '
          '${rule.label}: ${rule.explanation}',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Space.md,
        children: [
          RowCard(
            children: [
              AppRow(
                minHeight: 52,
                leading: AppIcon(
                  HugeIcons.strokeRoundedAirplane01,
                  color: fm.awayFg,
                ),
                title: Text(
                  away == null
                      ? 'Mark myself Away'
                      : 'Away · ${dayRange(Day.local(away.startDay), Day.local(away.lastDay))}',
                ),
                trailing: AppIcon(
                  HugeIcons.strokeRoundedArrowRight01,
                  color: fm.inkSoft,
                ),
                onTap: () => showAppSheet(
                  context,
                  AwaySheetView(
                    directory: directory,
                    aways: practice.aways,
                    saving: false,
                    onSave: run.markAway,
                    preview: effects,
                  ),
                ),
              ),
            ],
          ),
          if (away != null) effects(away.startDay, away.lastDay),
        ],
      ),
      action: PrimaryButton(
        label: nextLabel,
        busy: busy,
        onPressed: away == null ? null : onNext,
      ),
    );
  }
}

/// Which step of how many, as dots.
class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.at});

  final int count;
  final int at;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      label: 'Step ${at + 1} of $count',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: Timing.standard,
              width: i == at ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i <= at ? fm.ink : fm.line,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
