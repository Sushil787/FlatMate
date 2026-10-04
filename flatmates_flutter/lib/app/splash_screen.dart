import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_spacing.dart';
import '../core/utils/action_runner.dart';
import '../core/widgets/illustration.dart';
import '../features/flat/application/my_flat_controller.dart';

/// Shown while the user's Flat loads; offers a retry if it can't.
@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flat = ref.watch(myFlatControllerProvider);
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Illustration(icon: Icons.cottage_rounded),
            const SizedBox(height: Insets.lg),
            Text('Flatmates', style: theme.textTheme.headlineMedium),
            const SizedBox(height: Insets.xl),
            if (flat.hasError) ...[
              Text(
                describeError(flat.error!),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: Insets.md),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(myFlatControllerProvider),
                child: const Text('Try again'),
              ),
            ] else
              const SizedBox.square(
                dimension: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
          ],
        ),
      ),
    );
  }
}
