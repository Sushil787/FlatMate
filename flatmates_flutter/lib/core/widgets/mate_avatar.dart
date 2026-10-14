import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/flat/application/mate_directory.dart';
import '../theme/app_theme.dart';

/// A coloured circle with an initial. Away draws a dashed outline instead
/// of a fill; [turn] adds a lime ring for whose Turn it is.
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.colorIndex,
    this.size = Sizes.avatarMd,
    this.away = false,
    this.turn = false,
  });

  final String name;

  /// Index into [mateColors].
  final int colorIndex;
  final double size;
  final bool away;
  final bool turn;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final color = mateColors[colorIndex % mateColors.length];
    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();
    final label = Text(
      initial,
      style: TextStyle(
        fontFamily: FlatmatesTheme.bodyFont,
        fontWeight: FontWeight.w700,
        fontSize: (size * 0.39).roundToDouble(),
        height: 1,
        color: away ? fm.awayFg : color.onFill,
      ),
    );
    Widget circle = SizedBox.square(
      dimension: size,
      child: away
          ? CustomPaint(
              painter: _DashedCircle(fm.awayFg),
              child: Center(child: label),
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.fill,
              ),
              child: Center(child: label),
            ),
    );
    if (turn) {
      // 3px lime ring, 2px off the avatar.
      circle = Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: fm.primary, width: 3),
        ),
        child: circle,
      );
    }
    return Semantics(label: name, excludeSemantics: true, child: circle);
  }
}

class _DashedCircle extends CustomPainter {
  _DashedCircle(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 2.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    const dashes = 12;
    const sweep = 2 * 3.141592653589793 / dashes;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, i * sweep, sweep * 0.6, false, paint);
    }
  }

  @override
  bool shouldRepaint(_DashedCircle old) => old.color != color;
}

/// A Mate of the current Flat, by id: their name and colour come from the
/// [MateDirectory].
class MateAvatar extends ConsumerWidget {
  const MateAvatar(
    this.mateId, {
    super.key,
    this.size = Sizes.avatarMd,
    this.away = false,
    this.turn = false,
  });

  final UuidValue? mateId;
  final double size;
  final bool away;
  final bool turn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    return Avatar(
      name: directory.realNameOf(mateId),
      colorIndex: directory.colorIndexOf(mateId),
      size: size,
      away: away,
      turn: turn,
    );
  }
}

/// Small overlapping avatars, e.g. the Mates who said Got it.
class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key, required this.mateIds, this.size = 24});

  final List<UuidValue> mateIds;
  final double size;

  @override
  Widget build(BuildContext context) {
    final step = size * 0.67;
    return SizedBox(
      height: size,
      width: mateIds.isEmpty ? 0 : step * (mateIds.length - 1) + size,
      child: Stack(
        children: [
          for (var i = 0; i < mateIds.length; i++)
            Positioned(
              left: i * step,
              child: MateAvatar(mateIds[i], size: size),
            ),
        ],
      ),
    );
  }
}
