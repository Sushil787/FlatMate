import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:heroine/heroine.dart';
import 'package:motor/motor.dart';

import '../../theme/app_theme.dart';

/// Text printed straight on a magnet's plastic. Sizes stay on the 4px grid.
abstract final class MagnetText {
  static const title = TextStyle(
    fontFamily: AppTheme.magnetFont,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.2,
    letterSpacing: 0.2,
    color: Colors.white,
  );

  static const body = TextStyle(
    fontFamily: AppTheme.magnetFont,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.25,
    color: Colors.white,
  );

  static const small = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.33,
    color: Color(0xD9FFFFFF),
  );

  static const eyebrow = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 1.2,
    color: Color(0xBFFFFFFF),
  );
}

/// A chunky plastic fridge magnet: a coloured [shape] with a glossy top
/// edge, a shaded bottom edge and 4px of thickness underneath. It lifts
/// off the door while pressed.
class Magnet extends StatefulWidget {
  const Magnet({
    super.key,
    required this.color,
    required this.child,
    this.shape = defaultShape,
    this.tilt = 0,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 16),
    this.onTap,
    this.heroTag,
  });

  static const defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  /// The spring a magnet morphs into its screen (and back) with.
  static const morph = CupertinoMotion.snappy();

  final Color color;
  final ShapeBorder shape;

  /// Rotation in degrees; magnets are never stuck on perfectly straight.
  final double tilt;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  /// Shared with the [MagnetScreen] this magnet opens into.
  final Object? heroTag;
  final Widget child;

  @override
  State<Magnet> createState() => _MagnetState();
}

class _MagnetState extends State<Magnet> {
  var _lifted = false;

  void _lift(bool v) {
    if (widget.onTap != null && v != _lifted) setState(() => _lifted = v);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = SingleMotionBuilder(
      motion: const CupertinoMotion.snappy(),
      value: _lifted ? 1 : 0,
      builder: (context, lift, child) => Transform.scale(
        scale: 1 + 0.04 * lift,
        child: CustomPaint(
          painter: MagnetPainter(
            shape: widget.shape,
            color: widget.color,
            lift: lift,
          ),
          child: child,
        ),
      ),
      child: Padding(
        padding: widget.padding,
        child: DefaultTextStyle.merge(
          style: MagnetText.body,
          child: IconTheme.merge(
            data: const IconThemeData(color: Colors.white, size: 20),
            child: widget.child,
          ),
        ),
      ),
    );
    if (widget.heroTag != null) {
      // No shuttle here: the screen it opens into flies both ways.
      body = Heroine(tag: widget.heroTag!, motion: Magnet.morph, child: body);
    }
    return Transform.rotate(
      angle: widget.tilt * math.pi / 180,
      child: Semantics(
        button: widget.onTap != null,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) => _lift(true),
          onTapUp: (_) => _lift(false),
          onTapCancel: () => _lift(false),
          child: body,
        ),
      ),
    );
  }
}

/// Paints the magnet's plastic body for any [shape].
class MagnetPainter extends CustomPainter {
  const MagnetPainter({
    required this.shape,
    required this.color,
    this.lift = 0,
  });

  final ShapeBorder shape;
  final Color color;

  /// How far it's lifted off the door, 0 (stuck on) to 1 (held).
  final double lift;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final face = shape.getOuterPath(rect);
    // Drop shadow on the door, further away while lifted.
    canvas.drawPath(
      face.shift(Offset(0, 8 + 4 * lift)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.3 - 0.08 * lift)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 + 4 * lift),
    );
    // The side of the plastic.
    canvas.drawPath(
      face.shift(const Offset(0, 4)),
      Paint()..color = Color.lerp(color, Colors.black, 0.45)!,
    );
    // The face, a touch lighter at the top.
    canvas.drawPath(
      face,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.lerp(color, Colors.white, 0.1)!, color],
        ).createShader(rect),
    );
    // Gloss along the top edge, shade along the bottom edge.
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        face,
        face.shift(const Offset(0, 4)),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.28),
    );
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        face,
        face.shift(const Offset(0, -4)),
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.22),
    );
  }

  @override
  bool shouldRepaint(MagnetPainter old) =>
      old.shape != shape || old.color != color || old.lift != lift;
}

/// A speech bubble with a small tail at the bottom left, for notices.
/// The tail hangs [tail] below the box, so leave room for it.
class BubbleBorder extends ShapeBorder {
  const BubbleBorder({
    this.radius = 24,
    this.tailCorner = 8,
    this.tail = const Size(12, 12),
    this.tailInset = 16,
  });

  final double radius;
  final double tailCorner;
  final Size tail;
  final double tailInset;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = Radius.circular(radius);
    final body = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: r,
          topRight: r,
          bottomRight: r,
          bottomLeft: Radius.circular(tailCorner),
        ),
      );
    final x = rect.left + tailInset;
    final tip = Path()
      ..moveTo(x, rect.bottom - 4)
      ..lineTo(x + tail.width, rect.bottom - 4)
      ..lineTo(x, rect.bottom + tail.height)
      ..close();
    return Path.combine(PathOperation.union, body, tip);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
