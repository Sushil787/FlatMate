import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/action_notifier.dart';
import '../../auth/application/auth_controller.dart';
import 'my_flat_controller.dart';

MyFlatController _flat(Ref ref) => ref.read(myFlatControllerProvider.notifier);

/// Creating a Flat.
final createFlatProvider = AsyncNotifierProvider.autoDispose<CreateFlat, void>(
  CreateFlat.new,
);

class CreateFlat extends ActionNotifier {
  Future<bool> run({required String flatName, required String myName}) =>
      guard(() => _flat(ref).create(flatName: flatName, myName: myName));
}

/// Joining a Flat with an Invite code.
final joinFlatProvider = AsyncNotifierProvider.autoDispose<JoinFlat, void>(
  JoinFlat.new,
);

class JoinFlat extends ActionNotifier {
  Future<bool> run({required String inviteCode, required String myName}) =>
      guard(() => _flat(ref).join(inviteCode: inviteCode, myName: myName));
}

/// Leaving the Flat.
final leaveFlatProvider = AsyncNotifierProvider.autoDispose<LeaveFlat, void>(
  LeaveFlat.new,
);

class LeaveFlat extends ActionNotifier {
  Future<bool> run() => guard(() => _flat(ref).leave());
}

/// Making a new Invite code.
final newInviteProvider = AsyncNotifierProvider.autoDispose<NewInvite, void>(
  NewInvite.new,
);

class NewInvite extends ActionNotifier {
  Future<bool> run() => guard(() => _flat(ref).regenerateInvite());
}

/// Renaming the Flat.
final renameFlatProvider = AsyncNotifierProvider.autoDispose<RenameFlat, void>(
  RenameFlat.new,
);

class RenameFlat extends ActionNotifier {
  Future<bool> run(String name) => guard(() => _flat(ref).rename(name));
}

/// Changing the signed-in Mate's name.
final renameMeProvider = AsyncNotifierProvider.autoDispose<RenameMe, void>(
  RenameMe.new,
);

class RenameMe extends ActionNotifier {
  Future<bool> run(String name) => guard(() => _flat(ref).setMyName(name));
}

/// Setting the Flat's Away rule.
final setAwayRuleProvider =
    AsyncNotifierProvider.autoDispose<SetAwayRule, void>(SetAwayRule.new);

class SetAwayRule extends ActionNotifier {
  Future<bool> run(AwayRule rule) => guard(() => _flat(ref).setAwayRule(rule));
}

/// Setting when the Flat's morning summary goes out.
final setMorningSummaryProvider =
    AsyncNotifierProvider.autoDispose<SetMorningSummary, void>(
      SetMorningSummary.new,
    );

class SetMorningSummary extends ActionNotifier {
  Future<bool> run(int minutes) =>
      guard(() => _flat(ref).setMorningSummaryAt(minutes));
}

/// Finishing onboarding.
final finishOnboardingProvider =
    AsyncNotifierProvider.autoDispose<FinishOnboarding, void>(
      FinishOnboarding.new,
    );

class FinishOnboarding extends ActionNotifier {
  Future<bool> run() => guard(() => _flat(ref).finishOnboarding());
}

/// Answering the new-Mate dialog: adding them to Chores, or not, by Mate id.
final welcomeMateProvider = AsyncNotifierProvider.autoDispose
    .family<WelcomeMate, void, UuidValue>(WelcomeMate.new);

class WelcomeMate extends ActionNotifier {
  WelcomeMate(this.mateId);

  final UuidValue mateId;

  Future<bool> run(List<UuidValue> choreIds) =>
      guard(() => _flat(ref).welcomeMate(mateId, choreIds));
}

/// Handing the Admin role to a Mate, by Mate id.
final makeAdminProvider = AsyncNotifierProvider.autoDispose
    .family<MakeAdmin, void, UuidValue>(MakeAdmin.new);

class MakeAdmin extends ActionNotifier {
  MakeAdmin(this.mateId);

  final UuidValue mateId;

  Future<bool> run() => guard(() => _flat(ref).transferAdmin(mateId));
}

/// Removing a Mate from the Flat, by Mate id.
final removeMateProvider = AsyncNotifierProvider.autoDispose
    .family<RemoveMate, void, UuidValue>(RemoveMate.new);

class RemoveMate extends ActionNotifier {
  RemoveMate(this.mateId);

  final UuidValue mateId;

  Future<bool> run() => guard(() => _flat(ref).removeMate(mateId));
}

/// Signing out.
final signOutProvider = AsyncNotifierProvider.autoDispose<SignOut, void>(
  SignOut.new,
);

/// Works offline too: the phone forgets the session either way.
class SignOut extends ActionNotifier {
  Future<bool> run() => guard(
    () => ref.read(authControllerProvider.notifier).signOut(),
    needsServer: false,
  );
}
