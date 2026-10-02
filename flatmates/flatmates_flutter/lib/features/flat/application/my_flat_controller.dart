import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_controller.dart';
import '../data/flat_repository.dart';

part 'my_flat_controller.g.dart';

/// The signed-in user's Flat, or null when they haven't joined one.
@Riverpod(keepAlive: true)
class MyFlatController extends _$MyFlatController {
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

  Future<void> create({required String flatName, required String myName}) async {
    state = AsyncData(await _repo.create(flatName: flatName, myName: myName));
  }

  Future<void> join({required String inviteCode, required String myName}) async {
    state = AsyncData(
      await _repo.join(inviteCode: inviteCode, myName: myName),
    );
  }

  Future<void> leave() async {
    await _repo.leave();
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

  Future<void> transferAdmin(int mateId) async {
    await _repo.transferAdmin(mateId);
    await refresh();
  }

  Future<void> removeMate(int mateId) async {
    await _repo.removeMate(mateId);
    await refresh();
  }
}
