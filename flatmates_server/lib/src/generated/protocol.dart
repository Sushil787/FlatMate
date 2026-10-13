/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flatmates_server/src/generated/away.dart' as _icx3t1f1;
import 'package:flatmates_server/src/generated/chore.dart' as _ij1nfwf4;
import 'package:flatmates_server/src/generated/event.dart' as _i7uqo6xr;
import 'package:flatmates_server/src/generated/grocery_item.dart' as _itw5ie4o;
import 'package:flatmates_server/src/generated/notice.dart' as _ikw41nt5;
import 'package:flatmates_server/src/generated/notice_got_it.dart' as _i2ir1nq4;
import 'package:flatmates_server/src/generated/swap_debt.dart' as _implyx9l;
import 'package:flatmates_server/src/generated/turn.dart' as _ij03rvz2;
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'away.dart' as _injc6hlm;
import 'away_effect.dart' as _i3z62lxk;
import 'cached_read.dart' as _i78xomdp;
import 'chore.dart' as _imnq0nzy;
import 'device_token.dart' as _ilggw95u;
import 'event.dart' as _iu57571s;
import 'flat.dart' as _io7qq7p8;
import 'flat_change.dart' as _izxtvxcg;
import 'flat_change_kind.dart' as _iyrv7gay;
import 'flatmates_exception.dart' as _id68d40p;
import 'future_calls_generated_models/turn_calls_ended_model.dart' as _ijoy4xkx;
import 'future_calls_generated_models/turn_calls_reminder_model.dart'
    as _irgon17h;
import 'future_calls_generated_models/turn_calls_started_model.dart'
    as _icfcmm02;
