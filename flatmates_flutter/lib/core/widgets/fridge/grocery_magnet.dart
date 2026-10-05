import 'package:flutter/material.dart';

import '../../theme/fridge_colors.dart';
import 'magnet.dart';

/// The Grocery items still needed, as a short tick list.
class GroceryMagnet extends StatelessWidget {
  const GroceryMagnet({
    super.key,
    required this.items,
    this.maxShown = 5,
    this.color,
    this.tilt = 0,
    this.onTap,
    this.heroTag,
  });

  final List<({String name, String? note})> items;
  final int maxShown;
  final Color? color;
  final double tilt;
  final VoidCallback? onTap;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final shown = items.take(maxShown).toList();
    final extra = items.length - shown.length;
    return Magnet(
      color: color ?? context.fridge.groceries,
      tilt: tilt,
      onTap: onTap,
      heroTag: heroTag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Groceries', style: MagnetText.title.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          if (items.isEmpty)
            const Text('Nothing needed', style: MagnetText.small),
          for (var i = 0; i < shown.length; i++) ...[
            if (i > 0) const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(4),
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
                            style: MagnetText.small,
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
            Text('+$extra more', style: MagnetText.small),
          ],
        ],
      ),
    );
  }
}
