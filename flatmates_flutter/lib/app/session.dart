import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/application/auth_controller.dart';
import '../features/flat/application/my_flat_controller.dart';

/// Where the user is in the app's lifecycle; decides the top-level screen.
enum SessionStatus { loading, signedOut, noFlat, ready }

SessionStatus _sessionStatus(Ref ref) {
  if (!ref.watch(authControllerProvider)) return SessionStatus.signedOut;
  final flat = ref.watch(myFlatControllerProvider);
  if (!flat.hasValue) return SessionStatus.loading;
  return flat.value == null ? SessionStatus.noFlat : SessionStatus.ready;
}

final sessionStatusProvider = Provider<SessionStatus>(_sessionStatus);
