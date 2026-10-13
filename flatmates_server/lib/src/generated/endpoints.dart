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
import 'package:flatmates_server/src/generated/future_calls.dart' as _idh4zhdh;
import 'package:flatmates_server/src/generated/mate_color.dart' as _ilt6zfd6;
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/away_endpoint.dart' as _im6g9gk0;
import '../endpoints/chore_endpoint.dart' as _ikknmojt;
import '../endpoints/event_endpoint.dart' as _icw8lb6p;
import '../endpoints/flat_endpoint.dart' as _iho3d8m1;
import '../endpoints/grocery_endpoint.dart' as _igqssnqk;
import '../endpoints/notice_endpoint.dart' as _iaw8zfqb;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'googleIdp': _i71axiz0.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'away': _im6g9gk0.AwayEndpoint()
        ..initialize(
          server,
          'away',
          null,
        ),
      'chore': _ikknmojt.ChoreEndpoint()
        ..initialize(
          server,
          'chore',
          null,
        ),
      'event': _icw8lb6p.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'flat': _iho3d8m1.FlatEndpoint()
        ..initialize(
          server,
          'flat',
          null,
        ),
      'grocery': _igqssnqk.GroceryEndpoint()
        ..initialize(
          server,
          'grocery',
          null,
        ),
      'notice': _iaw8zfqb.NoticeEndpoint()
        ..initialize(
          server,
          'notice',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['away'] = _is.EndpointConnector(
      name: 'away',
      endpoint: endpoints['away']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['away'] as _im6g9gk0.AwayEndpoint).list(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'startDay': _is.ParameterDescription(
              name: 'startDay',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'lastDay': _is.ParameterDescription(
              name: 'lastDay',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['away'] as _im6g9gk0.AwayEndpoint).create(
                session,
                params['startDay'],
                params['lastDay'],
              ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'awayId': _is.ParameterDescription(
              name: 'awayId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['away'] as _im6g9gk0.AwayEndpoint).cancel(
                session,
                params['awayId'],
              ),
        ),
      },
    );
    connectors['chore'] = _is.EndpointConnector(
      name: 'chore',
      endpoint: endpoints['chore']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _ikknmojt.ChoreEndpoint).list(session),
        ),
        'currentTurns': _is.MethodConnector(
          name: 'currentTurns',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _ikknmojt.ChoreEndpoint)
                  .currentTurns(session),
        ),
        'turnsBetween': _is.MethodConnector(
          name: 'turnsBetween',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _ikknmojt.ChoreEndpoint).turnsBetween(
                    session,
                    params['from'],
                    params['to'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'period': _is.ParameterDescription(
              name: 'period',
              type: _is.getType<Duration>(),
              nullable: false,
            ),
            'startDay': _is.ParameterDescription(
              name: 'startDay',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'rotation': _is.ParameterDescription(
              name: 'rotation',
              type: _is.getType<List<_is.UuidValue>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _ikknmojt.ChoreEndpoint).create(
                session,
                params['name'],
                params['period'],
                params['startDay'],
                params['rotation'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'choreId': _is.ParameterDescription(
              name: 'choreId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'period': _is.ParameterDescription(
              name: 'period',
              type: _is.getType<Duration>(),
              nullable: false,
            ),
            'rotation': _is.ParameterDescription(
              name: 'rotation',
              type: _is.getType<List<_is.UuidValue>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _ikknmojt.ChoreEndpoint).update(
                session,
                params['choreId'],
                params['name'],
                params['period'],
                params['rotation'],
              ),
        ),
        'archive': _is.MethodConnector(
          name: 'archive',
          params: {
            'choreId': _is.ParameterDescription(
              name: 'choreId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _ikknmojt.ChoreEndpoint).archive(
                    session,
                    params['choreId'],
                  ),
        ),
        'markDone': _is.MethodConnector(
          name: 'markDone',
          params: {
            'turnId': _is.ParameterDescription(
              name: 'turnId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _ikknmojt.ChoreEndpoint).markDone(
                    session,
                    params['turnId'],
                  ),
        ),
        'undoDone': _is.MethodConnector(
          name: 'undoDone',
          params: {
            'turnId': _is.ParameterDescription(
              name: 'turnId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _ikknmojt.ChoreEndpoint).undoDone(
                    session,
                    params['turnId'],
                  ),
        ),
        'swapDebts': _is.MethodConnector(
          name: 'swapDebts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _ikknmojt.ChoreEndpoint)
                  .swapDebts(session),
        ),
      },
    );
    connectors['event'] = _is.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'between': _is.MethodConnector(
          name: 'between',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _icw8lb6p.EventEndpoint).between(
                    session,
                    params['from'],
                    params['to'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'startsAt': _is.ParameterDescription(
              name: 'startsAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'allDay': _is.ParameterDescription(
              name: 'allDay',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'endsAt': _is.ParameterDescription(
              name: 'endsAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'tellFlat': _is.ParameterDescription(
              name: 'tellFlat',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint).create(
                session,
                params['title'],
                params['note'],
                params['startsAt'],
                allDay: params['allDay'],
                endsAt: params['endsAt'],
                tellFlat: params['tellFlat'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'eventId': _is.ParameterDescription(
              name: 'eventId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _icw8lb6p.EventEndpoint).delete(
                session,
                params['eventId'],
              ),
        ),
      },
    );
    connectors['flat'] = _is.EndpointConnector(
      name: 'flat',
      endpoint: endpoints['flat']!,
      methodConnectors: {
        'mine': _is.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).mine(session),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'timezone': _is.ParameterDescription(
              name: 'timezone',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint).create(
                session,
                params['name'],
                params['displayName'],
                params['timezone'],
              ),
        ),
        'join': _is.MethodConnector(
          name: 'join',
          params: {
            'inviteCode': _is.ParameterDescription(
              name: 'inviteCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint).join(
                session,
                params['inviteCode'],
                params['displayName'],
              ),
        ),
        'regenerateInvite': _is.MethodConnector(
          name: 'regenerateInvite',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint)
                  .regenerateInvite(session),
        ),
        'rename': _is.MethodConnector(
          name: 'rename',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint).rename(
                session,
                params['name'],
              ),
        ),
        'setMyName': _is.MethodConnector(
          name: 'setMyName',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).setMyName(
                    session,
                    params['displayName'],
                  ),
        ),
        'setMyColor': _is.MethodConnector(
          name: 'setMyColor',
          params: {
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<_ilt6zfd6.MateColor>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).setMyColor(
                    session,
                    params['color'],
                  ),
        ),
        'setNotifications': _is.MethodConnector(
          name: 'setNotifications',
          params: {
            'turnStarts': _is.ParameterDescription(
              name: 'turnStarts',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reminder': _is.ParameterDescription(
              name: 'reminder',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'matesNotDone': _is.ParameterDescription(
              name: 'matesNotDone',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'notice': _is.ParameterDescription(
              name: 'notice',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'addedToRotation': _is.ParameterDescription(
              name: 'addedToRotation',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint)
                  .setNotifications(
                    session,
                    turnStarts: params['turnStarts'],
                    reminder: params['reminder'],
                    matesNotDone: params['matesNotDone'],
                    notice: params['notice'],
                    addedToRotation: params['addedToRotation'],
                  ),
        ),
        'setAwayRule': _is.MethodConnector(
          name: 'setAwayRule',
          params: {
            'rule': _is.ParameterDescription(
              name: 'rule',
              type: _is.getType<_ij0lpv6z.AwayRule>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).setAwayRule(
                    session,
                    params['rule'],
                  ),
        ),
        'welcomeMate': _is.MethodConnector(
          name: 'welcomeMate',
          params: {
            'mateId': _is.ParameterDescription(
              name: 'mateId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'choreIds': _is.ParameterDescription(
              name: 'choreIds',
              type: _is.getType<List<_is.UuidValue>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).welcomeMate(
                    session,
                    params['mateId'],
                    params['choreIds'],
                  ),
        ),
        'setMorningSummaryAt': _is.MethodConnector(
          name: 'setMorningSummaryAt',
          params: {
            'minutes': _is.ParameterDescription(
              name: 'minutes',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _iho3d8m1.FlatEndpoint)
                  .setMorningSummaryAt(
                    session,
                    params['minutes'],
                  ),
        ),
        'transferAdmin': _is.MethodConnector(
          name: 'transferAdmin',
          params: {
            'mateId': _is.ParameterDescription(
              name: 'mateId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).transferAdmin(
                    session,
                    params['mateId'],
                  ),
        ),
        'removeMate': _is.MethodConnector(
          name: 'removeMate',
          params: {
            'mateId': _is.ParameterDescription(
              name: 'mateId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).removeMate(
                    session,
                    params['mateId'],
                  ),
        ),
        'leave': _is.MethodConnector(
          name: 'leave',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).leave(session),
        ),
        'registerDevice': _is.MethodConnector(
          name: 'registerDevice',
          params: {
            'token': _is.ParameterDescription(
              name: 'token',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['flat'] as _iho3d8m1.FlatEndpoint).registerDevice(
                    session,
                    params['token'],
                  ),
        ),
        'changes': _is.MethodStreamConnector(
          name: 'changes',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['flat'] as _iho3d8m1.FlatEndpoint).changes(
                session,
              ),
        ),
      },
    );
    connectors['grocery'] = _is.EndpointConnector(
      name: 'grocery',
      endpoint: endpoints['grocery']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['grocery'] as _igqssnqk.GroceryEndpoint)
                  .list(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grocery'] as _igqssnqk.GroceryEndpoint).add(
                    session,
                    params['name'],
                    params['note'],
                  ),
        ),
        'setBought': _is.MethodConnector(
          name: 'setBought',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'bought': _is.ParameterDescription(
              name: 'bought',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grocery'] as _igqssnqk.GroceryEndpoint).setBought(
                    session,
                    params['itemId'],
                    params['bought'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grocery'] as _igqssnqk.GroceryEndpoint).delete(
                    session,
                    params['itemId'],
                  ),
        ),
      },
    );
    connectors['notice'] = _is.EndpointConnector(
      name: 'notice',
      endpoint: endpoints['notice']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint).list(
                session,
              ),
        ),
        'gotIts': _is.MethodConnector(
          name: 'gotIts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint)
                  .gotIts(session),
        ),
        'post': _is.MethodConnector(
          name: 'post',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint).post(
                session,
                params['text'],
              ),
        ),
        'setPinned': _is.MethodConnector(
          name: 'setPinned',
          params: {
            'noticeId': _is.ParameterDescription(
              name: 'noticeId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'pinned': _is.ParameterDescription(
              name: 'pinned',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint).setPinned(
                    session,
                    params['noticeId'],
                    params['pinned'],
                  ),
        ),
        'gotIt': _is.MethodConnector(
          name: 'gotIt',
          params: {
            'noticeId': _is.ParameterDescription(
              name: 'noticeId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint).gotIt(
                    session,
                    params['noticeId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'noticeId': _is.ParameterDescription(
              name: 'noticeId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notice'] as _iaw8zfqb.NoticeEndpoint).delete(
                    session,
                    params['noticeId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _idh4zhdh.FutureCalls();
  }
}
