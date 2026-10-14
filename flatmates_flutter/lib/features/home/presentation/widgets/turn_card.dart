import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/app_sheet.dart';

/// The hero card for the signed-in Mate's Turn today: ink in light mode,
/// lime in dark, with Mark Done in thumb reach.
class TurnCard extends StatelessWidget {
  const TurnCard({
    super.key,
    required this.chore,
    required this.endsAt,
    required this.nextLabel,
    required this.busy,
    required this.onDone,
  });

  final Chore chore;
  final DateTime endsAt;

  /// "Sam is next".
  final String nextLabel;
  final bool busy;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final now = DateTime.now();
    final left = endsAt.difference(now);
    final ends = left <= const Duration(hours: 3)
        ? '${Fmt.remaining(endsAt)} left'
        : DateUtils.isSameDay(endsAt.subtract(const Duration(minutes: 1)), now)
        ? 'Ends 23:59'
        : 'Ends ${Fmt.day(endsAt.subtract(const Duration(minutes: 1)))}';
    return _HeroShell(
      color: fm.heroCard,
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: Space.sm,
          runSpacing: Space.sm,
          children: [
            _Eyebrow('Your Turn today', color: fm.heroButton),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: fm.onHeroCard,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                ends,
                style: context.text.labelMedium?.copyWith(
                  color: fm.heroCard,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chore.name,
              style: context.text.displaySmall?.copyWith(color: fm.onHeroCard),
            ),
            const SizedBox(height: Space.xs),
            Text(
              '${everyLabel(chore.period)} · ${chore.turnTime.label} · '
              '$nextLabel',
              style: context.text.bodyMedium?.copyWith(
                fontSize: 14,
                color: fm.onHeroCard,
              ),
            ),
          ],
        ),
        PrimaryButton(
          label: 'Mark Done',
          icon: HugeIcons.strokeRoundedTick02,
          busy: busy,
          background: fm.heroButton,
          foreground: fm.onHeroButton,
          onPressed: onDone,
        ),
      ],
    );
  }
}

/// "Every day", "Every 3 days", "Every week".
String everyLabel(Duration period) => switch (period.inDays) {
  1 => 'Every day',
  7 => 'Every week',
  _ => 'Every ${Fmt.period(period)}',
};

class _HeroShell extends StatelessWidget {
  const _HeroShell({required this.color, required this.children});

  final Color color;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Radii.hero),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: 14),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// The small uppercase line at the top of a hero card.
class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.text.labelMedium?.copyWith(
        fontSize: 13,
        letterSpacing: 0.5,
        color: color,
      ),
    );
  }
}
