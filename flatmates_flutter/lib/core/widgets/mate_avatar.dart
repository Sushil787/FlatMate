import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../features/flat/application/mate_directory.dart';
import '../theme/app_theme.dart';

/// A Mate's face on their colour, in a circle. Away swaps the colour for
/// the Away tint with a dashed outline; [turn] adds a lime ring for whose
/// Turn it is. [name] is what screen readers say.
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

  /// Index into [mateColors]: the colour and its face.
  final int colorIndex;
  final double size;
  final bool away;
  final bool turn;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final color = mateColors[colorIndex % mateColors.length];
    final face = SvgPicture.asset(color.face, width: size, height: size);
    Widget circle = SizedBox.square(
      dimension: size,
      child: CustomPaint(
        foregroundPainter: away ? _DashedCircle(fm.awayFg) : null,
        child: ClipOval(
          child: ColoredBox(
            color: away ? fm.awayBg : color.fill,
            child: face,
          ),
        ),
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
    return Semantics(
      label: name,
      excludeSemantics: true,
      // Its own size even when the parent stretches it (a dialog's icon,
      // say), instead of an oval; shrink-wraps everywhere else.
      child: Align(widthFactor: 1, heightFactor: 1, child: circle),
    );
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
