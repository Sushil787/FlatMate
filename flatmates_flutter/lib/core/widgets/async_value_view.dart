import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/action_runner.dart';
import 'empty_state.dart';

/// Renders an [AsyncValue]: a spinner while loading the first time, a retry
/// screen on error, and [data] otherwise (keeping stale data while reloading).
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => EmptyState(
        icon: Icons.cloud_off_rounded,
        title: 'Couldn\'t load this',
        message: describeError(error),
        action: onRetry == null
            ? null
            : FilledButton.tonal(
                onPressed: onRetry,
                child: const Text('Try again'),
              ),
      ),
    );
  }
}
