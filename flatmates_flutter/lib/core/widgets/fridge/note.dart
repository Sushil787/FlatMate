import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:heroine/heroine.dart';
import 'package:motor/motor.dart';

import '../../theme/app_theme.dart';
import 'magnet_screen.dart';

/// Ink on a [Note]'s paper. Sizes stay on the 4px grid.
abstract final class NoteText {
  static const ink = Color(0xFF1E2235);
  static const faded = Color(0xFF6B6F80);

  static const title = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 20,
    height: 1.2,
    letterSpacing: -0.4,
    color: ink,
  );

  static const body = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.25,
    color: ink,
  );

  static const small = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.33,
    color: faded,
  );

  static const eyebrow = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 1.2,
    color: faded,
  );
}

/// A piece of paper stuck on the fridge by its [pins], written on with
/// [child]. Its [section] decides the paper and is the hero tag shared
/// with the screen it opens into. It lifts off the door while pressed.
class Note extends StatefulWidget {
  const Note({
    super.key,
    required this.section,
    required this.pins,
    required this.child,
    this.ruledFrom,
    this.tilt = 0,
    this.padding = const EdgeInsets.fromLTRB(16, 24, 16, 16),
    this.onTap,
  });

  /// The spring a note morphs into its screen (and back) with.
  static const morph = CupertinoMotion.snappy();

  final FridgeSection section;

  /// The magnets holding it up: where along the top edge (0 to 1), and
  /// the magnet. Each sits half over the edge.
  final List<(double, Widget)> pins;

  /// Draws notebook rules from this far down, one per line of
  /// [NoteText.body].
  final double? ruledFrom;

  /// Rotation in degrees; nothing is stuck on perfectly straight.
  final double tilt;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Widget child;

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  var _lifted = false;

  void _lift(bool v) {
    if (widget.onTap != null && v != _lifted) setState(() => _lifted = v);
  }

  @override
  Widget build(BuildContext context) {
    final section = widget.section;
    final shape = PaperBorder(section.edge);
    final paper = ClipPath(
      clipper: ShapeBorderClipper(shape: shape),
      child: Padding(
        padding: widget.padding,
        child: DefaultTextStyle.merge(
          style: NoteText.body,
          child: IconTheme.merge(
            data: const IconThemeData(color: NoteText.ink, size: 20),
            child: widget.child,
          ),
        ),
      ),
    );
    return Transform.rotate(
      angle: widget.tilt * math.pi / 180,
      child: Semantics(
        button: widget.onTap != null,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => _lift(true),
          onTapUp: (_) => _lift(false),
          onTapCancel: () => _lift(false),
          // No shuttle here: the screen it opens into flies both ways.
          child: Heroine(
            tag: section,
            motion: Note.morph,
            child: SingleMotionBuilder(
              motion: const CupertinoMotion.snappy(),
              value: _lifted ? 1 : 0,
              builder: (context, lift, child) => Transform.scale(
                scale: 1 + 0.03 * lift,
                child: CustomPaint(
                  painter: PaperPainter(
                    shape: shape,
                    color: section.paper,
                    ruledFrom: widget.ruledFrom,
                    lift: lift,
                  ),
                  child: child,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  paper,
                  for (final (x, magnet) in widget.pins)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment(x * 2 - 1, -1),
                        child: FractionalTranslation(
                          translation: const Offset(0, -0.4),
                          child: magnet,
                        ),
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

/// How a [Note]'s top edge was made.
enum PaperEdge {
  /// Cut straight: a card or a photo.
  cut,

  /// Torn off a pad.
  torn,

  /// Torn out of a spiral binder: a row of holes, each split open to the
  /// edge.
  punched,
}

/// A sheet of paper with an [edge] along the top.
class PaperBorder extends ShapeBorder {
  const PaperBorder(this.edge);

  final PaperEdge edge;

  static const _holeGap = 14.0;
  static const _holeRadius = 3.5;

  /// Depths of the torn edge's jags, repeated along it.
  static const _jags = [0.0, 3, 1, 4, 2, 0, 3, 1.5, 4, 0.5, 2.5];

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final sheet = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3)));
    switch (edge) {
      case PaperEdge.cut:
        return sheet;
      case PaperEdge.punched:
        final count = (rect.width / _holeGap).floor();
        final first = rect.center.dx - (count - 1) * _holeGap / 2;
        final holes = Path();
        for (var i = 0; i < count; i++) {
          final x = first + i * _holeGap;
          holes
            ..addOval(
              Rect.fromCircle(
                center: Offset(x, rect.top + 7),
                radius: _holeRadius,
              ),
            )
            // Where the paper tore through to the edge.
            ..addRect(Rect.fromLTWH(x - 1, rect.top - 1, 2, 7));
        }
        return Path.combine(PathOperation.difference, sheet, holes);
      case PaperEdge.torn:
        final path = Path()..moveTo(rect.left, rect.top + _jags[0]);
        var i = 0;
        for (var x = rect.left; x < rect.right; x += 5) {
          path.lineTo(x, rect.top + _jags[i++ % _jags.length]);
        }
        return path
          ..lineTo(rect.right, rect.top + 2)
          ..lineTo(rect.right, rect.bottom)
          ..lineTo(rect.left, rect.bottom)
          ..close();
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  bool operator ==(Object other) => other is PaperBorder && other.edge == edge;

  @override
  int get hashCode => edge.hashCode;
}

/// Paints a sheet of paper lying on the door: its shadow, a faint fall of
/// light down the sheet, and notebook rules from [ruledFrom].
class PaperPainter extends CustomPainter {
  const PaperPainter({
    required this.shape,
    required this.color,
    this.ruledFrom,
    this.lift = 0,
  });

  final ShapeBorder shape;
  final Color color;
  final double? ruledFrom;

  /// How far it's lifted off the door, 0 (stuck on) to 1 (held).
  final double lift;

  /// Line height of [NoteText.body].
  static const ruleGap = 20.0;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final sheet = shape.getOuterPath(rect);
    canvas.drawPath(
      sheet.shift(Offset(1, 3 + 5 * lift)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.28 - 0.08 * lift)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3 + 5 * lift),
    );
    canvas.drawPath(
      sheet,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(color, Colors.white, 0.5)!,
            color,
            Color.lerp(color, Colors.black, 0.07)!,
          ],
          stops: const [0, 0.5, 1],
        ).createShader(rect),
    );
    final from = ruledFrom;
    if (from == null) return;
    canvas.save();
    canvas.clipPath(sheet);
    final rule = Paint()
      ..color = const Color(0x332563EB)
      ..strokeWidth = 1;
    for (var y = from; y < size.height; y += ruleGap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), rule);
    }
    canvas.drawLine(
      const Offset(20, 0),
      Offset(20, size.height),
      Paint()
        ..color = const Color(0x4DDC2626)
        ..strokeWidth = 1,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(PaperPainter old) =>
      old.shape != shape ||
      old.color != color ||
      old.ruledFrom != ruledFrom ||
      old.lift != lift;
}
