import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_flat_controller.dart';

/// Who's who in the signed-in user's Flat.
class MateDirectory {
  MateDirectory(this._flat) : _byId = {for (final m in _flat.mates) m.id!: m};

  final MyFlat _flat;
  final Map<UuidValue, Mate> _byId;

  Flat get flat => _flat.flat;
  Mate get me => _flat.me;
  List<Mate> get mates => _flat.mates;
  bool get amAdmin => flat.adminMateId == me.id;

  bool isMe(UuidValue? mateId) => mateId == me.id;
  bool isAdmin(UuidValue? mateId) => mateId == flat.adminMateId;

  /// The Mate's name, or "You" for the signed-in user.
  String nameOf(UuidValue? mateId) {
    if (isMe(mateId)) return 'You';
    return realNameOf(mateId);
  }

  /// The Mate's own name, even for the signed-in user.
  String realNameOf(UuidValue? mateId) =>
      _byId[mateId]?.displayName ?? 'Former Mate';

  /// Index into the theme's `mateColors`.
  int colorIndexOf(UuidValue? mateId) => _byId[mateId]?.color.index ?? 0;
}

/// The current [MateDirectory]. Only read it inside the home shell, where
/// the user is known to be in a Flat.
final mateDirectoryProvider =
    NotifierProvider<MateDirectoryNotifier, MateDirectory>(
      MateDirectoryNotifier.new,
    );

class MateDirectoryNotifier extends Notifier<MateDirectory> {
  @override
  MateDirectory build() {
    final flat = ref.watch(myFlatControllerProvider).value;
    if (flat != null) return MateDirectory(flat);
    // Just left the Flat or signed out: keep the last directory for the
    // frame or two before navigation leaves the Flat's screens.
    final last = stateOrNull;
    if (last != null) return last;
    throw StateError('Read the mate directory outside a flat');
  }
}

/// The current Flat's id, or null. Data providers watch this so they reload
/// when the user joins or leaves a Flat; it only notifies when the id
/// itself changes.
UuidValue? _currentFlatId(Ref ref) =>
    ref.watch(myFlatControllerProvider).value?.flat.id;

final currentFlatIdProvider = Provider<UuidValue?>(_currentFlatId);
