import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'light_bulb.dart';

/// The room the fridge stands in: a tiled wall, a wooden floor, and a
/// bulb hanging top right that switches dark mode. With the light [on]
/// the room is dark except where the bulb reaches.
///
/// [child] (the fridge) stands on the floor. On a phone it fills the
/// width; from [wideFrom] up it gets big margins and at most [maxWidth].
class Kitchen extends StatelessWidget {
  const Kitchen({
    super.key,
    required this.lightOn,
    required this.onLightTap,
    required this.child,
  });

  final bool lightOn;
  final VoidCallback onLightTap;
  final Widget child;

  static const wideFrom = 600.0;
  static const maxWidth = 960.0;
  static const floorHeight = 48.0;
  static const _cord = 28.0;

  @override
  Widget build(BuildContext context) {
    final f = context.fridge;
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= wideFrom;
        // The fridge's feet sit 16px into the floor. On a phone the bulb
        // hangs above the fridge; on wider screens it's in the margin.
        final padding = wide
            ? const EdgeInsets.symmetric(horizontal: 64, vertical: 32)
            : const EdgeInsets.fromLTRB(16, 88, 16, 32);
        final bulb = Offset(c.maxWidth - 32, _cord + 36);
        final light = Alignment(
          bulb.dx / c.maxWidth * 2 - 1,
          bulb.dy / c.maxHeight * 2 - 1,
        );
        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _RoomPainter(
                  colors: f,
                  floorHeight: floorHeight,
                  bulb: lightOn ? bulb : null,
                ),
              ),
            ),
            Padding(
              padding: padding,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: SizedBox.expand(child: child),
                ),
              ),
            ),
            if (lightOn)
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: light,
                        radius: 1.6,
                        colors: [
                          f.glow.withValues(alpha: 0.14),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                        ],
                        stops: const [0, 0.35, 1],
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 0,
              right: 8,
              child: LightBulb(
                on: lightOn,
                onTap: onLightTap,
                cordLength: _cord,
                glow: f.glow,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RoomPainter extends CustomPainter {
  _RoomPainter({
    required this.colors,
    required this.floorHeight,
    required this.bulb,
  });

  final FridgeColors colors;
  final double floorHeight;

  /// Where the lit bulb hangs, or null when it's off.
  final Offset? bulb;

  static const _tile = Size(48, 24);

  @override
  void paint(Canvas canvas, Size size) {
    final floorTop = size.height - floorHeight;
    final wall = Rect.fromLTWH(0, 0, size.width, floorTop);

    // Wall with subway tiles.
    canvas.drawRect(wall, Paint()..color = colors.wall);
    final grout = Paint()
      ..color = colors.tile
      ..strokeWidth = 1;
    for (var row = 0; row * _tile.height < floorTop; row++) {
      final y = row * _tile.height;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grout);
      final shift = row.isOdd ? _tile.width / 2 : 0.0;
      for (var x = shift; x < size.width; x += _tile.width) {
        canvas.drawLine(Offset(x, y), Offset(x, y + _tile.height), grout);
      }
    }

    // Warm light on the wall around the bulb.
    if (bulb != null) {
      canvas.drawCircle(
        bulb!,
        360,
        Paint()
          ..shader = RadialGradient(
            colors: [
              colors.glow.withValues(alpha: 0.35),
              colors.glow.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: bulb!, radius: 360)),
      );
    }

    // Skirting board.
    canvas.drawRect(
      Rect.fromLTWH(0, floorTop - 8, size.width, 8),
      Paint()..color = Color.lerp(colors.wall, Colors.black, 0.12)!,
    );

    // Wooden floor: planks with staggered joints, darker by the wall.
    final floor = Rect.fromLTWH(0, floorTop, size.width, floorHeight);
    canvas.drawRect(floor, Paint()..color = colors.floor);
    final seam = Paint()
      ..color = colors.plank
      ..strokeWidth = 1;
    for (var row = 0; row * 16 < floorHeight; row++) {
      final y = floorTop + row * 16;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), seam);
      for (var x = (row * 40) % 96 - 96.0; x < size.width; x += 96) {
        canvas.drawLine(Offset(x, y), Offset(x, y + 16), seam);
      }
    }
    canvas.drawRect(
      floor,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.2), Colors.transparent],
        ).createShader(floor),
    );
  }

  @override
  bool shouldRepaint(_RoomPainter old) =>
      old.colors != colors ||
      old.floorHeight != floorHeight ||
      old.bulb != bulb;
}
