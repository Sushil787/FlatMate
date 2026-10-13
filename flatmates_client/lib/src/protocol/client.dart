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
import 'dart:async' as _ida;
import 'package:flatmates_client/src/protocol/away.dart' as _irs4lusq;
import 'package:flatmates_client/src/protocol/chore.dart' as _ipou5iyr;
import 'package:flatmates_client/src/protocol/event.dart' as _igj22k42;
import 'package:flatmates_client/src/protocol/flat.dart' as _iy3ygg88;
import 'package:flatmates_client/src/protocol/flat_change.dart' as _ibvlxgjf;
import 'package:flatmates_client/src/protocol/grocery_item.dart' as _iy9ydfy6;
import 'package:flatmates_client/src/protocol/mate.dart' as _iynws3fs;
import 'package:flatmates_client/src/protocol/mate_color.dart' as _ioi9k01f;
import 'package:flatmates_client/src/protocol/my_flat.dart' as _i9fyr2h8;
import 'package:flatmates_client/src/protocol/notice.dart' as _iynhw2wx;
import 'package:flatmates_client/src/protocol/notice_got_it.dart' as _i8dhtq4g;
import 'package:flatmates_client/src/protocol/swap_debt.dart' as _icdhy1dj;
import 'package:flatmates_client/src/protocol/turn.dart' as _i4k8bhoi;
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'protocol.dart' as _il2as5qe;
import 'package:flatmates_client/migrations/migration_registry.dart';

