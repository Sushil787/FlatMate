import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A message fit to show the user for any error from the server.
String describeError(Object error) => switch (error) {
  FlatmatesException(:final message) => message,
  ServerpodClientException() => 'Couldn\'t reach the server. Try again.',
  _ => 'Something went wrong. Try again.',
};

/// Runs a user action, showing its error (or [success]) in a snackbar.
/// Returns whether it ran and succeeded. An action that returns false (an
/// [ActionNotifier] that was already running) counts as not run.
Future<bool> runAction(
  BuildContext context,
  Future<Object?> Function() action, {
  String? success,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    if (await action() == false) return false;
    if (success != null) showMessage(messenger, success);
    return true;
  } catch (e) {
    debugPrint('Action failed: $e');
    showMessage(messenger, describeError(e));
    return false;
  }
}

String? _showing;

/// Shows [message] in a snackbar in place of any other, so repeated taps
/// (offline, say) don't line up a queue; nothing if it's already showing.
void showMessage(ScaffoldMessengerState messenger, String message) {
  if (_showing == message) return;
  _showing = message;
  messenger
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message))).closed.then((_) {
      if (_showing == message) _showing = null;
    });
}

/// Asks a yes/no question; resolves to true only on confirm.
Future<bool> confirm(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final fm = context.fm;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(foregroundColor: fm.ink),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 48),
            backgroundColor: destructive ? fm.dangerFg : null,
            foregroundColor: destructive ? fm.dangerBg : null,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
