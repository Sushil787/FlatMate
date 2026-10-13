import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_theme.dart';
import '../utils/action_runner.dart';
import 'banners.dart';

/// Renders an [AsyncValue]: [loading] (a spinner by default) the first
/// time, an error card with Try again, and [data] otherwise (keeping stale
/// data while reloading).
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
    this.loading,
    this.header,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final Widget? loading;

  /// Shown above the spinner and the error card, e.g. a back button, so a
  /// screen that fails to load still has its way out. [data] draws its own.
  final Widget? header;

  Widget _underHeader(Widget body) => header == null
      ? body
      : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header!,
            Expanded(child: body),
          ],
        );

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => _underHeader(
        loading ?? const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => _underHeader(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(Space.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: ErrorCard(
                title: 'Couldn\'t load this',
                message: describeError(error),
                onRetry: onRetry,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
