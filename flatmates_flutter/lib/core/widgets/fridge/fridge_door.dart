import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';

enum HandleSide { left, right }

/// One brushed-steel door: bevelled edges, a sheen, and a raised handle
/// on [handleSide]. [child] fills the rest of the door and is clipped to it.
class FridgeDoor extends StatelessWidget {
  const FridgeDoor({
    super.key,
    required this.child,
    this.handleSide = HandleSide.left,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    this.color,
    this.highlight,
    this.shade,
    this.handleColor,
  });

  final Widget child;
  final HandleSide handleSide;
  final BorderRadius borderRadius;
  final Color? color;
  final Color? highlight;
  final Color? shade;
  final Color? handleColor;

  /// Width kept clear for the handle.
  static const handleZone = 32.0;

  @override
  Widget build(BuildContext context) {
    final f = context.fridge;
    final hi = highlight ?? f.doorHighlight;
    final left = handleSide == HandleSide.left;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _DoorPainter(
          radius: borderRadius,
          door: color ?? f.door,
          highlight: hi,
          shade: shade ?? f.doorShade,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              Positioned.fill(
                left: left ? handleZone : 0,
                right: left ? 0 : handleZone,
                child: child,
              ),
              Positioned(
                left: left ? 8 : null,
                right: left ? null : 8,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: const Alignment(0, -0.2),
                  child: FractionallySizedBox(
                    heightFactor: 0.4,
                    child: _Handle(
                      color: handleColor ?? f.handle,
                      highlight: hi,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoorPainter extends CustomPainter {
  _DoorPainter({
    required this.radius,
    required this.door,
    required this.highlight,
    required this.shade,
  });

  final BorderRadius radius;
  final Color door;
  final Color highlight;
  final Color shade;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = radius.toRRect(rect);
    final dark = door.computeLuminance() < 0.2;

    // Brushed steel, lit from the top left.
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          begin: const Alignment(-1, -0.3),
          end: const Alignment(1, 0.3),
          colors: [highlight, door, highlight, door, shade],
          stops: const [0, 0.35, 0.6, 0.85, 1],
        ).createShader(rect),
    );
    canvas.save();
    canvas.clipRRect(rrect);
    // Grain of the brushing.
    final grain = math.Random(7);
    final line = Paint()..strokeWidth = 1;
    for (var i = 0; i < size.width / 3; i++) {
      final x = grain.nextDouble() * size.width;
      line.color = (grain.nextBool() ? Colors.white : Colors.black).withValues(
        alpha: grain.nextDouble() * 0.05,
      );
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    // A diagonal sheen.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: dark ? 0.08 : 0.4),
            Colors.white.withValues(alpha: 0),
          ],
          stops: const [0.22, 0.3, 0.42],
        ).createShader(rect),
    );
    // Darker towards the floor.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.1)],
          stops: const [0.55, 1],
        ).createShader(rect),
    );
    canvas.restore();
    // Bevel: a bright rim top-left, a dark rim bottom-right.
    canvas.drawRRect(
      rrect.deflate(2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: dark ? 0.18 : 0.85),
            Colors.white.withValues(alpha: 0),
            Colors.black.withValues(alpha: dark ? 0.4 : 0.16),
          ],
          stops: const [0, 0.5, 1],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_DoorPainter old) =>
      old.radius != radius ||
      old.door != door ||
      old.highlight != highlight ||
      old.shade != shade;
}

/// A bar handle standing off the door, casting a shadow onto it.
class _Handle extends StatelessWidget {
  const _Handle({required this.color, required this.highlight});

  final Color color;
  final Color highlight;

  @override
  Widget build(BuildContext context) {
    final dark = Color.lerp(color, Colors.black, 0.35)!;
    Widget mount() => Container(
      width: 16,
      height: 12,
      decoration: BoxDecoration(
        color: dark,
        borderRadius: BorderRadius.circular(4),
      ),
    );
    return SizedBox(
      width: 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 0, child: mount()),
          Positioned(bottom: 0, child: mount()),
          Positioned(
            top: 4,
            bottom: 4,
            child: Container(
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [dark, highlight, color, dark],
                  stops: const [0, 0.35, 0.7, 1],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(4, 8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A whole fridge standing on its feet: the body, one or two [doors] (each
/// a door's content), and the vent grille at the bottom.
class Fridge extends StatelessWidget {
  const Fridge({super.key, required this.doors})
    : assert(doors.length == 1 || doors.length == 2);

  final List<Widget> doors;

  @override
  Widget build(BuildContext context) {
    final f = context.fridge;
    const outer = Radius.circular(32);
    const inner = Radius.circular(8);
    Widget door(int i) {
      if (doors.length == 1) return FridgeDoor(child: doors[0]);
      // French doors: the handles meet in the middle.
      final left = i == 0;
      return FridgeDoor(
        handleSide: left ? HandleSide.right : HandleSide.left,
        borderRadius: left
            ? const BorderRadius.horizontal(left: outer, right: inner)
            : const BorderRadius.horizontal(left: inner, right: outer),
        child: doors[i],
      );
    }

    final foot = Container(
      width: 32,
      height: 8,
      decoration: BoxDecoration(
        color: Color.lerp(f.plinth, Colors.black, 0.4),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
    );
    final slot = Container(
      height: 4,
      decoration: BoxDecoration(
        color: Color.lerp(f.plinth, Colors.black, 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
    );
    return Column(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: f.cabinet,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 48,
                  offset: const Offset(0, 24),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4,
                children: [
                  for (var i = 0; i < doors.length; i++)
                    Expanded(child: door(i)),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 28,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          decoration: BoxDecoration(
            color: f.plinth,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(spacing: 4, children: [slot, slot, slot]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [foot, foot],
          ),
        ),
      ],
    );
  }
}

/// The home screen's magnets on the fridge: one door on a phone, French
/// doors from [twoDoorsFrom] wide.
class FridgeHome extends StatelessWidget {
  const FridgeHome({
    super.key,
    required this.notices,
    required this.chores,
    required this.calendar,
    required this.flat,
    required this.groceries,
  });

  final Widget notices;
  final Widget chores;
  final Widget calendar;
  final Widget flat;
  final Widget groceries;

  static const twoDoorsFrom = 640.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= twoDoorsFrom) {
          return Fridge(
            doors: [
              _door([
                _row([notices, chores], [1, 1]),
                _part(0.5, flat),
              ]),
              _door([
                _part(0.92, calendar),
                _part(0.64, groceries, end: true),
              ]),
            ],
          );
        }
        return Fridge(
          doors: [
            _door([
              _row([notices, chores], [100, 115]),
              _part(0.84, calendar),
              _row([flat, groceries], [100, 115]),
            ]),
          ],
        );
      },
    );
  }

  /// A door's magnets, spread down the door; scrolls if they don't fit.
  static Widget _door(List<Widget> rows) => LayoutBuilder(
    builder: (context, c) => SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: c.maxHeight - 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 24,
          children: rows,
        ),
      ),
    ),
  );

  static Widget _part(double width, Widget child, {bool end = false}) =>
      FractionallySizedBox(
        widthFactor: width,
        alignment: end
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: child,
      );

  static Widget _row(List<Widget> cells, List<int> flex) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 16,
    children: [
      for (var i = 0; i < cells.length; i++)
        Expanded(flex: flex[i], child: cells[i]),
    ],
  );
}
