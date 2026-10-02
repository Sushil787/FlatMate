import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'app/app.dart';
import 'core/providers/client_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set SERVER_URL with --dart-define to point at a deployed server;
  // otherwise assets/config.json (or localhost) is used.
  final serverUrl = await getServerUrl();
  final client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();

  runApp(
    ProviderScope(
      overrides: [clientProvider.overrideWithValue(client)],
      child: const FlatmatesApp(),
    ),
  );
}
