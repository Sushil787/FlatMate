import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A Mate's initial on their own stable colour.
class MateAvatar extends StatelessWidget {
  const MateAvatar({
    super.key,
    required this.mateId,
    required this.name,
    this.size = 40,
    this.ring = false,
    this.ringColor,
  });

  final int? mateId;
  final String name;
  final double size;

  /// Draws a ring, for avatars that overlap.
  final bool ring;

  /// Colour of the ring; the surface colour by default.
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.mateColor(mateId);
    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.18)!],
        ),
        border: ring
            ? Border.all(
                color: ringColor ?? Theme.of(context).colorScheme.surface,
                width: 2,
              )
            : null,
      ),
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.42,
        ),
      ),
    );
  }
}

/// Overlapping avatars, e.g. the Mates in a Rotation.
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.mates,
    this.size = 28,
    this.max = 5,
    this.ringColor,
  });

  final List<({int id, String name})> mates;
  final double size;
  final int max;

  /// Colour of the rings between avatars; match what they sit on.
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    final shown = mates.take(max).toList();
    final extra = mates.length - shown.length;
    final step = size * 0.68;
    final count = shown.length + (extra > 0 ? 1 : 0);
    return SizedBox(
      height: size,
      width: count == 0 ? 0 : step * (count - 1) + size,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * step,
              child: MateAvatar(
                mateId: shown[i].id,
                name: shown[i].name,
                size: size,
                ring: true,
                ringColor: ringColor,
              ),
            ),
          if (extra > 0)
            Positioned(
              left: shown.length * step,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  border: Border.all(
                    color: ringColor ?? Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
                child: Text(
                  '+$extra',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
