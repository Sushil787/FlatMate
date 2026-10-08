import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import 'app_icon.dart';

enum TagTone { due, done, missed, away, quiet, fresh, plain, ink }

/// A small rounded label: Turn status ("Due today", "Done", "Missed",
/// "Away"), a day, "New", "Pinned". Status never relies on colour alone.
class Tag extends StatelessWidget {
  const Tag(this.label, {super.key, this.tone = TagTone.quiet, this.icon});

  const Tag.due(this.label, {super.key})
    : tone = TagTone.due,
      icon = HugeIcons.strokeRoundedClock01;

  const Tag.done(this.label, {super.key})
    : tone = TagTone.done,
      icon = HugeIcons.strokeRoundedTick02;

  const Tag.missed(this.label, {super.key})
    : tone = TagTone.missed,
      icon = HugeIcons.strokeRoundedMinusSign;

  const Tag.away(this.label, {super.key})
    : tone = TagTone.away,
      icon = HugeIcons.strokeRoundedAirplane01;

  final String label;
  final TagTone tone;
  final AppIconData? icon;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final (bg, fg) = switch (tone) {
      TagTone.due => (fm.primaryTint, fm.onPrimaryTint),
      TagTone.done => (fm.doneBg, fm.doneFg),
      TagTone.missed => (fm.missedBg, fm.missedFg),
      TagTone.away => (fm.awayBg, fm.awayFg),
      TagTone.quiet => (fm.fillQuiet, fm.inkSoft),
      TagTone.fresh => (fm.primary, fm.onPrimary),
      TagTone.plain => (fm.surface, fm.ink),
      TagTone.ink => (fm.ink, fm.surface),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon case final icon?) ...[
            AppIcon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              label,
              style: context.text.labelMedium?.copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
