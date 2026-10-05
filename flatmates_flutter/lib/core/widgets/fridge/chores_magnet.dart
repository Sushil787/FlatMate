import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import '../../utils/formatters.dart';
import '../mate_avatar.dart';
import 'magnet.dart';

/// The chore it's your Turn for, or "All clear!" when [choreName] is null.
class ChoresMagnet extends StatelessWidget {
  const ChoresMagnet({
    super.key,
    this.choreName,
    this.dueAt,
    this.rotation = const [],
    this.color,
    this.tilt = 0,
    this.onTap,
    this.heroTag,
  });

  final String? choreName;
  final DateTime? dueAt;

  /// The chore's Rotation, in order.
  final List<({int id, String name})> rotation;
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.fridge.chores;
    final name = choreName;
    return Magnet(
      color: c,
      tilt: tilt,
      onTap: onTap,
      heroTag: heroTag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name == null ? 'CHORES' : 'YOUR TURN',
            style: MagnetText.eyebrow,
          ),
          const SizedBox(height: 4),
          Text(
            name ?? 'All clear!',
            style: MagnetText.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (name == null)
            const Text('Nothing waiting on you.', style: MagnetText.small)
          else ...[
            if (dueAt != null) Text('Due in ${Fmt.remaining(dueAt!)}'),
            if (rotation.isNotEmpty) ...[
              const SizedBox(height: 8),
              AvatarStack(mates: rotation, size: 24, ringColor: c),
            ],
          ],
        ],
      ),
    );
  }
}
