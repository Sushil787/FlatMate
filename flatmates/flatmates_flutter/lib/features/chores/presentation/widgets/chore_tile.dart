import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../flat/application/mate_directory.dart';
import 'turn_status.dart';

/// One Chore: who has it now, how often it rotates, and its rotation.
class ChoreTile extends ConsumerWidget {
  const ChoreTile({
    super.key,
    required this.chore,
    required this.turn,
    this.onTap,
  });

  final Chore chore;
  final Turn? turn;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final theme = Theme.of(context);
    final holder = turn?.mateId;
    final covering = turn?.coveringForMateId;
    final rotation = <({int id, String name})>[];
    for (final id in chore.rotation) {
      if (rotation.every((m) => m.id != id)) {
        rotation.add((id: id, name: directory.realNameOf(id)));
      }
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Row(
            children: [
              MateAvatar(
                mateId: holder,
                name: holder == null ? '?' : directory.realNameOf(holder),
                size: 46,
              ),
              const SizedBox(width: Insets.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chore.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      holder == null
                          ? 'No one in the rotation'
                          : '${directory.nameOf(holder)}'
                                '${covering == null ? '' : ' (for ${directory.realNameOf(covering)})'}'
                                ' · every ${Fmt.period(chore.period)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: Insets.sm),
                    Row(
                      children: [
                        TurnStatusPill(turn: turn),
                        const Spacer(),
                        AvatarStack(mates: rotation, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
