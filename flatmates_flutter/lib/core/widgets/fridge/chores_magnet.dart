import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import '../../utils/formatters.dart';
import '../mate_avatar.dart';
import 'magnet.dart';
import 'magnet_screen.dart';
import 'note.dart';

/// A card with the chore it's your Turn for, or "All clear!" when
/// [choreName] is null.
class ChoresMagnet extends StatelessWidget {
  const ChoresMagnet({
    super.key,
    this.choreName,
    this.dueAt,
    this.rotation = const [],
    this.color,
    this.tilt = 0,
    this.onTap,
  });

  final String? choreName;
  final DateTime? dueAt;

  /// The chore's Rotation, in order.
  final List<({int id, String name})> rotation;

  /// The magnet's and the card's stripe colour.
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.fridge.chores;
    final name = choreName;
    return Note(
      section: FridgeSection.chores,
      tilt: tilt,
      onTap: onTap,
      padding: EdgeInsets.zero,
      pins: [(0.5, Magnet.smiley(color: c))],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ColoredBox(
            color: c,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Text(
                name == null ? 'CHORES' : 'YOUR TURN',
                textAlign: TextAlign.center,
                style: NoteText.eyebrow.copyWith(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name ?? 'All clear!',
                  textAlign: TextAlign.center,
                  style: NoteText.title.copyWith(fontSize: 24),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (name == null)
                  const Text(
                    'Nothing waiting on you.',
                    textAlign: TextAlign.center,
                    style: NoteText.small,
                  )
                else ...[
                  if (dueAt != null) Text('Due in ${Fmt.remaining(dueAt!)}'),
                  if (rotation.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    AvatarStack(
                      mates: rotation,
                      size: 24,
                      ringColor: FridgeSection.chores.paper,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
