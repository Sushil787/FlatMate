import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/online_provider.dart';
import '../../../core/providers/read_cache.dart';

/// Whether a user is signed in. Follows the Serverpod auth session.
final authControllerProvider = NotifierProvider<AuthController, bool>(
  AuthController.new,
);

class AuthController extends Notifier<bool> {
  @override
  bool build() {
    final auth = ref.watch(clientProvider).auth;
    void onChange() {
      state = auth.isAuthenticated;
      // Signed out: what this phone saved was theirs.
      if (!state) ref.read(readCacheProvider.notifier).clearAll();
    }

    auth.authInfoListenable.addListener(onChange);
    ref.onDispose(() => auth.authInfoListenable.removeListener(onChange));
    return auth.isAuthenticated;
  }

  /// Signs out on this phone, and tells the server when it can be reached.
  /// Offline the server's session simply runs out; nobody holds it.
  Future<void> signOut() async {
    final auth = ref.read(clientProvider).auth;
    if (ref.read(onlineProvider)) {
      await auth.signOutDevice();
    } else {
      await auth.updateSignedInUser(null);
    }
  }
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
