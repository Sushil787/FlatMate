import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';

/// The top Notice as a speech bubble: the pinned one, else the latest.
/// With no [text] the board is empty.
class NoticeMagnet extends StatelessWidget {
  const NoticeMagnet({
    super.key,
    this.text,
    this.author,
    this.pinned = false,
    this.color,
    this.tilt = 0,
    this.onTap,
    this.heroTag,
  });

  final String? text;
  final String? author;
  final bool pinned;
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;
  final Object? heroTag;

  static const _shape = BubbleBorder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Room for the bubble's tail.
      padding: EdgeInsets.only(bottom: _shape.tail.height),
      child: Magnet(
        color: color ?? context.fridge.notices,
        shape: _shape,
        tilt: tilt,
        onTap: onTap,
        heroTag: heroTag,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
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
                style: MagnetText.eyebrow,
              ),
              const SizedBox(height: 4),
              Text(
                text ?? 'Nothing posted yet.',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              if (author != null) ...[
                const SizedBox(height: 8),
                Text('— $author', style: MagnetText.small),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
