import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import '../mate_avatar.dart';
import 'magnet.dart';
import 'magnet_screen.dart';
import 'note.dart';

/// A card with the Flat's name and its Mates.
class FlatMagnet extends StatelessWidget {
  const FlatMagnet({
    super.key,
    required this.flatName,
    required this.mates,
    this.color,
    this.tilt = 0,
    this.onTap,
  });

  final String flatName;
  final List<({int id, String name})> mates;

  /// The magnet's colour.
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Note(
      section: FridgeSection.flat,
      tilt: tilt,
      onTap: onTap,
      pins: [(0.5, Magnet.smiley(color: color ?? context.fridge.flat))],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('OUR FLAT', style: NoteText.eyebrow),
          const SizedBox(height: 4),
          Text(
            flatName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: NoteText.title.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 12),
          AvatarStack(
            mates: mates,
            size: 28,
            max: 4,
            ringColor: FridgeSection.flat.paper,
          ),
        ],
      ),
    );
  }
}
