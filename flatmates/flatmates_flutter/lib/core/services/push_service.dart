import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/client_provider.dart';

part 'push_service.g.dart';

@Riverpod(keepAlive: true)
PushService pushService(Ref ref) => PushService(ref.watch(clientProvider));

/// Registers the device with FCM and the server. A no-op until Firebase is
/// configured for the app, so everything else works without it.
class PushService {
  PushService(this._client);

  final Client _client;
  bool _registered = false;

  Future<void> register() async {
    if (_registered || kIsWeb) return;
    try {
      if (Firebase.apps.isEmpty) await Firebase.initializeApp();
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final token = await messaging.getToken();
      if (token != null) await _client.flat.registerDevice(token);
      messaging.onTokenRefresh.listen(_client.flat.registerDevice);
      _registered = true;
    } catch (e) {
      debugPrint('Push notifications unavailable: $e');
    }
  }
}
