import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase_options.dart';
import '../providers/client_provider.dart';

PushService _pushService(Ref ref) => PushService(ref.watch(clientProvider));

final pushServiceProvider = Provider<PushService>(_pushService);

/// Whether the phone shows the app's notifications; see [PushService.allowed].
final pushAllowedProvider = FutureProvider<bool>(
  (ref) => ref.watch(pushServiceProvider).allowed(),
);

/// Registers the device with FCM and the server. Failures are logged and
/// ignored, so everything else works without push.
class PushService {
  PushService(this._client);

  final Client _client;
  bool _registered = false;
  final _foreground = StreamController<RemoteNotification>.broadcast();

  /// Notifications that arrive while the app is open. The phone shows none
  /// itself then, so the app shows them in-app.
  Stream<RemoteNotification> get foreground => _foreground.stream;

  Future<void> _init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  /// Sends the device's token to the server. Doesn't ask for permission:
  /// that's [ask], after the app has said what notifications are for.
  Future<void> register() async {
    if (_registered || kIsWeb) return;
    try {
      await _init();
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      if (token != null) await _client.flat.registerDevice(token);
      messaging.onTokenRefresh.listen(_client.flat.registerDevice);
      FirebaseMessaging.onMessage.listen((m) {
        if (m.notification != null) _foreground.add(m.notification!);
      });
      _registered = true;
    } catch (e) {
      debugPrint('Push notifications unavailable: $e');
    }
  }

  /// Whether the phone shows the app's notifications. True where push
  /// isn't available, so nobody is asked for nothing.
  Future<bool> allowed() async {
    if (kIsWeb) return true;
    try {
      await _init();
      final settings = await FirebaseMessaging.instance
          .getNotificationSettings();
      return settings.authorizationStatus != AuthorizationStatus.denied &&
          settings.authorizationStatus != AuthorizationStatus.notDetermined;
    } catch (_) {
      return true;
    }
  }

  /// The phone's permission prompt. iOS shows it once ever and Android 13+
  /// stops after two denials, so only call it when the user said yes.
  Future<bool> ask() async {
    if (kIsWeb) return true;
    try {
      await _init();
      await FirebaseMessaging.instance.requestPermission();
      await register();
    } catch (e) {
      debugPrint('Push notifications unavailable: $e');
    }
    return allowed();
  }
}
