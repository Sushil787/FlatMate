/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:flatmates_client/src/protocol/away.dart' as _i5;
import 'package:flatmates_client/src/protocol/chore.dart' as _i6;
import 'package:flatmates_client/src/protocol/turn.dart' as _i7;
import 'package:flatmates_client/src/protocol/event.dart' as _i8;
import 'package:flatmates_client/src/protocol/my_flat.dart' as _i9;
import 'package:flatmates_client/src/protocol/flat.dart' as _i10;
import 'package:flatmates_client/src/protocol/away_rule.dart' as _i11;
import 'package:flatmates_client/src/protocol/flat_change.dart' as _i12;
import 'package:flatmates_client/src/protocol/grocery_item.dart' as _i13;
import 'package:flatmates_client/src/protocol/notice.dart' as _i14;
import 'protocol.dart' as _i15;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// Makes Google sign-in available to the app.
/// {@category Endpoint}
class EndpointGoogleIdp extends _i1.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Marking yourself Away.
/// {@category Endpoint}
class EndpointAway extends _i2.EndpointRef {
  EndpointAway(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'away';

  /// Away periods in the Flat that haven't ended yet.
  _i3.Future<List<_i5.Away>> list() =>
      caller.callServerEndpoint<List<_i5.Away>>(
        'away',
        'list',
        {},
      );

  /// Marks the caller Away. Away can't start in the past.
  _i3.Future<_i5.Away> create(
    DateTime startsAt,
    DateTime endsAt,
  ) => caller.callServerEndpoint<_i5.Away>(
    'away',
    'create',
    {
      'startsAt': startsAt,
      'endsAt': endsAt,
    },
  );

  /// Cancels one of the caller's Away periods before it starts. Covers
  /// already arranged for it stay as they are.
  _i3.Future<void> cancel(int awayId) => caller.callServerEndpoint<void>(
    'away',
    'cancel',
    {'awayId': awayId},
  );
}

/// Chores, their Rotations and Turns.
/// {@category Endpoint}
class EndpointChore extends _i2.EndpointRef {
  EndpointChore(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chore';

  _i3.Future<List<_i6.Chore>> list() =>
      caller.callServerEndpoint<List<_i6.Chore>>(
        'chore',
        'list',
        {},
      );

  /// Every open Turn in the Flat: in progress, or waiting to start.
  _i3.Future<List<_i7.Turn>> activeTurns() =>
      caller.callServerEndpoint<List<_i7.Turn>>(
        'chore',
        'activeTurns',
        {},
      );

  /// Turns overlapping [from, to): real ones, plus projected future ones
  /// (which have no id).
  _i3.Future<List<_i7.Turn>> turnsBetween(
    DateTime from,
    DateTime to,
  ) => caller.callServerEndpoint<List<_i7.Turn>>(
    'chore',
    'turnsBetween',
    {
      'from': from,
      'to': to,
    },
  );

  _i3.Future<_i6.Chore> create(
    String name,
    Duration period,
    DateTime startsAt,
    List<int> rotation,
  ) => caller.callServerEndpoint<_i6.Chore>(
    'chore',
    'create',
    {
      'name': name,
      'period': period,
      'startsAt': startsAt,
      'rotation': rotation,
    },
  );

  /// Edits a Chore. The current Turn finishes as planned; changes apply
  /// from the next Turn.
  _i3.Future<_i6.Chore> update(
    int choreId,
    String name,
    Duration period,
    List<int> rotation,
  ) => caller.callServerEndpoint<_i6.Chore>(
    'chore',
    'update',
    {
      'choreId': choreId,
      'name': name,
      'period': period,
      'rotation': rotation,
    },
  );

  _i3.Future<void> archive(int choreId) => caller.callServerEndpoint<void>(
    'chore',
    'archive',
    {'choreId': choreId},
  );

  _i3.Future<_i7.Turn> markDone(int turnId) =>
      caller.callServerEndpoint<_i7.Turn>(
        'chore',
        'markDone',
        {'turnId': turnId},
      );
}

/// Events on the Flat's shared calendar.
/// {@category Endpoint}
class EndpointEvent extends _i2.EndpointRef {
  EndpointEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  _i3.Future<List<_i8.FlatEvent>> between(
    DateTime from,
    DateTime to,
  ) => caller.callServerEndpoint<List<_i8.FlatEvent>>(
    'event',
    'between',
    {
      'from': from,
      'to': to,
    },
  );

  _i3.Future<_i8.FlatEvent> create(
    String title,
    String? note,
    DateTime startsAt,
    DateTime? endsAt,
  ) => caller.callServerEndpoint<_i8.FlatEvent>(
    'event',
    'create',
    {
      'title': title,
      'note': note,
      'startsAt': startsAt,
      'endsAt': endsAt,
    },
  );

