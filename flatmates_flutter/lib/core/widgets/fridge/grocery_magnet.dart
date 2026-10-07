import 'package:flutter/material.dart';

import 'magnet.dart';
import 'magnet_screen.dart';
import 'note.dart';

/// The Grocery items still needed, as a tick list on a shopping pad.
class GroceryMagnet extends StatelessWidget {
  const GroceryMagnet({
    super.key,
    required this.items,
    this.maxShown = 5,
    this.tilt = 0,
    this.onTap,
  });

  final List<({String name, String? note})> items;
  final int maxShown;
  final double tilt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shown = items.take(maxShown).toList();
    final extra = items.length - shown.length;
    return Note(
      section: FridgeSection.groceries,
      tilt: tilt,
      onTap: onTap,
      pins: const [(0.75, CarrotMagnet())],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Shrinks rather than wraps on a narrow phone.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Groceries',
              style: NoteText.title.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          if (items.isEmpty)
            const Text('Nothing needed', style: NoteText.small),
          for (var i = 0; i < shown.length; i++) ...[
            if (i > 0) const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    border: Border.all(color: NoteText.ink, width: 1.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: shown[i].name),
                        if (shown[i].note != null)
                          TextSpan(
                            text: '  ${shown[i].note}',
                            style: NoteText.small,
                          ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (extra > 0) ...[
            const SizedBox(height: 4),
            Text('+$extra more', style: NoteText.small),
          ],
        ],
      ),
    );
  }
}
