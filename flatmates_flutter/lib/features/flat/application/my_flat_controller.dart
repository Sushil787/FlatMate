import 'package:flatmates_client/flatmates_client.dart' hide FlatRepository;
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/online_provider.dart';
import '../../../core/providers/read_cache.dart';
import '../../auth/application/auth_controller.dart';
import '../data/flat_repository.dart';

/// The signed-in user's Flat, or null when they haven't joined one.
final myFlatControllerProvider =
    AsyncNotifierProvider<MyFlatController, MyFlat?>(MyFlatController.new);

class MyFlatController extends AsyncNotifier<MyFlat?> {
  FlatRepository get _repo => ref.read(flatRepositoryProvider);

  @override
  Future<MyFlat?> build() async {
    final signedIn = ref.watch(authControllerProvider);
    if (!signedIn) return null;
    return ref.watch(flatRepositoryProvider).mine();
  }

  /// Reloads without dropping to a loading state.
  Future<void> refresh() async {
    state = await AsyncValue.guard(_repo.mine);
  }

  Future<void> create({
    required String flatName,
    required String myName,
  }) async {
    state = AsyncData(await _repo.create(flatName: flatName, myName: myName));
  }

  Future<void> join({
    required String inviteCode,
    required String myName,
  }) async {
    state = AsyncData(
      await _repo.join(inviteCode: inviteCode, myName: myName),
    );
  }

  Future<void> leave() async {
    await _repo.leave();
    await ref.read(readCacheProvider.notifier).clearAll();
    state = const AsyncData(null);
  }

  Future<void> regenerateInvite() async {
    await _repo.regenerateInvite();
    await refresh();
  }

  Future<void> setAwayRule(AwayRule rule) async {
    await _repo.setAwayRule(rule);
    await refresh();
  }

  Future<void> setMorningSummaryAt(int minutes) async {
    await _repo.setMorningSummaryAt(minutes);
    await refresh();
  }

  Future<void> rename(String name) async {
    await _repo.rename(name);
    await refresh();
  }

  Future<void> setMyName(String displayName) async {
    await _repo.setMyName(displayName);
    await refresh();
  }

  Future<void> setMyColor(MateColor color) => _updateMe(
    (me) => me.copyWith(color: color),
    (me) => _repo.setMyColor(color),
  );

  /// Saves the notify* switches on [wanted] (a changed copy of me).
  Future<void> setNotifications(Mate wanted) =>
      _updateMe((_) => wanted, _repo.setNotifications);

  /// Shows [change] to me at once, then saves it; rolls back on error.
  Future<void> _updateMe(
    Mate Function(Mate me) change,
    Future<Mate> Function(Mate me) save,
  ) async {
    requireOnline(ref);
    final before = state.value;
    if (before == null) return;
    final me = change(before.me);
    state = AsyncData(
      before.copyWith(
        me: me,
        mates: [for (final m in before.mates) m.id == me.id ? me : m],
      ),
    );
    try {
      await save(me);
    } catch (_) {
      state = AsyncData(before);
      rethrow;
    }
  }

  Future<void> welcomeMate(UuidValue mateId, List<UuidValue> choreIds) async {
    await _repo.welcomeMate(mateId, choreIds);
    await refresh();
  }

  Future<void> transferAdmin(UuidValue mateId) async {
    await _repo.transferAdmin(mateId);
    await refresh();
  }

  Future<void> removeMate(UuidValue mateId) async {
    await _repo.removeMate(mateId);
    await refresh();
  }
}
