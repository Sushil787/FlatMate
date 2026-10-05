import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:motor/motor.dart';

/// A bulb hanging on a cord: the dark-mode switch. It glows while [on]
/// and swings a little when tapped.
class LightBulb extends StatefulWidget {
  const LightBulb({
    super.key,
    required this.on,
    required this.onTap,
    this.cordLength = 28,
    this.glow = const Color(0xFFFFC861),
  });

  final bool on;
  final VoidCallback onTap;
  final double cordLength;
  final Color glow;

  /// Width, and height below the cord.
  static const width = 48.0;
  static const bulbHeight = 52.0;

  @override
  State<LightBulb> createState() => _LightBulbState();
}

class _LightBulbState extends State<LightBulb>
    with SingleTickerProviderStateMixin {
  /// The bulb's angle on its cord, in radians. A tap gives it a push and
  /// the spring swings it back and forth until it settles.
  late final _swing = SingleMotionController(
    motion: const CupertinoMotion(
      duration: Duration(milliseconds: 1200),
      bounce: 0.6,
    ),
    vsync: this,
  );

  /// Which way the next push goes; it alternates.
  var _push = 1.2;

  @override
  void dispose() {
    _swing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Dark mode',
      toggled: widget.on,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _swing.animateTo(0, withVelocity: _push);
          _push = -_push;
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _swing,
          builder: (context, _) {
            return Transform.rotate(
              alignment: Alignment.topCenter,
              angle: _swing.value,
              child: CustomPaint(
                size: Size(
                  LightBulb.width,
                  widget.cordLength + LightBulb.bulbHeight,
                ),
                painter: _BulbPainter(
                  on: widget.on,
                  cord: widget.cordLength,
                  glow: widget.glow,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BulbPainter extends CustomPainter {
  _BulbPainter({required this.on, required this.cord, required this.glow});

  final bool on;
  final double cord;
  final Color glow;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final center = Offset(cx, cord + 36);

    // Cord and socket.
    canvas.drawLine(
      Offset(cx, 0),
      Offset(cx, cord),
      Paint()
        ..color = const Color(0xFF6B6B6B)
        ..strokeWidth = 2,
    );
    final socket = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - 8, cord, 16, 12),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      socket,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF3A3A3A), Color(0xFF8A8A8A), Color(0xFF3A3A3A)],
        ).createShader(socket.outerRect),
    );

    // Glow around the glass.
    if (on) {
      canvas.drawCircle(
        center,
        44,
        Paint()
          ..color = glow.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24),
      );
      canvas.drawCircle(
        center,
        24,
        Paint()
          ..color = glow.withValues(alpha: 0.7)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
      );
    }

    // The glass: a round bulb with a neck up to the socket.
    final glass = Path.combine(
      PathOperation.union,
      Path()..addOval(Rect.fromCircle(center: center, radius: 16)),
      Path()..addRect(Rect.fromLTWH(cx - 6, cord + 12, 12, 12)),
    );
    final bounds = Rect.fromCircle(center: center, radius: 16);
    canvas.drawPath(
      glass,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.2, -0.3),
          colors: on
              ? [const Color(0xFFFFFDF2), const Color(0xFFFFEBB0), glow]
              : [
                  Colors.white.withValues(alpha: 0.7),
                  const Color(0xFFDDE3E6).withValues(alpha: 0.55),
                  const Color(0xFFB8C2C7).withValues(alpha: 0.5),
                ],
        ).createShader(bounds),
    );
    if (!on) {
      canvas.drawPath(
        glass,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = const Color(0xFF8A969C),
      );
    }

    // Filament.
    final filament = Path()
      ..moveTo(cx - 4, cord + 20)
      ..lineTo(cx - 4, center.dy)
      ..lineTo(cx - 2, center.dy - 4)
      ..lineTo(cx, center.dy)
      ..lineTo(cx + 2, center.dy - 4)
      ..lineTo(cx + 4, center.dy)
      ..lineTo(cx + 4, cord + 20);
    canvas.drawPath(
      filament,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = on ? 2 : 1
        ..strokeJoin = StrokeJoin.round
        ..color = on ? const Color(0xFFFF8A00) : const Color(0xFF6B7478),
    );

    // A highlight on the glass.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: 12),
      math.pi * 1.05,
      math.pi * 0.4,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = Colors.white.withValues(alpha: 0.8),
    );
  }

  @override
  bool shouldRepaint(_BulbPainter old) =>
      old.on != on || old.cord != cord || old.glow != glow;
}
