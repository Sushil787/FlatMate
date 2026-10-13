import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../day.dart';
import '../generated/protocol.dart';
import '../rotation/turn_service.dart';

/// Email sign-ins the seed makes; development only.
const seedAdminEmail = 'admin@flatmates.dev';
const seedMateEmail = 'sam@flatmates.dev';
const seedPassword = 'flatmates123';

/// Fills an empty development database with one Flat to click around in:
/// an Admin and a Mate who sign in with email, Chores, Notices, Groceries
/// and an Event. Does nothing once any Flat exists.
Future<void> seedDevData(Session session) async {
  if (await Flat.db.count(session) > 0) return;
  const timezone = 'Asia/Kathmandu';
  final now = DateTime.now().toUtc();
  final today = Day.today(timezone);

  Future<UuidValue> user(String name, String email) async {
    final authUser = await AuthServices.instance.authUsers.create(session);
    await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: authUser.id,
      email: email,
      password: seedPassword,
    );
    await AuthServices.instance.userProfiles.createUserProfile(
      session,
      authUser.id,
      UserProfileData(fullName: name, email: email),
    );
    return authUser.id;
  }

  final flat = await Flat.db.insertRow(
    session,
    Flat(
      name: 'Elm Street',
      timezone: timezone,
      inviteCode: 'ELMSTR',
      inviteExpiresAt: now.add(const Duration(days: 365)),
      awayRule: AwayRule.swap,
    ),
  );
  final priya = await Mate.db.insertRow(
    session,
    Mate(
      flatId: flat.id!,
      authUserId: await user('Priya', seedAdminEmail),
      displayName: 'Priya',
      joinedAt: now,
      color: MateColor.tomato,
    ),
  );
  final sam = await Mate.db.insertRow(
    session,
    Mate(
      flatId: flat.id!,
      authUserId: await user('Sam', seedMateEmail),
      displayName: 'Sam',
      joinedAt: now,
      color: MateColor.sky,
    ),
  );
  flat.adminMateId = priya.id;
  await Flat.db.updateRow(session, flat);

  for (final (name, days, rotation) in [
    ('Take out the bins', 7, [priya, sam]),
    ('Clean the bathroom', 7, [sam, priya]),
    ('Wipe the kitchen', 1, [priya, sam]),
  ]) {
    final chore = await Chore.db.insertRow(
      session,
      Chore(
        flatId: flat.id!,
        name: name,
        period: Duration(days: days),
        startDay: today,
        rotation: [for (final m in rotation) m.id!],
        // The slot before the first, so the first Turn is rotation[0]'s.
        rotationIndex: rotation.length - 1,
        archived: false,
      ),
    );
    await TurnService.startChore(session, flat, chore);
  }

  await Notice.db.insert(session, [
    Notice(
      flatId: flat.id!,
      mateId: priya.id!,
      text: 'Landlord comes Friday at 10 to look at the boiler.',
      pinned: true,
    ),
    Notice(
      flatId: flat.id!,
      mateId: sam.id!,
      text: 'Wifi password is on the fridge now.',
      pinned: false,
    ),
  ]);
  await GroceryItem.db.insert(session, [
    for (final (name, by) in [
      ('Milk', priya),
      ('Bread', sam),
      ('Eggs', priya),
      ('Toilet roll', sam),
    ])
      GroceryItem(flatId: flat.id!, name: name, addedByMateId: by.id!),
  ]);
  final dinner = Day.at(timezone, Day.add(today, 2), 19 * 60);
  await FlatEvent.db.insertRow(
    session,
    FlatEvent(
      flatId: flat.id!,
      mateId: sam.id!,
      title: 'Flat dinner',
      startsAt: dinner,
      endsAt: dinner.add(const Duration(hours: 2)),
    ),
  );
  session.log(
    'Seeded Flat "${flat.name}": $seedAdminEmail (Admin) and $seedMateEmail, '
    'password $seedPassword.',
  );
}
