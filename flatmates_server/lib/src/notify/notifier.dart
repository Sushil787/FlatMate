import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Notifications a Mate can switch off; anything else is always sent.
enum NotifyKind { turnStarts, reminder, missed, notice, addedToRotation }

bool _wants(Mate m, NotifyKind? kind) => switch (kind) {
  null => true,
  NotifyKind.turnStarts => m.notifyTurnStarts,
  NotifyKind.reminder => m.notifyReminder,
  NotifyKind.missed => m.notifyMissed,
  NotifyKind.notice => m.notifyNotice,
  NotifyKind.addedToRotation => m.notifyAddedToRotation,
};

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

  /// Notifies the given Mates on all their devices, leaving out those who
  /// switched [kind] off. Returns the Mates notified.
  static Future<List<Mate>> toMates(
    Session session,
    Iterable<int> mateIds, {
    required String title,
    required String body,
    NotifyKind? kind,
  }) async {
    final ids = mateIds.toSet();
    if (ids.isEmpty) return [];
    final mates = (await Mate.db.find(
      session,
      where: (t) => t.id.inSet(ids) & t.leftAt.equals(null),
    )).where((m) => _wants(m, kind)).toList();
    final users = mates.map((m) => m.authUserId).toSet();
    if (users.isEmpty) return [];
    final tokens = await DeviceToken.db.find(
      session,
      where: (t) => t.authUserId.inSet(users),
    );

    session.log(
      'Notify ${mates.map((m) => m.displayName).join(', ')}: $title - $body',
    );

    final client = await _fcmClient(session);
    if (client == null) return mates;

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
    return mates;
  }

  /// Notifies every Mate in the Flat, optionally leaving one out.
  static Future<void> toFlat(
    Session session,
    int flatId, {
    required String title,
    required String body,
    int? exceptMateId,
    NotifyKind? kind,
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
      kind: kind,
    );
  }
}
