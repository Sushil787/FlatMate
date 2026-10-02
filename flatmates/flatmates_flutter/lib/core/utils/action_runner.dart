import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';

/// A message fit to show the user for any error from the server.
String describeError(Object error) => switch (error) {
  FlatmatesException(:final message) => message,
  ServerpodClientException() => 'Couldn\'t reach the server. Try again.',
  _ => 'Something went wrong. Try again.',
};

/// Runs a user action, showing its error (or [success]) in a snackbar.
/// Returns whether it succeeded.
Future<bool> runAction(
  BuildContext context,
  Future<void> Function() action, {
  String? success,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final errorColor = Theme.of(context).colorScheme.error;
  try {
    await action();
    if (success != null) {
      messenger.showSnackBar(SnackBar(content: Text(success)));
    }
    return true;
  } catch (e) {
    debugPrint('Action failed: $e');
    messenger.showSnackBar(
      SnackBar(
        content: Text(describeError(e)),
        backgroundColor: errorColor,
      ),
    );
    return false;
  }
}

/// Asks a yes/no question; resolves to true only on confirm.
Future<bool> confirm(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final scheme = Theme.of(context).colorScheme;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: destructive
              ? FilledButton.styleFrom(
                  backgroundColor: scheme.error,
                  foregroundColor: scheme.onError,
                  minimumSize: const Size(0, 44),
                )
              : FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
