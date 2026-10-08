import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../core/utils/action_runner.dart';
import '../core/widgets/banners.dart';
import '../features/flat/application/my_flat_controller.dart';

/// Shown while the user's Flat loads; offers a retry if it can't.
@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flat = ref.watch(myFlatControllerProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Space.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Flatmates', style: context.text.displaySmall),
              const SizedBox(height: Space.xl),
              if (flat.hasError)
                ErrorCard(
                  title: 'Couldn\'t reach your Flat',
                  message: describeError(flat.error!),
                  onRetry: () => ref.invalidate(myFlatControllerProvider),
                )
              else
                const SizedBox.square(
                  dimension: 28,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
