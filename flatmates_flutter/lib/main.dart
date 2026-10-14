import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/providers/client_provider.dart';
import 'core/providers/read_cache.dart';
import 'core/providers/theme_mode_provider.dart';
import 'features/onboarding/application/onboarding_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set SERVER_URL with --dart-define to point at a deployed server;
  // otherwise assets/config.json (or localhost) is used.
  // Android emulators reach the host machine via 10.0.2.2, not localhost.
  final serverUrl = (await getServerUrl());
  final client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();
  // Web Google sign-in is a redirect flow back to web/auth.html; the client ID
  // comes from GOOGLE_CLIENT_ID (google_web.json). Native platforms read theirs
  // from google-services.json / Info.plist.
  if (kIsWeb && const bool.hasEnvironment('GOOGLE_CLIENT_ID')) {
    await client.auth.initializeGoogleSignIn(
      redirectUri: Uri.base.resolve('auth.html').toString(),
    );
  }

  // The read-only offline cache. Off on web, where SQLite needs more setup.
  CacheDb? cache;
  if (!kIsWeb) {
    final dir = await getApplicationSupportDirectory();
    final path = '${dir.path}/cache.db';
    cache = CacheDb(
      path,
      () => client.createSession(path, isDebugMode: kDebugMode),
    );
    await cache.open();
  }

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: {ThemeModeController.key, StorySeen.key},
    ),
  );

  runApp(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(client),
        cacheDbProvider.overrideWithValue(cache),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const FlatmatesApp(),
    ),
  );
}
