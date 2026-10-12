import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/updated_at.dart';
import 'src/web/routes/app_config_route.dart';

void run(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());

  pod.initializeAuthServices(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      // Google is how Mates sign in. Needs the `googleClientSecret` password.
      if (pod.getPassword('googleClientSecret') != null)
        GoogleIdpConfigFromPasswords(),
    ],
  );

  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(path: 'web/app').toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  await pod.start();
  final session = await pod.createSession();
  try {
    await installUpdatedAtTriggers(session);
  } finally {
    await session.close();
  }
}
