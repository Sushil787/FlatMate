import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/mate_avatar.dart';

/// Before sign-in, once: three Mates, one sink, nobody's Turn. On the
/// sign-in screen's dark ground.
class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.onNext});

  final VoidCallback onNext;

  static const _ink = Color(0xFF16181A);

  // ponytail: initials for now; swap in the illustrated faces when they exist.
  static const _clash = [
    (name: 'Maya', says: 'Your Turn!', drop: 0.0),
    (name: 'Sam', says: 'No, yours.', drop: 28.0),
    (name: 'Priya', says: 'I did them Monday!', drop: 10.0),
  ];

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Semantics(
          label: 'Three Mates arguing over whose Turn the dishes are',
          excludeSemantics: true,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Space.sm,
            children: [
              for (final (i, m) in _clash.indexed)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: m.drop),
                    child: Column(
                      spacing: Space.sm,
                      children: [
                        _Bubble(m.says),
                        Avatar(name: m.name, colorIndex: i, size: 64),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: Space.xl),
        ExcludeSemantics(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final icon in [
                HugeIcons.strokeRoundedDish01,
                HugeIcons.strokeRoundedSink01,
                HugeIcons.strokeRoundedDish02,
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Space.sm),
                  child: AppIcon(icon, size: 40, color: Colors.white),
                ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          'The dishes.\nAgain.',
          style: text.displaySmall?.copyWith(
            fontSize: 48,
            height: 1,
            letterSpacing: -1,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: Space.xl),
        PrimaryButton(
          label: 'There\'s a better way',
          onPressed: onNext,
          background: FlatmatesColors.light.primary,
          foreground: _ink,
        ),
      ],
    );
  }
}

/// A white speech bubble, its tail corner at the bottom left.
class _Bubble extends StatelessWidget {
  const _Bubble(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Radii.input),
          topRight: Radius.circular(Radii.input),
          bottomRight: Radius.circular(Radii.input),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.text.titleSmall?.copyWith(color: StoryPage._ink),
      ),
    );
  }
}