import 'grocery_item.dart' as _idc9is2h;
import 'mate.dart' as _itahn62i;
import 'mate_color.dart' as _ieys87jp;
import 'my_flat.dart' as _i9fqeegk;
import 'notice.dart' as _i8bpb14y;
import 'notice_got_it.dart' as _ia5ed1vr;
import 'swap_debt.dart' as _ijdri2o7;
import 'turn.dart' as _i0nsa51h;
import 'turn_status.dart' as _i5yk6qf9;
export 'away.dart';
export 'away_effect.dart';
export 'cached_read.dart';
export 'chore.dart';
export 'device_token.dart';
export 'event.dart';
export 'flat.dart';
export 'flat_change.dart';
export 'flat_change_kind.dart';
export 'flatmates_exception.dart';
export 'grocery_item.dart';
export 'mate.dart';
export 'mate_color.dart';
export 'my_flat.dart';
export 'notice.dart';
export 'notice_got_it.dart';
export 'swap_debt.dart';
export 'turn.dart';
export 'turn_status.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'away',
      dartName: 'Away',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'mateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'startDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'away_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'chore',
      dartName: 'Chore',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'period',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'Duration',
        ),
        _isp.ColumnDefinition(
          name: 'startDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'rotation',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<UuidValue>',
        ),
        _isp.ColumnDefinition(
          name: 'rotationIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'archived',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'chore_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'device_token',
      dartName: 'DeviceToken',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'token',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'device_token_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'device_token_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'flat',
      dartName: 'Flat',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'timezone',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'adminMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'inviteExpiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'awayRule',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'flatmates_shared:AwayRule',
        ),
        _isp.ColumnDefinition(
          name: 'morningSummaryAt',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '480',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'flat_invite_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'flat_event',
      dartName: 'FlatEvent',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'mateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'note',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'startsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'endsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'allDay',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'flat_event_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startsAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'grocery_item',
      dartName: 'GroceryItem',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'note',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'addedByMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'boughtByMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'boughtAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'grocery_item_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'mate',
      dartName: 'Mate',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'leftAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'color',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MateColor',
          columnDefault: '\'tomato\'',
        ),
        _isp.ColumnDefinition(
          name: 'notifyTurnStarts',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'notifyReminder',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'notifyMatesNotDone',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'notifyNotice',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'notifyAddedToRotation',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'welcomed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'mate_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'mate_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'notice',
      dartName: 'Notice',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'mateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'pinned',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'notice_flat_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'notice_got_it',
      dartName: 'NoticeGotIt',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'noticeId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'mateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'notice_got_it_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'noticeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'mateId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'swap_debt',
      dartName: 'SwapDebt',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'choreId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'debtorMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'creditorMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'swap_debt_chore_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'choreId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'turn',
      dartName: 'Turn',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isp.ColumnDefinition(
          name: 'flatId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'choreId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'mateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'coveringForMateId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'day',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'lastDay',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TurnStatus',
        ),
        _isp.ColumnDefinition(
          name: 'doneAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'turn_chore_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'choreId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'turn_flat_day_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'day',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._ij0lpv6z.Protocol() is _is.DatabaseSerializationManager
        ? (_ij0lpv6z.Protocol() as _is.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _injc6hlm.Away) {
      return _injc6hlm.Away.fromJson(data) as T;
    }
    if (t == _i3z62lxk.AwayEffect) {
      return _i3z62lxk.AwayEffect.fromJson(data) as T;
    }
    if (t == _i78xomdp.CachedRead) {
      return _i78xomdp.CachedRead.fromJson(data) as T;
    }
    if (t == _imnq0nzy.Chore) {
      return _imnq0nzy.Chore.fromJson(data) as T;
    }
    if (t == _ilggw95u.DeviceToken) {
      return _ilggw95u.DeviceToken.fromJson(data) as T;
    }
    if (t == _iu57571s.FlatEvent) {
      return _iu57571s.FlatEvent.fromJson(data) as T;
    }
    if (t == _io7qq7p8.Flat) {
      return _io7qq7p8.Flat.fromJson(data) as T;
    }
    if (t == _izxtvxcg.FlatChange) {
      return _izxtvxcg.FlatChange.fromJson(data) as T;
    }
    if (t == _iyrv7gay.FlatChangeKind) {
      return _iyrv7gay.FlatChangeKind.fromJson(data) as T;
    }
    if (t == _id68d40p.FlatmatesException) {
      return _id68d40p.FlatmatesException.fromJson(data) as T;
    }
    if (t == _ijoy4xkx.TurnCallsEndedModel) {
      return _ijoy4xkx.TurnCallsEndedModel.fromJson(data) as T;
    }
    if (t == _irgon17h.TurnCallsReminderModel) {
      return _irgon17h.TurnCallsReminderModel.fromJson(data) as T;
    }
    if (t == _icfcmm02.TurnCallsStartedModel) {
      return _icfcmm02.TurnCallsStartedModel.fromJson(data) as T;
    }
    if (t == _idc9is2h.GroceryItem) {
      return _idc9is2h.GroceryItem.fromJson(data) as T;
    }
    if (t == _itahn62i.Mate) {
      return _itahn62i.Mate.fromJson(data) as T;
    }
    if (t == _ieys87jp.MateColor) {
      return _ieys87jp.MateColor.fromJson(data) as T;
    }
    if (t == _i9fqeegk.MyFlat) {
      return _i9fqeegk.MyFlat.fromJson(data) as T;
    }
    if (t == _i8bpb14y.Notice) {
      return _i8bpb14y.Notice.fromJson(data) as T;
    }
    if (t == _ia5ed1vr.NoticeGotIt) {
      return _ia5ed1vr.NoticeGotIt.fromJson(data) as T;
    }
    if (t == _ijdri2o7.SwapDebt) {
      return _ijdri2o7.SwapDebt.fromJson(data) as T;
    }
    if (t == _i0nsa51h.Turn) {
      return _i0nsa51h.Turn.fromJson(data) as T;
    }
    if (t == _i5yk6qf9.TurnStatus) {
      return _i5yk6qf9.TurnStatus.fromJson(data) as T;
    }
    if (t == _is.getType<_injc6hlm.Away?>()) {
      return (data != null ? _injc6hlm.Away.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3z62lxk.AwayEffect?>()) {
      return (data != null ? _i3z62lxk.AwayEffect.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i78xomdp.CachedRead?>()) {
      return (data != null ? _i78xomdp.CachedRead.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imnq0nzy.Chore?>()) {
      return (data != null ? _imnq0nzy.Chore.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilggw95u.DeviceToken?>()) {
      return (data != null ? _ilggw95u.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu57571s.FlatEvent?>()) {
      return (data != null ? _iu57571s.FlatEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_io7qq7p8.Flat?>()) {
      return (data != null ? _io7qq7p8.Flat.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izxtvxcg.FlatChange?>()) {
      return (data != null ? _izxtvxcg.FlatChange.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyrv7gay.FlatChangeKind?>()) {
      return (data != null ? _iyrv7gay.FlatChangeKind.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_id68d40p.FlatmatesException?>()) {
      return (data != null ? _id68d40p.FlatmatesException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ijoy4xkx.TurnCallsEndedModel?>()) {
      return (data != null
              ? _ijoy4xkx.TurnCallsEndedModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irgon17h.TurnCallsReminderModel?>()) {
      return (data != null
              ? _irgon17h.TurnCallsReminderModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_icfcmm02.TurnCallsStartedModel?>()) {
      return (data != null
              ? _icfcmm02.TurnCallsStartedModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idc9is2h.GroceryItem?>()) {
      return (data != null ? _idc9is2h.GroceryItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itahn62i.Mate?>()) {
      return (data != null ? _itahn62i.Mate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieys87jp.MateColor?>()) {
      return (data != null ? _ieys87jp.MateColor.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9fqeegk.MyFlat?>()) {
      return (data != null ? _i9fqeegk.MyFlat.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8bpb14y.Notice?>()) {
      return (data != null ? _i8bpb14y.Notice.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia5ed1vr.NoticeGotIt?>()) {
      return (data != null ? _ia5ed1vr.NoticeGotIt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijdri2o7.SwapDebt?>()) {
      return (data != null ? _ijdri2o7.SwapDebt.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0nsa51h.Turn?>()) {
      return (data != null ? _i0nsa51h.Turn.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5yk6qf9.TurnStatus?>()) {
      return (data != null ? _i5yk6qf9.TurnStatus.fromJson(data) : null) as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_itahn62i.Mate>) {
      return (data as List).map((e) => deserialize<_itahn62i.Mate>(e)).toList()
          as T;
    }
    if (t == _is.getType<List<_is.UuidValue>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_is.UuidValue>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_icx3t1f1.Away>) {
      return (data as List).map((e) => deserialize<_icx3t1f1.Away>(e)).toList()
          as T;
    }
    if (t == List<_ij1nfwf4.Chore>) {
      return (data as List).map((e) => deserialize<_ij1nfwf4.Chore>(e)).toList()
          as T;
    }
    if (t == List<_ij03rvz2.Turn>) {
      return (data as List).map((e) => deserialize<_ij03rvz2.Turn>(e)).toList()
          as T;
    }
    if (t == List<_is.UuidValue>) {
      return (data as List).map((e) => deserialize<_is.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_implyx9l.SwapDebt>) {
      return (data as List)
              .map((e) => deserialize<_implyx9l.SwapDebt>(e))
              .toList()
          as T;
    }
    if (t == List<_i7uqo6xr.FlatEvent>) {
      return (data as List)
              .map((e) => deserialize<_i7uqo6xr.FlatEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_itw5ie4o.GroceryItem>) {
      return (data as List)
              .map((e) => deserialize<_itw5ie4o.GroceryItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ikw41nt5.Notice>) {
      return (data as List)
              .map((e) => deserialize<_ikw41nt5.Notice>(e))
              .toList()
          as T;
    }
    if (t == List<_i2ir1nq4.NoticeGotIt>) {
      return (data as List)
              .map((e) => deserialize<_i2ir1nq4.NoticeGotIt>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _ij0lpv6z.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _injc6hlm.Away => 'Away',
      _i3z62lxk.AwayEffect => 'AwayEffect',
      _i78xomdp.CachedRead => 'CachedRead',
      _imnq0nzy.Chore => 'Chore',
      _ilggw95u.DeviceToken => 'DeviceToken',
      _iu57571s.FlatEvent => 'FlatEvent',
      _io7qq7p8.Flat => 'Flat',
      _izxtvxcg.FlatChange => 'FlatChange',
      _iyrv7gay.FlatChangeKind => 'FlatChangeKind',
      _id68d40p.FlatmatesException => 'FlatmatesException',
      _ijoy4xkx.TurnCallsEndedModel => 'TurnCallsEndedModel',
      _irgon17h.TurnCallsReminderModel => 'TurnCallsReminderModel',
      _icfcmm02.TurnCallsStartedModel => 'TurnCallsStartedModel',
      _idc9is2h.GroceryItem => 'GroceryItem',
      _itahn62i.Mate => 'Mate',
      _ieys87jp.MateColor => 'MateColor',
      _i9fqeegk.MyFlat => 'MyFlat',
      _i8bpb14y.Notice => 'Notice',
      _ia5ed1vr.NoticeGotIt => 'NoticeGotIt',
      _ijdri2o7.SwapDebt => 'SwapDebt',
      _i0nsa51h.Turn => 'Turn',
      _i5yk6qf9.TurnStatus => 'TurnStatus',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('flatmates.', '');
    }

    switch (data) {
      case _injc6hlm.Away():
        return 'Away';
      case _i3z62lxk.AwayEffect():
        return 'AwayEffect';
      case _i78xomdp.CachedRead():
        return 'CachedRead';
      case _imnq0nzy.Chore():
        return 'Chore';
      case _ilggw95u.DeviceToken():
        return 'DeviceToken';
      case _iu57571s.FlatEvent():
        return 'FlatEvent';
      case _io7qq7p8.Flat():
        return 'Flat';
      case _izxtvxcg.FlatChange():
        return 'FlatChange';
      case _iyrv7gay.FlatChangeKind():
        return 'FlatChangeKind';
      case _id68d40p.FlatmatesException():
        return 'FlatmatesException';
      case _ijoy4xkx.TurnCallsEndedModel():
        return 'TurnCallsEndedModel';
      case _irgon17h.TurnCallsReminderModel():
        return 'TurnCallsReminderModel';
      case _icfcmm02.TurnCallsStartedModel():
        return 'TurnCallsStartedModel';
      case _idc9is2h.GroceryItem():
        return 'GroceryItem';
      case _itahn62i.Mate():
        return 'Mate';
      case _ieys87jp.MateColor():
        return 'MateColor';
      case _i9fqeegk.MyFlat():
        return 'MyFlat';
      case _i8bpb14y.Notice():
        return 'Notice';
      case _ia5ed1vr.NoticeGotIt():
        return 'NoticeGotIt';
      case _ijdri2o7.SwapDebt():
        return 'SwapDebt';
      case _i0nsa51h.Turn():
        return 'Turn';
      case _i5yk6qf9.TurnStatus():
        return 'TurnStatus';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _ij0lpv6z.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'flatmates_shared.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Away') {
      return deserialize<_injc6hlm.Away>(data['data']);
    }
    if (dataClassName == 'AwayEffect') {
      return deserialize<_i3z62lxk.AwayEffect>(data['data']);
    }
    if (dataClassName == 'CachedRead') {
      return deserialize<_i78xomdp.CachedRead>(data['data']);
    }
    if (dataClassName == 'Chore') {
      return deserialize<_imnq0nzy.Chore>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_ilggw95u.DeviceToken>(data['data']);
    }
    if (dataClassName == 'FlatEvent') {
      return deserialize<_iu57571s.FlatEvent>(data['data']);
    }
    if (dataClassName == 'Flat') {
      return deserialize<_io7qq7p8.Flat>(data['data']);
    }
    if (dataClassName == 'FlatChange') {
      return deserialize<_izxtvxcg.FlatChange>(data['data']);
    }
    if (dataClassName == 'FlatChangeKind') {
      return deserialize<_iyrv7gay.FlatChangeKind>(data['data']);
    }
    if (dataClassName == 'FlatmatesException') {
      return deserialize<_id68d40p.FlatmatesException>(data['data']);
    }
    if (dataClassName == 'TurnCallsEndedModel') {
      return deserialize<_ijoy4xkx.TurnCallsEndedModel>(data['data']);
    }
    if (dataClassName == 'TurnCallsReminderModel') {
      return deserialize<_irgon17h.TurnCallsReminderModel>(data['data']);
    }
    if (dataClassName == 'TurnCallsStartedModel') {
      return deserialize<_icfcmm02.TurnCallsStartedModel>(data['data']);
    }
    if (dataClassName == 'GroceryItem') {
      return deserialize<_idc9is2h.GroceryItem>(data['data']);
    }
    if (dataClassName == 'Mate') {
      return deserialize<_itahn62i.Mate>(data['data']);
    }
    if (dataClassName == 'MateColor') {
      return deserialize<_ieys87jp.MateColor>(data['data']);
    }
    if (dataClassName == 'MyFlat') {
      return deserialize<_i9fqeegk.MyFlat>(data['data']);
    }
    if (dataClassName == 'Notice') {
      return deserialize<_i8bpb14y.Notice>(data['data']);
    }
    if (dataClassName == 'NoticeGotIt') {
      return deserialize<_ia5ed1vr.NoticeGotIt>(data['data']);
    }
    if (dataClassName == 'SwapDebt') {
      return deserialize<_ijdri2o7.SwapDebt>(data['data']);
    }
    if (dataClassName == 'Turn') {
      return deserialize<_i0nsa51h.Turn>(data['data']);
    }
    if (dataClassName == 'TurnStatus') {
      return deserialize<_i5yk6qf9.TurnStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('flatmates_shared.')) {
      data['className'] = dataClassName.substring(17);
      return _ij0lpv6z.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('flatmates', this);
    _iacs.Protocol().registerHostProtocol('flatmates', this);
    _ij0lpv6z.Protocol().registerHostProtocol('flatmates', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _ij0lpv6z.Protocol();
      var table = protocol is _is.DatabaseSerializationManager
          ? (protocol as _is.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _injc6hlm.Away:
        return _injc6hlm.Away.t;
      case _imnq0nzy.Chore:
        return _imnq0nzy.Chore.t;
      case _ilggw95u.DeviceToken:
        return _ilggw95u.DeviceToken.t;
      case _iu57571s.FlatEvent:
        return _iu57571s.FlatEvent.t;
      case _io7qq7p8.Flat:
        return _io7qq7p8.Flat.t;
      case _idc9is2h.GroceryItem:
        return _idc9is2h.GroceryItem.t;
      case _itahn62i.Mate:
        return _itahn62i.Mate.t;
      case _i8bpb14y.Notice:
        return _i8bpb14y.Notice.t;
      case _ia5ed1vr.NoticeGotIt:
        return _ia5ed1vr.NoticeGotIt.t;
      case _ijdri2o7.SwapDebt:
        return _ijdri2o7.SwapDebt.t;
      case _i0nsa51h.Turn:
        return _i0nsa51h.Turn.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'flatmates';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
