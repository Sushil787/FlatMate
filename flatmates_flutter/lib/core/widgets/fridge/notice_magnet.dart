import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';
import 'magnet_screen.dart';
import 'note.dart';

/// The top Notice on a sheet of notebook paper: the pinned one, else the
/// latest. With no [text] the board is empty.
class NoticeMagnet extends StatelessWidget {
  const NoticeMagnet({
    super.key,
    this.text,
    this.author,
    this.pinned = false,
    this.color,
    this.tilt = 0,
    this.onTap,
  });

  final String? text;
  final String? author;
  final bool pinned;

  /// The magnet's colour.
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Note(
      section: FridgeSection.notices,
      tilt: tilt,
      onTap: onTap,
      // Rules under each line of the text, below the label.
      ruledFrom: 63,
      padding: const EdgeInsets.fromLTRB(28, 24, 16, 16),
      pins: [
        (
          0.6,
          Magnet(
            color: color ?? context.fridge.notices,
            shape: const BubbleBorder(
              radius: 10,
              tailCorner: 4,
              tail: Size(6, 6),
              tailInset: 8,
            ),
            size: const Size(36, 24),
          ),
        ),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text == null
                  ? 'NOTICE BOARD'
                  : pinned
                  ? 'PINNED'
                  : 'LATEST',
              style: NoteText.eyebrow,
            ),
            const SizedBox(height: 4),
            Text(
              text ?? 'Nothing posted yet.',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            if (author != null)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text('— $author', style: NoteText.body),
              ),
          ],
        ),
      ),
    );
  }
}
