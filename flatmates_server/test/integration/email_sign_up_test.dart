import 'package:flatmates_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart' show AuthUser;
import 'package:serverpod_auth_idp_server/providers/google.dart'
    show GoogleAccount;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given someone who signs in with Google', (
    sessionBuilder,
    endpoints,
  ) {
    setUp(() async {
      final session = sessionBuilder.build();
      final user = await AuthUser.db.insertRow(
        session,
        AuthUser(scopeNames: {}),
      );
      await GoogleAccount.db.insertRow(
        session,
        GoogleAccount(
          authUserId: user.id!,
          email: 'judge@gmail.com',
          userIdentifier: 'google-judge',
        ),
      );
    });

    test('signing up with email at the same address is refused', () async {
      await expectLater(
        endpoints.emailIdp.startRegistration(
          sessionBuilder,
          email: ' Judge@Gmail.com ',
        ),
        throwsA(
          isA<FlatmatesException>().having(
            (e) => e.message,
            'message',
            contains('Continue with Google'),
          ),
        ),
      );
    });
  });
}
