import 'package:flutter/material.dart';
import 'package:heroine/heroine.dart';

import 'note.dart';

/// The notes on the fridge, each opening into its own screen. Doubles
/// as the hero tag that links a note to its screen.
enum FridgeSection {
  chores(Color(0xFFFDFDFB), PaperEdge.cut),
  calendar(Color(0xFFFAF7F0), PaperEdge.punched),
  notices(Color(0xFFFBF6EA), PaperEdge.punched),
  groceries(Color(0xFFFCEFA8), PaperEdge.torn),
  flat(Color(0xFFFDFDFB), PaperEdge.cut);

  const FridgeSection(this.paper, this.edge);

  /// The colour of the paper the section's note is written on.
  final Color paper;
  final PaperEdge edge;
}

/// A screen that its [section]'s note grows into when tapped, and
/// shrinks back into on the way out.
class MagnetScreen extends StatelessWidget {
  const MagnetScreen({super.key, required this.section, required this.child});

  final FridgeSection section;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Heroine(
      tag: section,
      motion: Note.morph,
      flightShuttleBuilder: _NoteToScreen(
        paper: section.paper,
        shape: PaperBorder(section.edge),
        background: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: child,
    );
  }
}

/// The note's paper stretches to fill the screen, squaring off and taking
/// on the screen's colour; its writing fades out and the screen fades in
/// on it. Both are laid out at their own size and scaled to the flight, so
/// neither has to squeeze.
class _NoteToScreen extends HeroineShuttleBuilder {
  const _NoteToScreen({
    required this.paper,
    required this.shape,
    required this.background,
  });

  final Color paper;
  final ShapeBorder shape;
  final Color background;

  @override
  List<Object?> get props => [paper, shape, background];

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
    final noteHero = push ? fromHeroContext : toHeroContext;
    final note = (noteHero.widget as Heroine).child;
    final noteWidth = (noteHero.findRenderObject()! as RenderBox).size.width;
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
          painter: PaperPainter(
            shape: now,
            color: Color.lerp(paper, background, t)!,
            lift: 1 - t,
          ),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: now),
            // The flight's overlay has no Material for the print's text.
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // The note's writing, stretching and fading as it grows.
                  Opacity(
                    opacity: 1 - fadeOut.transform(t),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      // Only the width: its content may have changed since it was
                      // last laid out (a new notice, say).
                      child: SizedBox(width: noteWidth, child: note),
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