/// Email sign-in, for development only: the provider behind it is only set
/// up when the server runs in development mode (see server.dart).
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

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
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
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
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
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
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
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
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
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
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
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
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
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
  _ida.Future<void> finishPasswordReset({
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
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// Makes Google sign-in available to the app.
/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
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
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Marking yourself Away.
/// {@category Endpoint}
class EndpointAway extends _isc.EndpointRef {
  EndpointAway(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'away';

  /// Away periods in the Flat that haven't ended yet.
  _ida.Future<List<_irs4lusq.Away>> list() =>
      caller.callServerEndpoint<List<_irs4lusq.Away>>(
        'away',
        'list',
        {},
      );

  /// Marks the caller Away for the days [startDay]..[lastDay] (inclusive).
  /// Away can't start in the past, nor overlap one of the caller's Aways.
  _ida.Future<_irs4lusq.Away> create(
    DateTime startDay,
    DateTime lastDay,
  ) => caller.callServerEndpoint<_irs4lusq.Away>(
    'away',
    'create',
    {
      'startDay': startDay,
      'lastDay': lastDay,
    },
  );

  /// Cancels one of the caller's Away periods before it starts. Covers
  /// already arranged for it stay as they are.
  _ida.Future<void> cancel(_isc.UuidValue awayId) =>
      caller.callServerEndpoint<void>(
        'away',
        'cancel',
        {'awayId': awayId},
      );
}

/// Chores, their Rotations and Turns.
/// {@category Endpoint}
class EndpointChore extends _isc.EndpointRef {
  EndpointChore(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chore';

  _ida.Future<List<_ipou5iyr.Chore>> list() =>
      caller.callServerEndpoint<List<_ipou5iyr.Chore>>(
        'chore',
        'list',
        {},
      );

  /// Each Chore's latest Turn: the open one, or today's once it's Done.
  /// The app projects the planned Turns that follow from these.
  _ida.Future<List<_i4k8bhoi.Turn>> currentTurns() =>
      caller.callServerEndpoint<List<_i4k8bhoi.Turn>>(
        'chore',
        'currentTurns',
        {},
      );

  /// Real Turns on the days [from]..[to] (inclusive). Planned ones are
  /// projected by the app with the shared planner.
  _ida.Future<List<_i4k8bhoi.Turn>> turnsBetween(
    DateTime from,
    DateTime to,
  ) => caller.callServerEndpoint<List<_i4k8bhoi.Turn>>(
    'chore',
    'turnsBetween',
    {
      'from': from,
      'to': to,
    },
  );

  _ida.Future<_ipou5iyr.Chore> create(
    String name,
    Duration period,
    DateTime startDay,
    List<_isc.UuidValue> rotation,
  ) => caller.callServerEndpoint<_ipou5iyr.Chore>(
    'chore',
    'create',
    {
      'name': name,
      'period': period,
      'startDay': startDay,
      'rotation': rotation,
    },
  );

  /// Edits a Chore. The current Turn finishes as planned; changes apply
  /// from the next Turn.
  _ida.Future<_ipou5iyr.Chore> update(
    _isc.UuidValue choreId,
    String name,
    Duration period,
    List<_isc.UuidValue> rotation,
  ) => caller.callServerEndpoint<_ipou5iyr.Chore>(
    'chore',
    'update',
    {
      'choreId': choreId,
      'name': name,
      'period': period,
      'rotation': rotation,
    },
  );

  _ida.Future<void> archive(_isc.UuidValue choreId) =>
      caller.callServerEndpoint<void>(
        'chore',
        'archive',
        {'choreId': choreId},
      );

  _ida.Future<_i4k8bhoi.Turn> markDone(_isc.UuidValue turnId) =>
      caller.callServerEndpoint<_i4k8bhoi.Turn>(
        'chore',
        'markDone',
        {'turnId': turnId},
      );

  _ida.Future<_i4k8bhoi.Turn> undoDone(_isc.UuidValue turnId) =>
      caller.callServerEndpoint<_i4k8bhoi.Turn>(
        'chore',
        'undoDone',
        {'turnId': turnId},
      );

  /// Turns owed back under the Swap rule, across the Flat's Chores.
  _ida.Future<List<_icdhy1dj.SwapDebt>> swapDebts() =>
      caller.callServerEndpoint<List<_icdhy1dj.SwapDebt>>(
        'chore',
        'swapDebts',
        {},
      );
}

/// Events on the Flat's shared calendar.
/// {@category Endpoint}
class EndpointEvent extends _isc.EndpointRef {
  EndpointEvent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  /// Events overlapping [from]..[to].
  _ida.Future<List<_igj22k42.FlatEvent>> between(
    DateTime from,
    DateTime to,
  ) => caller.callServerEndpoint<List<_igj22k42.FlatEvent>>(
    'event',
    'between',
    {
      'from': from,
      'to': to,
    },
  );

  _ida.Future<_igj22k42.FlatEvent> create(
    String title,
    String? note,
    DateTime startsAt, {
    required bool allDay,
    DateTime? endsAt,
    required bool tellFlat,
  }) => caller.callServerEndpoint<_igj22k42.FlatEvent>(
    'event',
    'create',
    {
      'title': title,
      'note': note,
      'startsAt': startsAt,
      'allDay': allDay,
      'endsAt': endsAt,
      'tellFlat': tellFlat,
    },
  );

  /// Deletes an Event; only its creator or the Admin can.
  _ida.Future<void> delete(_isc.UuidValue eventId) =>
      caller.callServerEndpoint<void>(
        'event',
        'delete',
        {'eventId': eventId},
      );
}

/// Creating, joining and running a Flat.
/// {@category Endpoint}
class EndpointFlat extends _isc.EndpointRef {
  EndpointFlat(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'flat';

  /// The signed-in user's Flat, or null when they haven't joined one.
  _ida.Future<_i9fyr2h8.MyFlat?> mine() =>
      caller.callServerEndpoint<_i9fyr2h8.MyFlat?>(
        'flat',
        'mine',
        {},
      );

  /// Creates a Flat with the caller as its Admin.
  _ida.Future<_i9fyr2h8.MyFlat> create(
    String name,
    String displayName,
    String timezone,
  ) => caller.callServerEndpoint<_i9fyr2h8.MyFlat>(
    'flat',
    'create',
    {
      'name': name,
      'displayName': displayName,
      'timezone': timezone,
    },
  );

  /// Joins the Flat the Invite code belongs to, as a Mate.
  _ida.Future<_i9fyr2h8.MyFlat> join(
    String inviteCode,
    String displayName,
  ) => caller.callServerEndpoint<_i9fyr2h8.MyFlat>(
    'flat',
    'join',
    {
      'inviteCode': inviteCode,
      'displayName': displayName,
    },
  );

  /// Replaces the Invite code; the old one stops working.
  _ida.Future<String> regenerateInvite() => caller.callServerEndpoint<String>(
    'flat',
    'regenerateInvite',
    {},
  );

  _ida.Future<_iy3ygg88.Flat> rename(String name) =>
      caller.callServerEndpoint<_iy3ygg88.Flat>(
        'flat',
        'rename',
        {'name': name},
      );

  _ida.Future<_iynws3fs.Mate> setMyName(String displayName) =>
      caller.callServerEndpoint<_iynws3fs.Mate>(
        'flat',
        'setMyName',
        {'displayName': displayName},
      );

  _ida.Future<_iynws3fs.Mate> setMyColor(_ioi9k01f.MateColor color) =>
      caller.callServerEndpoint<_iynws3fs.Mate>(
        'flat',
        'setMyColor',
        {'color': color},
      );

  /// Sets which push notifications the caller gets. [matesNotDone] is
  /// optional because older apps don't send it.
  _ida.Future<_iynws3fs.Mate> setNotifications({
    required bool turnStarts,
    required bool reminder,
    bool? matesNotDone,
    required bool notice,
    required bool addedToRotation,
  }) => caller.callServerEndpoint<_iynws3fs.Mate>(
    'flat',
    'setNotifications',
    {
      'turnStarts': turnStarts,
      'reminder': reminder,
      'matesNotDone': matesNotDone,
      'notice': notice,
      'addedToRotation': addedToRotation,
    },
  );

  /// Sets the Flat-wide Away rule.
  _ida.Future<_iy3ygg88.Flat> setAwayRule(_ij0lpv6z.AwayRule rule) =>
      caller.callServerEndpoint<_iy3ygg88.Flat>(
        'flat',
        'setAwayRule',
        {'rule': rule},
      );

  /// Marks a newly joined Mate as seen by the Admin, adding them to the end
  /// of each of [choreIds]' Rotations. Does nothing if they were already
  /// welcomed (say, from the Admin's other phone).
  _ida.Future<void> welcomeMate(
    _isc.UuidValue mateId,
    List<_isc.UuidValue> choreIds,
  ) => caller.callServerEndpoint<void>(
    'flat',
    'welcomeMate',
    {
      'mateId': mateId,
      'choreIds': choreIds,
    },
  );

  /// Sets when the morning summary goes out, in minutes after local
  /// midnight. It has to come before the evening push.
  _ida.Future<_iy3ygg88.Flat> setMorningSummaryAt(int minutes) =>
      caller.callServerEndpoint<_iy3ygg88.Flat>(
        'flat',
        'setMorningSummaryAt',
        {'minutes': minutes},
      );

  /// Hands the Admin role to another Mate.
  _ida.Future<void> transferAdmin(_isc.UuidValue mateId) =>
      caller.callServerEndpoint<void>(
        'flat',
        'transferAdmin',
        {'mateId': mateId},
      );

  /// Removes a Mate from the Flat. The Admin can remove anyone; anyone can
  /// remove themselves. The Admin must hand over the role before leaving,
  /// unless they're the last Mate.
  _ida.Future<void> removeMate(_isc.UuidValue mateId) =>
      caller.callServerEndpoint<void>(
        'flat',
        'removeMate',
        {'mateId': mateId},
      );

  /// Leaves the caller's Flat.
  _ida.Future<void> leave() => caller.callServerEndpoint<void>(
    'flat',
    'leave',
    {},
  );

  /// Emits whenever something in the caller's Flat changes, so open apps
  /// can refresh.
  _ida.Stream<_ibvlxgjf.FlatChange> changes() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ibvlxgjf.FlatChange>,
        _ibvlxgjf.FlatChange
      >(
        'flat',
        'changes',
        {},
        {},
      );

  /// Registers this device for push notifications.
  _ida.Future<void> registerDevice(String token) =>
      caller.callServerEndpoint<void>(
        'flat',
        'registerDevice',
        {'token': token},
      );
}

/// The Flat's single shared grocery list. Changes update open apps live;
/// nothing here sends a push.
/// {@category Endpoint}
class EndpointGrocery extends _isc.EndpointRef {
  EndpointGrocery(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'grocery';

  /// Items still to buy, plus items bought in the last 24 hours.
  _ida.Future<List<_iy9ydfy6.GroceryItem>> list() =>
      caller.callServerEndpoint<List<_iy9ydfy6.GroceryItem>>(
        'grocery',
        'list',
        {},
      );

  _ida.Future<_iy9ydfy6.GroceryItem> add(
    String name,
    String? note,
  ) => caller.callServerEndpoint<_iy9ydfy6.GroceryItem>(
    'grocery',
    'add',
    {
      'name': name,
      'note': note,
    },
  );

  /// Ticks an item as bought by the caller, or unticks it.
  _ida.Future<_iy9ydfy6.GroceryItem> setBought(
    _isc.UuidValue itemId,
    bool bought,
  ) => caller.callServerEndpoint<_iy9ydfy6.GroceryItem>(
    'grocery',
    'setBought',
    {
      'itemId': itemId,
      'bought': bought,
    },
  );

  _ida.Future<void> delete(_isc.UuidValue itemId) =>
      caller.callServerEndpoint<void>(
        'grocery',
        'delete',
        {'itemId': itemId},
      );
}

/// The Flat's notice board.
/// {@category Endpoint}
class EndpointNotice extends _isc.EndpointRef {
  EndpointNotice(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notice';

  /// Pinned Notices first, then newest first.
  /// The Flat's Notices, pinned first, then newest first. Who said Got it
  /// comes from [gotIts].
  _ida.Future<List<_iynhw2wx.Notice>> list() =>
      caller.callServerEndpoint<List<_iynhw2wx.Notice>>(
        'notice',
        'list',
        {},
      );

  /// Every Got it on the Flat's Notices, oldest first.
  _ida.Future<List<_i8dhtq4g.NoticeGotIt>> gotIts() =>
      caller.callServerEndpoint<List<_i8dhtq4g.NoticeGotIt>>(
        'notice',
        'gotIts',
        {},
      );

  _ida.Future<_iynhw2wx.Notice> post(String text) =>
      caller.callServerEndpoint<_iynhw2wx.Notice>(
        'notice',
        'post',
        {'text': text},
      );

  _ida.Future<void> setPinned(
    _isc.UuidValue noticeId,
    bool pinned,
  ) => caller.callServerEndpoint<void>(
    'notice',
    'setPinned',
    {
      'noticeId': noticeId,
      'pinned': pinned,
    },
  );

  /// Says "Got it" on someone else's Notice. Saying it twice is fine.
  _ida.Future<void> gotIt(_isc.UuidValue noticeId) =>
      caller.callServerEndpoint<void>(
        'notice',
        'gotIt',
        {'noticeId': noticeId},
      );

  /// Deletes a Notice; only its author or the Admin can.
  _ida.Future<void> delete(_isc.UuidValue noticeId) =>
      caller.callServerEndpoint<void>(
        'notice',
        'delete',
        {'noticeId': noticeId},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
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
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
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
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };

  /// Creates a new client-side database session for the given path.
  ///
  /// The [path] is the file path to the SQLite database file. Since SQLite uses
  /// WAL mode, note that `[path]-shm` and `[path]-wal` files might also exist
  /// transiently for the database while the session is open.
  ///
  /// If [runMigrations] is true, pending migrations will be applied when
  /// opening the database. Be careful when setting this to false, as it might
  /// lead to inconsistencies between the models and the database.
  ///
  /// If [isDebugMode] is true, the database integrity will be verified after
  /// the migrations are applied to provide feedback of possible issues. On a
  /// Flutter application, this should be set to [kDebugMode].
  _ida.Future<_isd.ClientDatabaseSession> createSession(
    String path, {
    bool runMigrations = true,
    bool isDebugMode = false,
  }) async {
    return await _isd.ClientDatabaseSession.open(
      path,
      _il2as5qe.Protocol(),
      clientMigrations: MigrationRegistry.migrations,
      runMigrations: runMigrations,
      isDebugMode: isDebugMode,
    );
  }
}
