import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/providers/google.dart'
    show GoogleAccount;

import '../flat_access.dart';

/// Email and password sign-in, for anyone without Google (hackathon judges,
/// say).
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  /// Refuses an address that already signs in with Google: sign-ins aren't
  /// linked by address, so it would make a second, empty account for the
  /// same person.
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    final google = await GoogleAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email.trim().toLowerCase()),
    );
    if (google != null) {
      fail('This email signs in with Google. Use Continue with Google.');
    }
    return super.startRegistration(session, email: email);
  }
}
