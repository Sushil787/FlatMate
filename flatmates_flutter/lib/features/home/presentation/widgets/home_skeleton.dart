import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Home's shape in grey, gently pulsing, while the Flat's data loads.
class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({super.key});

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    lowerBound: 0.55,
    value: 1,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    Widget bar(double width, double height, Color color, {double? radius}) =>
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius ?? height / 2),
          ),
        );
    Widget circle(double size, Color color, {double? radius}) =>
        bar(size, size, color, radius: radius);
    Widget card(EdgeInsets padding, Widget child) => Container(
      padding: padding,
      decoration: BoxDecoration(
        color: fm.surface,
        borderRadius: BorderRadius.circular(Radii.card),
      ),
      child: child,
    );
    Widget row(double avatar, List<double> lines, {double? chip, double? r}) =>
        Row(
          children: [
            circle(avatar, fm.fillQuiet, radius: r),
            const SizedBox(width: Space.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bar(lines[0], 14, fm.fillQuiet),
                  const SizedBox(height: 6),
                  bar(lines[1], 12, fm.fillQuiet),
                ],
              ),
            ),
            if (chip != null) bar(chip, 24, fm.fillQuiet),
          ],
        );

    return Semantics(
      label: 'Loading your Flat',
      child: ExcludeSemantics(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              Space.screenMargin,
              Space.lg,
              Space.screenMargin,
              Space.navClearance,
            ),
            child: FadeTransition(
              opacity: _pulse,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bar(140, 14, fm.line),
                            const SizedBox(height: Space.sm),
                            bar(110, 30, fm.line, radius: 10),
                          ],
                        ),
                      ),
                      circle(44, fm.line),
                    ],
                  ),
                  const SizedBox(height: Space.lg),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: fm.line,
                      borderRadius: BorderRadius.circular(Radii.hero),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bar(120, 14, fm.switchOff),
                        const SizedBox(height: 14),
                        bar(220, 32, fm.switchOff, radius: 10),
                        const SizedBox(height: 14),
                        bar(160, 14, fm.switchOff),
                        const SizedBox(height: 14),
                        bar(double.infinity, Sizes.buttonHero, fm.switchOff),
                      ],
                    ),
                  ),
                  const SizedBox(height: Space.lg),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: bar(150, 18, fm.line),
                  ),
                  const SizedBox(height: Space.lg),
                  card(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    Column(
                      children: [
                        row(36, [130, 90], chip: 56),
                        const SizedBox(height: 14),
                        row(36, [110, 100], chip: 44),
                      ],
                    ),
                  ),
                  const SizedBox(height: Space.lg),
                  card(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    row(36, [160, 220]),
                  ),
                  const SizedBox(height: Space.lg),
                  card(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    row(44, [150, 190], r: 14),
                  ),
                  const SizedBox(height: Space.lg),
                  Text(
                    'Catching up with your Flat…',
                    textAlign: TextAlign.center,
                    style: context.text.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
