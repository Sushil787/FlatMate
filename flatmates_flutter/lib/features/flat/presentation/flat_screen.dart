import 'package:auto_route/auto_route.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/router.gr.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/utils/day.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/layout.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/tag.dart';
import '../../away/application/aways_controller.dart';
import '../../away/presentation/away_rule_text.dart';
import '../../away/presentation/away_sheet.dart';
import '../../board/application/notices_controller.dart';
import '../application/mate_directory.dart';
import '../application/flat_actions.dart';
import 'widgets/name_sheet.dart';
import '../../../core/widgets/app_icon.dart';

/// The Flat tab: Mates, the Invite, the Away rule, and the way to the
/// notice board, settings and out of the Flat.
@RoutePage()
class FlatScreen extends ConsumerWidget {
  const FlatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final aways = ref.watch(awaysControllerProvider).value ?? const [];
    final newNotices =
        ref
            .watch(noticesControllerProvider)
            .value
            ?.where((n) => n.isNewFor(directory.me.id))
            .length ??
        0;
    final flat = directory.flat;
    final count = directory.mates.length;
    final fm = context.fm;
    const chevron = AppIcon(HugeIcons.strokeRoundedArrowRight01, size: 18);

    return HeaderScroll(
      gap: Space.md,
      header: CollapsingHeader(
        eyebrow: 'Your Flat · $count ${count == 1 ? 'Mate' : 'Mates'}',
        title: flat.name,
        collapsed: flat.name,
        trailing: directory.amAdmin
            ? (_) => CircleButton(
                icon: HugeIcons.strokeRoundedPencilEdit02,
                tooltip: 'Rename Flat',
                onPressed: () => showNameSheet(
                  context,
                  title: 'Rename Flat',
                  label: 'Flat name',
                  initial: flat.name,
                  saving: renameFlatProvider,
                  save: (name) =>
                      ref.read(renameFlatProvider.notifier).run(name),
                ),
              )
            : null,
      ),
      children: [
        RowCard(
          children: [
            for (final m in directory.mates)
              _MateRow(mate: m, awayLabel: _awayLabel(aways, m.id!)),
          ],
        ),
        if (directory.amAdmin)
          _InviteCard(
            flatName: flat.name,
            code: flat.inviteCode,
            expiresAt: flat.inviteExpiresAt,
          ),
        _AwayRuleCard(current: flat.awayRule, canChange: directory.amAdmin),
        RowCard(
          children: [
            AppRow(
              minHeight: 52,
              leading: AppIcon(HugeIcons.strokeRoundedSun03, color: fm.ink),
              title: const Text('Morning summary'),
              meta: Text(
                directory.amAdmin
                    ? 'When each Mate hears about their Turns for the day.'
                    : 'When each Mate hears about their Turns for the day. Only the Admin can change it.',
              ),
              trailing: Text(_morningOf(flat).format(context)),
              onTap:
                  directory.amAdmin &&
                      !ref.watch(setMorningSummaryProvider).isLoading
                  ? () => _pickMorning(context, ref, flat)
                  : null,
            ),
          ],
        ),
        IconTheme.merge(
          data: IconThemeData(color: fm.inkSoft),
          child: RowCard(
            children: [
              AppRow(
                minHeight: 52,
                leading: AppIcon(
                  HugeIcons.strokeRoundedAirplane01,
                  color: fm.awayFg,
                ),
                title: const Text('Mark myself Away'),
                trailing: chevron,
                onTap: () => showAwaySheet(context),
              ),
              AppRow(
                minHeight: 52,
                leading: AppIcon(
                  HugeIcons.strokeRoundedStickyNote01,
                  color: fm.ink,
                ),
                title: const Text('Notice board'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (newNotices > 0) ...[
                      Tag('$newNotices new', tone: TagTone.fresh),
                      const SizedBox(width: Space.sm),
                    ],
                    chevron,
                  ],
                ),
                onTap: () => context.router.push(const BoardRoute()),
              ),
              AppRow(
                minHeight: 52,
                leading: AppIcon(HugeIcons.strokeRoundedUser, color: fm.ink),
                title: const Text('Profile and settings'),
                trailing: chevron,
                onTap: () => context.router.push(const SettingsRoute()),
              ),
            ],
          ),
        ),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(foregroundColor: fm.dangerFg),
            onPressed: () => _leave(context, ref, directory),
            child: const Text('Leave the Flat'),
          ),
        ),
      ],
    );
  }

  static TimeOfDay _morningOf(Flat flat) => TimeOfDay(
    hour: flat.morningSummaryAt ~/ 60,
    minute: flat.morningSummaryAt % 60,
  );

  Future<void> _pickMorning(
    BuildContext context,
    WidgetRef ref,
    Flat flat,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _morningOf(flat),
      helpText: 'Morning summary',
    );
    if (picked == null || !context.mounted) return;
    await runAction(
      context,
      () => ref
          .read(setMorningSummaryProvider.notifier)
          .run(picked.hour * 60 + picked.minute),
      success: 'Morning summary is now at ${picked.format(context)}',
    );
  }

  /// "Away · back in 3 days" for a Mate who is Away today, else null.
  static String? _awayLabel(List<Away> aways, UuidValue mateId) {
    final today = Day.fromLocal(DateTime.now());
    DateTime? last;
    for (final a in aways) {
      if (a.mateId != mateId ||
          a.startDay.isAfter(today) ||
          a.lastDay.isBefore(today)) {
        continue;
      }
      if (last == null || a.lastDay.isAfter(last)) last = a.lastDay;
    }
    if (last == null) return null;
    final days = last.difference(today).inDays + 1;
    return days == 1 ? 'Away · back tomorrow' : 'Away · back in $days days';
  }

  Future<void> _leave(
    BuildContext context,
    WidgetRef ref,
    MateDirectory directory,
  ) async {
    if (directory.amAdmin && directory.mates.length > 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Hand Admin to another Mate first: tap their name above.',
          ),
        ),
      );
      return;
    }
    final yes = await confirm(
      context,
      title: 'Leave ${directory.flat.name}?',
      message:
          'Your Turns pass to the next Mate in each Rotation. You\'ll need the Invite to come back.',
      confirmLabel: 'Leave',
      destructive: true,
    );
    if (!yes || !context.mounted) return;
    await runAction(
      context,
      ref.read(leaveFlatProvider.notifier).run,
    );
  }
}

