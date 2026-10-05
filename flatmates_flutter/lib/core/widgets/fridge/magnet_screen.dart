import 'package:flutter/material.dart';
import 'package:heroine/heroine.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';

/// The magnets on the fridge, each opening into its own screen. Doubles
/// as the hero tag that links a magnet to its screen.
enum FridgeSection {
  chores,
  calendar,
  notices,
  groceries,
  flat;

  Color colorIn(FridgeColors f) => switch (this) {
    chores => f.chores,
    calendar => f.calendar,
    notices => f.notices,
    groceries => f.groceries,
    flat => f.flat,
  };

  /// The magnet's outline, so the flight starts from the same shape.
  ShapeBorder get shape => switch (this) {
    notices => const BubbleBorder(),
    flat => const CircleBorder(),
    _ => Magnet.defaultShape,
  };
}

/// A screen that its [section]'s magnet grows into when tapped, and
/// shrinks back into on the way out.
class MagnetScreen extends StatelessWidget {
  const MagnetScreen({super.key, required this.section, required this.child});

  final FridgeSection section;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Heroine(
      tag: section,
      motion: Magnet.morph,
      flightShuttleBuilder: _MagnetToScreen(
        color: section.colorIn(context.fridge),
        shape: section.shape,
      ),
      child: child,
    );
  }
}

/// The magnet's plastic stretches to fill the screen, losing its corners;
/// its print fades out and the screen fades in on it. Both are laid out at
/// their own size and scaled to the flight, so neither has to squeeze.
class _MagnetToScreen extends HeroineShuttleBuilder {
  const _MagnetToScreen({required this.color, required this.shape});

  final Color color;
  final ShapeBorder shape;

  @override
  List<Object?> get props => [color, shape];

  @override
  Widget call(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final push = flightDirection == HeroFlightDirection.push;
    final screen =
        ((push ? toHeroContext : fromHeroContext).widget as Heroine).child;
    final magnetHero = push ? fromHeroContext : toHeroContext;
    final magnet = (magnetHero.widget as Heroine).child;
    final magnetWidth =
        (magnetHero.findRenderObject()! as RenderBox).size.width;
    final full = MediaQuery.sizeOf(flightContext);
    const fadeOut = Interval(0, 0.3);
    const fadeIn = Interval(0.35, 1);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // The route's animation: 0 on the fridge, 1 on the screen, both ways.
        final t = animation.value;
        final now = ShapeBorder.lerp(shape, const RoundedRectangleBorder(), t)!;
        return CustomPaint(
          painter: MagnetPainter(shape: now, color: color, lift: 1 - t),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: now),
            // The flight's overlay has no Material for the print's text.
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // The magnet's print, stretching and fading as it grows.
                  Opacity(
                    opacity: 1 - fadeOut.transform(t),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      // Only the width: its content may have changed since it was
                      // last laid out (a new notice, say).
                      child: SizedBox(width: magnetWidth, child: magnet),
                    ),
                  ),
                  Opacity(
                    opacity: fadeIn.transform(t),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox.fromSize(size: full, child: screen),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
