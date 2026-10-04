import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';

part 'auth_controller.g.dart';

/// Whether a user is signed in. Follows the Serverpod auth session.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  bool build() {
    final auth = ref.watch(clientProvider).auth;
    void onChange() => state = auth.isAuthenticated;
    auth.authInfoListenable.addListener(onChange);
    ref.onDispose(() => auth.authInfoListenable.removeListener(onChange));
    return auth.isAuthenticated;
  }

  Future<void> signOut() => ref.read(clientProvider).auth.signOutDevice();
}
