import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../features/auth/application/auth_controller.dart'; // TODO(dev): login disabled
import '../features/flat/application/my_flat_controller.dart';

part 'session.g.dart';

/// Where the user is in the app's lifecycle; decides the top-level screen.
enum SessionStatus { loading, signedOut, noFlat, ready }

@Riverpod(keepAlive: true)
SessionStatus sessionStatus(Ref ref) {
  // TODO(dev): login disabled, restore before shipping.
  // if (!ref.watch(authControllerProvider)) return SessionStatus.signedOut;
  final flat = ref.watch(myFlatControllerProvider);
  if (!flat.hasValue) return SessionStatus.loading;
  return flat.value == null ? SessionStatus.noFlat : SessionStatus.ready;
}
