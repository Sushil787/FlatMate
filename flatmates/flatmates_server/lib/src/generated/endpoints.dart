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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/google_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/away_endpoint.dart' as _i4;
import '../endpoints/chore_endpoint.dart' as _i5;
import '../endpoints/event_endpoint.dart' as _i6;
import '../endpoints/flat_endpoint.dart' as _i7;
import '../endpoints/grocery_endpoint.dart' as _i8;
import '../endpoints/notice_endpoint.dart' as _i9;
import 'package:flatmates_server/src/generated/away_rule.dart' as _i10;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i11;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i12;
import 'package:flatmates_server/src/generated/future_calls.dart' as _i13;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'googleIdp': _i2.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'away': _i4.AwayEndpoint()
        ..initialize(
          server,
          'away',
          null,
        ),
      'chore': _i5.ChoreEndpoint()
        ..initialize(
          server,
          'chore',
          null,
        ),
      'event': _i6.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'flat': _i7.FlatEndpoint()
        ..initialize(
          server,
          'flat',
          null,
        ),
      'grocery': _i8.GroceryEndpoint()
        ..initialize(
          server,
          'grocery',
          null,
        ),
      'notice': _i9.NoticeEndpoint()
        ..initialize(
          server,
          'notice',
          null,
        ),
    };
    connectors['googleIdp'] = _i1.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'idToken': _i1.ParameterDescription(
              name: 'idToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'accessToken': _i1.ParameterDescription(
              name: 'accessToken',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i2.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i2.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['away'] = _i1.EndpointConnector(
      name: 'away',
      endpoint: endpoints['away']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['away'] as _i4.AwayEndpoint).list(session),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'startsAt': _i1.ParameterDescription(
              name: 'startsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endsAt': _i1.ParameterDescription(
              name: 'endsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['away'] as _i4.AwayEndpoint).create(
                session,
                params['startsAt'],
                params['endsAt'],
              ),
        ),
        'cancel': _i1.MethodConnector(
          name: 'cancel',
          params: {
            'awayId': _i1.ParameterDescription(
              name: 'awayId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['away'] as _i4.AwayEndpoint).cancel(
                session,
                params['awayId'],
              ),
        ),
      },
    );
    connectors['chore'] = _i1.EndpointConnector(
      name: 'chore',
      endpoint: endpoints['chore']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chore'] as _i5.ChoreEndpoint).list(session),
        ),
        'activeTurns': _i1.MethodConnector(
          name: 'activeTurns',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).activeTurns(
                session,
              ),
        ),
        'turnsBetween': _i1.MethodConnector(
          name: 'turnsBetween',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).turnsBetween(
                session,
                params['from'],
                params['to'],
              ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<Duration>(),
              nullable: false,
            ),
            'startsAt': _i1.ParameterDescription(
              name: 'startsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'rotation': _i1.ParameterDescription(
              name: 'rotation',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).create(
                session,
                params['name'],
                params['period'],
                params['startsAt'],
                params['rotation'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'choreId': _i1.ParameterDescription(
              name: 'choreId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<Duration>(),
              nullable: false,
            ),
            'rotation': _i1.ParameterDescription(
              name: 'rotation',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).update(
                session,
                params['choreId'],
                params['name'],
                params['period'],
                params['rotation'],
              ),
        ),
        'archive': _i1.MethodConnector(
          name: 'archive',
          params: {
            'choreId': _i1.ParameterDescription(
              name: 'choreId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).archive(
                session,
                params['choreId'],
              ),
        ),
        'markDone': _i1.MethodConnector(
          name: 'markDone',
          params: {
            'turnId': _i1.ParameterDescription(
              name: 'turnId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chore'] as _i5.ChoreEndpoint).markDone(
                session,
                params['turnId'],
              ),
        ),
      },
    );
    connectors['event'] = _i1.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'between': _i1.MethodConnector(
          name: 'between',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i6.EventEndpoint).between(
                session,
                params['from'],
                params['to'],
              ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'startsAt': _i1.ParameterDescription(
              name: 'startsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endsAt': _i1.ParameterDescription(
              name: 'endsAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i6.EventEndpoint).create(
                session,
                params['title'],
                params['note'],
                params['startsAt'],
                params['endsAt'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i6.EventEndpoint).delete(
                session,
                params['eventId'],
              ),
        ),
      },
    );
    connectors['flat'] = _i1.EndpointConnector(
      name: 'flat',
      endpoint: endpoints['flat']!,
      methodConnectors: {
        'mine': _i1.MethodConnector(
          name: 'mine',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).mine(session),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'timezone': _i1.ParameterDescription(
              name: 'timezone',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).create(
                session,
                params['name'],
                params['displayName'],
                params['timezone'],
              ),
        ),
        'join': _i1.MethodConnector(
          name: 'join',
          params: {
            'inviteCode': _i1.ParameterDescription(
              name: 'inviteCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).join(
                session,
                params['inviteCode'],
                params['displayName'],
              ),
        ),
        'regenerateInvite': _i1.MethodConnector(
          name: 'regenerateInvite',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint)
                  .regenerateInvite(session),
        ),
        'setAwayRule': _i1.MethodConnector(
          name: 'setAwayRule',
          params: {
            'rule': _i1.ParameterDescription(
              name: 'rule',
              type: _i1.getType<_i10.AwayRule>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).setAwayRule(
                session,
                params['rule'],
              ),
        ),
        'transferAdmin': _i1.MethodConnector(
          name: 'transferAdmin',
          params: {
            'mateId': _i1.ParameterDescription(
              name: 'mateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).transferAdmin(
                session,
                params['mateId'],
              ),
        ),
        'removeMate': _i1.MethodConnector(
          name: 'removeMate',
          params: {
            'mateId': _i1.ParameterDescription(
              name: 'mateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).removeMate(
                session,
                params['mateId'],
              ),
        ),
        'leave': _i1.MethodConnector(
          name: 'leave',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).leave(session),
        ),
        'registerDevice': _i1.MethodConnector(
          name: 'registerDevice',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['flat'] as _i7.FlatEndpoint).registerDevice(
                session,
                params['token'],
              ),
        ),
        'changes': _i1.MethodStreamConnector(
          name: 'changes',
          params: {},
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['flat'] as _i7.FlatEndpoint).changes(session),
        ),
      },
    );
    connectors['grocery'] = _i1.EndpointConnector(
      name: 'grocery',
      endpoint: endpoints['grocery']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grocery'] as _i8.GroceryEndpoint).list(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['grocery'] as _i8.GroceryEndpoint).add(
                session,
                params['name'],
                params['note'],
              ),
        ),
        'setBought': _i1.MethodConnector(
          name: 'setBought',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'bought': _i1.ParameterDescription(
              name: 'bought',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['grocery'] as _i8.GroceryEndpoint).setBought(
                    session,
                    params['itemId'],
                    params['bought'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'itemId': _i1.ParameterDescription(
              name: 'itemId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['grocery'] as _i8.GroceryEndpoint).delete(
                session,
                params['itemId'],
              ),
        ),
      },
    );
    connectors['notice'] = _i1.EndpointConnector(
      name: 'notice',
      endpoint: endpoints['notice']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notice'] as _i9.NoticeEndpoint).list(session),
        ),
        'post': _i1.MethodConnector(
          name: 'post',
          params: {
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _i9.NoticeEndpoint).post(
                session,
                params['text'],
              ),
        ),
        'setPinned': _i1.MethodConnector(
          name: 'setPinned',
          params: {
            'noticeId': _i1.ParameterDescription(
              name: 'noticeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pinned': _i1.ParameterDescription(
              name: 'pinned',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _i9.NoticeEndpoint).setPinned(
                session,
                params['noticeId'],
                params['pinned'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'noticeId': _i1.ParameterDescription(
              name: 'noticeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['notice'] as _i9.NoticeEndpoint).delete(
                session,
                params['noticeId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i13.FutureCalls();
  }
}
