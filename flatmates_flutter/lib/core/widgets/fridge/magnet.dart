import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A small, glossy plastic fridge magnet, the kind that holds a [Note]
/// up. Its [shape] is painted at [size].
class Magnet extends StatelessWidget {
  const Magnet({
    super.key,
    required this.color,
    this.shape = const CircleBorder(),
    this.size = const Size.square(24),
    this.smiley = false,
  });

  /// A round magnet with a smiling face.
  const Magnet.smiley({super.key, required this.color})
    : shape = const CircleBorder(),
      size = const Size.square(28),
      smiley = true;

  final Color color;
  final ShapeBorder shape;
  final Size size;
  final bool smiley;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: size,
    painter: MagnetPainter(shape: shape, color: color, smiley: smiley),
  );
}

/// A carrot, point down: the groceries magnet.
class CarrotMagnet extends StatelessWidget {
  const CarrotMagnet({super.key});

  static const _leaf = Color(0xFF16A34A);
  static const _carrot = Color(0xFFF97316);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 40,
      child: Stack(
        children: [
          for (final angle in [-0.5, 0.0, 0.5])
            Positioned(
              left: 9,
              top: 0,
              child: Transform.rotate(
                angle: angle,
                alignment: Alignment.bottomCenter,
                child: const Magnet(
                  color: _leaf,
                  shape: StadiumBorder(),
                  size: Size(6, 14),
                ),
              ),
            ),
          const Positioned(
            top: 10,
            child: Magnet(
              color: _carrot,
              shape: CarrotBorder(),
              size: Size(24, 30),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a magnet's plastic body for any [shape]: a shadow on the door,
/// a few pixels of thickness, and a glossy, domed face.
class MagnetPainter extends CustomPainter {
  const MagnetPainter({
    required this.shape,
    required this.color,
    this.smiley = false,
  });

  final ShapeBorder shape;
  final Color color;

  /// Prints a smiling face on it, sized to fit a round magnet.
  final bool smiley;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final face = shape.getOuterPath(rect);
    canvas.drawPath(
      face.shift(const Offset(1, 4)),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    // The side of the plastic.
    canvas.drawPath(
      face.shift(const Offset(0, 2)),
      Paint()..color = Color.lerp(color, Colors.black, 0.45)!,
    );
    // The face, domed: lit from the top left.
    canvas.drawPath(
      face,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.5),
          radius: 0.95,
          colors: [
            Color.lerp(color, Colors.white, 0.45)!,
            color,
            Color.lerp(color, Colors.black, 0.15)!,
          ],
          stops: const [0, 0.5, 1],
        ).createShader(rect),
    );
    // A glint along the top edge.
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        face,
        face.shift(const Offset(0, 1.5)),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.5),
    );
    if (smiley) {
      final w = size.width;
      final print = Color.lerp(color, Colors.black, 0.7)!;
      for (final x in [0.36, 0.64]) {
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(w * x, size.height * 0.42),
            width: w * 0.12,
            height: w * 0.16,
          ),
          Paint()..color = print,
        );
      }
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(w / 2, size.height * 0.5),
          width: w * 0.48,
          height: w * 0.4,
        ),
        math.pi * 0.2,
        math.pi * 0.6,
        false,
        Paint()
          ..color = print
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * 0.08
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(MagnetPainter old) =>
      old.shape != shape || old.color != color || old.smiley != smiley;
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

/// A carrot: round shoulders tapering to a point at the bottom.
class CarrotBorder extends ShapeBorder {
  const CarrotBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final shoulder = rect.top + rect.width * 0.3;
    final tip = rect.bottomCenter;
    return Path()
      ..moveTo(rect.left, shoulder)
      ..quadraticBezierTo(rect.left, rect.top, rect.center.dx, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, shoulder)
      ..quadraticBezierTo(
        rect.right - rect.width * 0.15,
        rect.bottom - rect.height * 0.3,
        tip.dx,
        tip.dy,
      )
      ..quadraticBezierTo(
        rect.left + rect.width * 0.15,
        rect.bottom - rect.height * 0.3,
        rect.left,
        shoulder,
      )
      ..close();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
