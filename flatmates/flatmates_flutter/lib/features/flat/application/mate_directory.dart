import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'my_flat_controller.dart';

part 'mate_directory.g.dart';

/// Who's who in the signed-in user's Flat.
class MateDirectory {
  MateDirectory(this._flat) : _byId = {for (final m in _flat.mates) m.id!: m};

  final MyFlat _flat;
  final Map<int, Mate> _byId;

  Flat get flat => _flat.flat;
  Mate get me => _flat.me;
  List<Mate> get mates => _flat.mates;
  bool get amAdmin => flat.adminMateId == me.id;

  bool isMe(int? mateId) => mateId == me.id;
  bool isAdmin(int? mateId) => mateId == flat.adminMateId;

  /// The Mate's name, or "You" for the signed-in user.
  String nameOf(int? mateId) {
    if (isMe(mateId)) return 'You';
    return realNameOf(mateId);
  }

  /// The Mate's own name, even for the signed-in user.
  String realNameOf(int? mateId) =>
      _byId[mateId]?.displayName ?? 'Former mate';
}

/// The current [MateDirectory]. Only read it inside the home shell, where
/// the user is known to be in a Flat.
@Riverpod(keepAlive: true)
class MateDirectoryNotifier extends _$MateDirectoryNotifier {
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
@Riverpod(keepAlive: true)
int? currentFlatId(Ref ref) =>
    ref.watch(myFlatControllerProvider).value?.flat.id;
