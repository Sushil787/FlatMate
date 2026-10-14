import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the app can reach the server. Goes false when the live
/// connection drops and true once it's back.
final onlineProvider = NotifierProvider<Online, bool>(Online.new);

class Online extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool online) {
    if (state != online) state = online;
  }
}

/// Changes need the server: the cache on this phone is read-only. Throws a
/// message fit to show when offline.
void requireOnline(Ref ref) {
  if (!ref.read(onlineProvider)) {
    throw FlatmatesException(
      message: 'You\'re offline. Changes need a connection.',
    );
  }
}
