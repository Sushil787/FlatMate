import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase_options.dart';
import '../providers/client_provider.dart';

PushService _pushService(Ref ref) => PushService(ref.watch(clientProvider));

final pushServiceProvider = Provider<PushService>(_pushService);

/// Registers the device with FCM and the server. Failures are logged and
/// ignored, so everything else works without push.
class PushService {
  PushService(this._client);

  final Client _client;
  bool _registered = false;

  Future<void> register() async {
    if (_registered || kIsWeb) return;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
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