/// A Mate in the Flat. The Admin taps another Mate to hand over Admin or
/// remove them.
class _MateRow extends ConsumerWidget {
  const _MateRow({required this.mate, required this.awayLabel});

  final Mate mate;
  final String? awayLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final isMe = directory.isMe(mate.id);
    final isAdmin = directory.isAdmin(mate.id);
    return AppRow(
      minHeight: 54,
      leading: MateAvatar(mate.id, away: awayLabel != null),
      title: Text.rich(
        TextSpan(
          text: mate.displayName,
          children: [
            if (isMe)
              TextSpan(
                text: ' (you)',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: context.fm.inkSoft,
                ),
              ),
          ],
        ),
      ),
      // Capped so a long Away tag wraps instead of pushing out the name.
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 170),
        child: Wrap(
          alignment: WrapAlignment.end,
          spacing: 6,
          runSpacing: 4,
          children: [
            if (isAdmin) const Tag('Admin', tone: TagTone.ink),
            if (awayLabel != null) Tag(awayLabel!, tone: TagTone.away),
            if (!isAdmin && awayLabel == null)
              Text('Home', style: context.text.bodySmall),
          ],
        ),
      ),
      onTap: directory.amAdmin && !isMe ? () => _actions(context, ref) : null,
    );
  }

  void _actions(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final name = mate.displayName;
    showAppSheet<void>(
      context,
      Builder(
        builder: (sheet) => AppSheet(
          title: name,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(sheet);
                _makeAdmin(context, ref);
              },
              child: Text('Make $name the Admin'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: fm.dangerFg),
              onPressed: () {
                Navigator.pop(sheet);
                _remove(context, ref);
              },
              child: const Text('Remove from the Flat'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makeAdmin(BuildContext context, WidgetRef ref) async {
    final yes = await confirm(
      context,
      title: 'Make ${mate.displayName} the Admin?',
      message:
          'They\'ll create and edit Chores, share the Invite and set the Away rule. You stay a Mate.',
      confirmLabel: 'Make Admin',
    );
    if (!yes || !context.mounted) return;
    await runAction(
      context,
      ref.read(makeAdminProvider(mate.id!).notifier).run,
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final yes = await confirm(
      context,
      title: 'Remove ${mate.displayName}?',
      message: 'Their Turns pass to the next Mate in each Rotation.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!yes || !context.mounted) return;
    await runAction(
      context,
      ref.read(removeMateProvider(mate.id!).notifier).run,
    );
  }
}

/// Admin only: the Flat's Invite code to copy or share, and a new one.
class _InviteCard extends ConsumerWidget {
  const _InviteCard({
    required this.flatName,
    required this.code,
    required this.expiresAt,
  });

  final String flatName;
  final String code;
  final DateTime expiresAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    final button = context.text.titleSmall?.copyWith(
      fontWeight: FontWeight.w700,
    );
    final codeBox = Container(
      constraints: const BoxConstraints(minHeight: 52),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: 6),
      decoration: BoxDecoration(
        color: fm.surface,
        borderRadius: BorderRadius.circular(Radii.input),
      ),
      child: SelectableText(
        code,
        textAlign: TextAlign.center,
        style: context.text.titleLarge?.copyWith(letterSpacing: 1.6),
      ),
    );
    final copy = IconButton.outlined(
      constraints: const BoxConstraints.tightFor(width: 52, height: 52),
      tooltip: 'Copy Invite code',
      onPressed: () => _copy(context),
      icon: const AppIcon(HugeIcons.strokeRoundedCopy01),
    );
    final share = IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: fm.ink,
        foregroundColor: fm.surface,
      ),
      constraints: const BoxConstraints.tightFor(width: 52, height: 52),
      tooltip: 'Share Invite',
      onPressed: () => _share(context),
      icon: const AppIcon(HugeIcons.strokeRoundedShare08),
    );
    final big = MediaQuery.textScalerOf(context).scale(1) > 1.3;
    final left = expiresAt.difference(DateTime.now().toUtc());
    final expired = left <= Duration.zero;
    final days = (left.inMinutes / Duration.minutesPerDay).ceil();

    return Container(
      padding: const EdgeInsets.fromLTRB(Space.lg, 14, Space.lg, Space.xs),
      decoration: BoxDecoration(
        color: fm.primaryTint,
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: fm.onPrimaryTint),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: Space.sm,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'Invite a Mate',
                    style: context.text.titleMedium?.copyWith(
                      color: fm.onPrimaryTint,
                    ),
                  ),
                ),
                Text(
                  expired
                      ? 'Expired'
                      : days == 1
                      ? 'Code works for 1 more day'
                      : 'Code works for $days days',
                  style: context.text.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: expired ? fm.dangerFg : fm.onPrimaryTint,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (expired) ...[
              Text(
                'Nobody can join with $code any more. Make a new code to '
                'invite a Mate.',
                style: context.text.bodyMedium,
              ),
              const SizedBox(height: Space.md),
              FilledButton(
                style: FilledButton.styleFrom(textStyle: button),
                onPressed: () => _regenerate(context, ref, ask: false),
                child: const Text('New code'),
              ),
              const SizedBox(height: Space.md),
            ] else if (big) ...[
              codeBox,
              const SizedBox(height: Space.sm),
              Row(
                children: [
                  Expanded(child: copy),
                  const SizedBox(width: Space.sm),
                  Expanded(child: share),
                ],
              ),
            ] else
              Row(
                children: [
                  Expanded(child: codeBox),
                  const SizedBox(width: Space.sm),
                  copy,
                  const SizedBox(width: Space.sm),
                  share,
                ],
              ),
            if (!expired)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    textStyle: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => _regenerate(context, ref),
                  child: const Text('New code'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Invite code copied')));
  }

  Future<void> _share(BuildContext context) {
    // iPads anchor the share sheet to a rect, so point it at this card.
    final box = context.findRenderObject() as RenderBox?;
    return SharePlus.instance.share(
      ShareParams(
        text: 'Join $flatName on Flatmates with code $code',
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  Future<void> _regenerate(
    BuildContext context,
    WidgetRef ref, {
    bool ask = true,
  }) async {
    if (ask) {
      final yes = await confirm(
        context,
        title: 'Make a new Invite code?',
        message: 'The current code stops working straight away.',
        confirmLabel: 'New code',
      );
      if (!yes || !context.mounted) return;
    }
    await runAction(
      context,
      ref.read(newInviteProvider.notifier).run,
    );
  }
}

/// The Flat-wide Away rule: the Admin picks, everyone else can read it.
class _AwayRuleCard extends ConsumerWidget {
  const _AwayRuleCard({required this.current, required this.canChange});

  final AwayRule current;
  final bool canChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fm = context.fm;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Space.sm, 14, Space.sm, Space.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Space.sm),
              child: Semantics(
                header: true,
                child: Text('Away rule', style: context.text.titleMedium),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Space.sm,
                2,
                Space.sm,
                Space.sm,
              ),
              child: Text(
                canChange
                    ? 'What happens to an Away Mate\'s Turns.'
                    : 'What happens to an Away Mate\'s Turns. Only the Admin can change it.',
                style: context.text.bodySmall,
              ),
            ),
            for (final rule in AwayRule.values)
              Semantics(
                inMutuallyExclusiveGroup: true,
                selected: rule == current,
                child: Material(
                  color: rule == current ? fm.primaryTint : Colors.transparent,
                  borderRadius: BorderRadius.circular(Radii.input),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Radii.input),
                    onTap:
                        canChange &&
                            rule != current &&
                            !ref.watch(setAwayRuleProvider).isLoading
                        ? () => runAction(
                            context,
                            () => ref
                                .read(setAwayRuleProvider.notifier)
                                .run(rule),
                            success: 'Away rule is now ${rule.label}',
                          )
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(Space.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rule.label,
                                  style: context.text.titleSmall?.copyWith(
                                    color: rule == current
                                        ? fm.onPrimaryTint
                                        : null,
                                  ),
                                ),
                                Text(
                                  rule.explanation,
                                  style: context.text.bodySmall?.copyWith(
                                    color: rule == current
                                        ? fm.onPrimaryTint
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (rule == current) ...[
                            const SizedBox(width: Space.sm),
                            AppIcon(
                              HugeIcons.strokeRoundedTick02,
                              color: fm.onPrimaryTint,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
