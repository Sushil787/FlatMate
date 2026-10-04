import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../flat/application/mate_directory.dart';

/// Edits a Rotation: reorder by dragging, remove, or add any Mate (again).
class RotationEditor extends ConsumerWidget {
  const RotationEditor({
    super.key,
    required this.rotation,
    required this.onChanged,
  });

  final List<int> rotation;
  final ValueChanged<List<int>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (rotation.isEmpty)
          Padding(
            padding: const EdgeInsets.all(Insets.lg),
            child: Text(
              'Add at least one mate below.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: scheme.error),
            ),
          ),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          itemCount: rotation.length,
          onReorder: (from, to) {
            final next = [...rotation];
            if (to > from) to--;
            next.insert(to, next.removeAt(from));
            onChanged(next);
          },
          itemBuilder: (context, i) {
            final id = rotation[i];
            return Padding(
              key: ValueKey('$i-$id'),
              padding: const EdgeInsets.only(bottom: Insets.sm),
              child: Material(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(Radii.md),
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 22,
                        child: Text(
                          '${i + 1}',
                          style: text.labelLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      MateAvatar(
                        mateId: id,
                        name: directory.realNameOf(id),
                        size: 34,
                      ),
                    ],
                  ),
                  title: Text(directory.realNameOf(id)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Remove',
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () =>
                            onChanged([...rotation]..removeAt(i)),
                      ),
                      ReorderableDragStartListener(
                        index: i,
                        child: const Padding(
                          padding: EdgeInsets.all(Insets.sm),
                          child: Icon(Icons.drag_indicator_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: Insets.sm),
        Wrap(
          spacing: Insets.sm,
          runSpacing: Insets.sm,
          children: [
            for (final mate in directory.mates)
              ActionChip(
                avatar: const Icon(Icons.add_rounded, size: 18),
                label: Text(mate.displayName),
                onPressed: () => onChanged([...rotation, mate.id!]),
              ),
          ],
        ),
      ],
    );
  }
}
