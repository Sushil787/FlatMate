import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import '../mate_avatar.dart';
import 'magnet.dart';

/// A round magnet with the Flat's name and its Mates.
class FlatMagnet extends StatelessWidget {
  const FlatMagnet({
    super.key,
    required this.flatName,
    required this.mates,
    this.color,
    this.tilt = 0,
    this.onTap,
    this.heroTag,
  });

  final String flatName;
  final List<({int id, String name})> mates;
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.fridge.flat;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 160),
      child: Magnet(
        color: c,
        shape: const CircleBorder(),
        tilt: tilt,
        onTap: onTap,
        heroTag: heroTag,
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          // Small phones get a small circle; shrink the print to fit it.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              // Laid out at the biggest circle's size, then scaled.
              width: 128,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarStack(mates: mates, size: 24, max: 4, ringColor: c),
                  const SizedBox(height: 8),
                  Text(
                    flatName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MagnetText.title.copyWith(fontSize: 16),
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
