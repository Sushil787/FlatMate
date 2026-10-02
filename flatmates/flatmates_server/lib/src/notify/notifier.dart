import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Sends phone push notifications through Firebase Cloud Messaging.
///
/// Reads a Firebase service account JSON from the `fcmServiceAccount`
/// password. Without it, notifications are only logged, so the server runs
/// fine locally before Firebase is set up.
class Notifier {
  static AutoRefreshingAuthClient? _client;
  static String? _projectId;
  static bool _initialized = false;

  static Future<AutoRefreshingAuthClient?> _fcmClient(Session session) async {
    if (_initialized) return _client;
    _initialized = true;
    final json = session.passwords['fcmServiceAccount'];
    if (json == null || json.isEmpty) {
      session.log(
        'FCM not configured (no fcmServiceAccount password); '
        'notifications will only be logged.',
        level: LogLevel.warning,
      );
      return null;
    }
    final credentials = ServiceAccountCredentials.fromJson(json);
    _projectId = (jsonDecode(json) as Map<String, dynamic>)['project_id'];
    _client = await clientViaServiceAccount(
      credentials,
      ['https://www.googleapis.com/auth/firebase.messaging'],
    );
    return _client;
  }

  /// Notifies the given Mates on all their devices.
  static Future<void> toMates(
    Session session,
    Iterable<int> mateIds, {
    required String title,
    required String body,
  }) async {
    final ids = mateIds.toSet();
    if (ids.isEmpty) return;
    final mates = await Mate.db.find(
      session,
      where: (t) => t.id.inSet(ids) & t.leftAt.equals(null),
    );
    final users = mates.map((m) => m.authUserId).toSet();
    if (users.isEmpty) return;
    final tokens = await DeviceToken.db.find(
      session,
      where: (t) => t.authUserId.inSet(users),
    );

    session.log(
      'Notify ${mates.map((m) => m.displayName).join(', ')}: $title - $body',
    );

    final client = await _fcmClient(session);
    if (client == null) return;

    final url = Uri.parse(
      'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send',
    );
    for (final token in tokens) {
      try {
        final response = await client.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'message': {
              'token': token.token,
              'notification': {'title': title, 'body': body},
            },
          }),
        );
        if (response.statusCode == 404 || response.statusCode == 400) {
          // Token no longer valid: the app was uninstalled or reset.
          await DeviceToken.db.deleteRow(session, token);
        } else if (response.statusCode != 200) {
          session.log(
            'FCM send failed (${response.statusCode}): ${response.body}',
            level: LogLevel.warning,
          );
        }
      } on http.ClientException catch (e) {
        session.log('FCM send failed: $e', level: LogLevel.warning);
      }
    }
  }

  /// Notifies every Mate in the Flat, optionally leaving one out.
  static Future<void> toFlat(
    Session session,
    int flatId, {
    required String title,
    required String body,
    int? exceptMateId,
  }) async {
    final mates = await Mate.db.find(
      session,
      where: (t) => t.flatId.equals(flatId) & t.leftAt.equals(null),
    );
    await toMates(
      session,
      mates.map((m) => m.id!).where((id) => id != exceptMateId),
      title: title,
      body: body,
    );
  }
}
