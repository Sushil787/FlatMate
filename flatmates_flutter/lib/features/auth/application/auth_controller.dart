import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';

/// Whether a user is signed in. Follows the Serverpod auth session.
final authControllerProvider = NotifierProvider<AuthController, bool>(
  AuthController.new,
);

class AuthController extends Notifier<bool> {
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

/// The signed-in user's Google name and email.
Future<UserProfileModel?> _myProfile(Ref ref) async {
  if (!ref.watch(authControllerProvider)) return null;
  return ref
      .watch(clientProvider)
      .modules
      .serverpod_auth_core
      .userProfileInfo
      .get();
}

final myProfileProvider = FutureProvider<UserProfileModel?>(_myProfile);
