import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.gr.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/action_runner.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/mate_avatar.dart';
import '../../../core/widgets/section_header.dart';
import '../../flat/application/mate_directory.dart';
import '../application/chores_controller.dart';
import '../domain/chores_overview.dart';
import 'widgets/chore_tile.dart';
import 'widgets/my_turn_card.dart';

/// Home tab: the user's own Turns up top, then everyone's Chores.
@RoutePage()
class ChoresScreen extends ConsumerWidget {
  const ChoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final directory = ref.watch(mateDirectoryProvider);
    final chores = ref.watch(choresControllerProvider);

    return Scaffold(
      floatingActionButton: directory.amAdmin
          ? FloatingActionButton.extended(
              onPressed: () => context.router.push(ChoreEditorRoute()),
              icon: const Icon(Icons.add_rounded),
              label: const Text('New chore'),
            )
          : null,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: ref.read(choresControllerProvider.notifier).refresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Greeting(directory: directory)),
              ...chores.when(
                skipLoadingOnRefresh: true,
                skipLoadingOnReload: true,
                data: (overview) => _content(context, directory, overview),
                loading: () => const [
                  SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
                error: (error, _) => [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.cloud_off_rounded,
                      title: 'Couldn\'t load chores',
                      message: describeError(error),
                      action: FilledButton.tonal(
                        onPressed: () =>
                            ref.invalidate(choresControllerProvider),
                        child: const Text('Try again'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(
    BuildContext context,
    MateDirectory directory,
    ChoresOverview overview,
  ) {
    if (overview.chores.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.cleaning_services_rounded,
            title: 'No chores yet',
            message: directory.amAdmin
                ? 'Add the first chore, pick who\'s in the rotation, and turns take care of themselves.'
                : 'Your admin sets up chores. They\'ll show up here.',
          ),
        ),
      ];
    }

    final mine = overview.openTurnsOf(directory.me.id!);
    final others = overview.othersFor(directory.me.id!);
    void edit(int choreId) =>
        context.router.push(ChoreEditorRoute(choreId: choreId));

    return [
      SliverPadding(
        padding: Insets.screen,
        sliver: SliverList.separated(
          itemCount: mine.isEmpty ? 1 : mine.length,
          separatorBuilder: (_, _) => const SizedBox(height: Insets.md),
          itemBuilder: (_, i) => mine.isEmpty
              ? const AllClearCard()
              : MyTurnCard(chore: mine[i].$1, turn: mine[i].$2),
        ),
      ),
      if (others.isNotEmpty) ...[
        const SliverToBoxAdapter(child: SectionHeader('Everyone\'s chores')),
        SliverPadding(
          padding: Insets.screen.copyWith(bottom: 112),
          sliver: SliverList.separated(
            itemCount: others.length,
            separatorBuilder: (_, _) => const SizedBox(height: Insets.md),
            itemBuilder: (_, i) => ChoreTile(
              chore: others[i],
              turn: overview.turnFor(others[i]),
              onTap: directory.amAdmin ? () => edit(others[i].id!) : null,
            ),
          ),
        ),
      ] else
        const SliverToBoxAdapter(child: SizedBox(height: 112)),
    ];
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.directory});

  final MateDirectory directory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Insets.lg,
        Insets.lg,
        Insets.lg,
        Insets.xl,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Fmt.greeting()},',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  directory.me.displayName,
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.cottage_rounded,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${directory.flat.name} · ${directory.mates.length} mates',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          MateAvatar(
            mateId: directory.me.id,
            name: directory.me.displayName,
            size: 52,
          ),
        ],
      ),
    );
  }
}