  /// Deletes an Event; only its creator or the Admin can.
  _i3.Future<void> delete(int eventId) => caller.callServerEndpoint<void>(
    'event',
    'delete',
    {'eventId': eventId},
  );
}

/// Creating, joining and running a Flat.
/// {@category Endpoint}
class EndpointFlat extends _i2.EndpointRef {
  EndpointFlat(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'flat';

  /// The signed-in user's Flat, or null when they haven't joined one.
  _i3.Future<_i9.MyFlat?> mine() => caller.callServerEndpoint<_i9.MyFlat?>(
    'flat',
    'mine',
    {},
  );

  /// Creates a Flat with the caller as its Admin.
  _i3.Future<_i9.MyFlat> create(
    String name,
    String displayName,
    String timezone,
  ) => caller.callServerEndpoint<_i9.MyFlat>(
    'flat',
    'create',
    {
      'name': name,
      'displayName': displayName,
      'timezone': timezone,
    },
  );

  /// Joins the Flat the Invite code belongs to, as a Mate.
  _i3.Future<_i9.MyFlat> join(
    String inviteCode,
    String displayName,
  ) => caller.callServerEndpoint<_i9.MyFlat>(
    'flat',
    'join',
    {
      'inviteCode': inviteCode,
      'displayName': displayName,
    },
  );

  /// Replaces the Invite code; the old one stops working.
  _i3.Future<String> regenerateInvite() => caller.callServerEndpoint<String>(
    'flat',
    'regenerateInvite',
    {},
  );

  /// Sets the Flat-wide Away rule.
  _i3.Future<_i10.Flat> setAwayRule(_i11.AwayRule rule) =>
      caller.callServerEndpoint<_i10.Flat>(
        'flat',
        'setAwayRule',
        {'rule': rule},
      );

  /// Hands the Admin role to another Mate.
  _i3.Future<void> transferAdmin(int mateId) => caller.callServerEndpoint<void>(
    'flat',
    'transferAdmin',
    {'mateId': mateId},
  );

  /// Removes a Mate from the Flat. The Admin can remove anyone; anyone can
  /// remove themselves. The Admin must hand over the role before leaving,
  /// unless they're the last Mate.
  _i3.Future<void> removeMate(int mateId) => caller.callServerEndpoint<void>(
    'flat',
    'removeMate',
    {'mateId': mateId},
  );

  /// Leaves the caller's Flat.
  _i3.Future<void> leave() => caller.callServerEndpoint<void>(
    'flat',
    'leave',
    {},
  );

  /// Emits whenever something in the caller's Flat changes, so open apps
  /// can refresh.
  _i3.Stream<_i12.FlatChange> changes() =>
      caller.callStreamingServerEndpoint<
        _i3.Stream<_i12.FlatChange>,
        _i12.FlatChange
      >(
        'flat',
        'changes',
        {},
        {},
      );

  /// Registers this device for push notifications.
  _i3.Future<void> registerDevice(String token) =>
      caller.callServerEndpoint<void>(
        'flat',
        'registerDevice',
        {'token': token},
      );
}

/// The Flat's single shared grocery list. Changes update open apps live;
/// nothing here sends a push.
/// {@category Endpoint}
class EndpointGrocery extends _i2.EndpointRef {
  EndpointGrocery(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'grocery';

  /// Items still to buy, plus items bought in the last 24 hours.
  _i3.Future<List<_i13.GroceryItem>> list() =>
      caller.callServerEndpoint<List<_i13.GroceryItem>>(
        'grocery',
        'list',
        {},
      );

  _i3.Future<_i13.GroceryItem> add(
    String name,
    String? note,
  ) => caller.callServerEndpoint<_i13.GroceryItem>(
    'grocery',
    'add',
    {
      'name': name,
      'note': note,
    },
  );

  /// Ticks an item as bought by the caller, or unticks it.
  _i3.Future<_i13.GroceryItem> setBought(
    int itemId,
    bool bought,
  ) => caller.callServerEndpoint<_i13.GroceryItem>(
    'grocery',
    'setBought',
    {
      'itemId': itemId,
      'bought': bought,
    },
  );

  _i3.Future<void> delete(int itemId) => caller.callServerEndpoint<void>(
    'grocery',
    'delete',
    {'itemId': itemId},
  );
}

/// The Flat's notice board.
/// {@category Endpoint}
class EndpointNotice extends _i2.EndpointRef {
  EndpointNotice(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notice';

  /// Pinned Notices first, then newest first.
  _i3.Future<List<_i14.Notice>> list() =>
      caller.callServerEndpoint<List<_i14.Notice>>(
        'notice',
        'list',
        {},
      );

  _i3.Future<_i14.Notice> post(String text) =>
      caller.callServerEndpoint<_i14.Notice>(
        'notice',
        'post',
        {'text': text},
      );

  _i3.Future<void> setPinned(
    int noticeId,
    bool pinned,
  ) => caller.callServerEndpoint<void>(
    'notice',
    'setPinned',
    {
      'noticeId': noticeId,
      'pinned': pinned,
    },
  );

  /// Deletes a Notice; only its author or the Admin can.
  _i3.Future<void> delete(int noticeId) => caller.callServerEndpoint<void>(
    'notice',
    'delete',
    {'noticeId': noticeId},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i15.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    googleIdp = EndpointGoogleIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    away = EndpointAway(this);
    chore = EndpointChore(this);
    event = EndpointEvent(this);
    flat = EndpointFlat(this);
    grocery = EndpointGrocery(this);
    notice = EndpointNotice(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAway away;

  late final EndpointChore chore;

  late final EndpointEvent event;

  late final EndpointFlat flat;

  late final EndpointGrocery grocery;

  late final EndpointNotice notice;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'googleIdp': googleIdp,
    'jwtRefresh': jwtRefresh,
    'away': away,
    'chore': chore,
    'event': event,
    'flat': flat,
    'grocery': grocery,
    'notice': notice,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
