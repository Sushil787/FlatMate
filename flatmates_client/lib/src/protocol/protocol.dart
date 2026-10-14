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
import 'package:flatmates_client/src/protocol/away.dart' as _irs4lusq;
import 'package:flatmates_client/src/protocol/chore.dart' as _ipou5iyr;
import 'package:flatmates_client/src/protocol/event.dart' as _igj22k42;
import 'package:flatmates_client/src/protocol/grocery_item.dart' as _iy9ydfy6;
import 'package:flatmates_client/src/protocol/notice.dart' as _iynhw2wx;
import 'package:flatmates_client/src/protocol/notice_got_it.dart' as _i8dhtq4g;
import 'package:flatmates_client/src/protocol/swap_debt.dart' as _icdhy1dj;
import 'package:flatmates_client/src/protocol/turn.dart' as _i4k8bhoi;
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
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
export 'client.dart';

class Protocol extends _isd.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isd.TableDefinition> get targetTableDefinitions => [
    _isd.TableDefinition(
      name: 'away',
      dartName: 'Away',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'mateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'startDay',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'lastDay',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'away_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'cached_read',
      dartName: 'CachedRead',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isd.ColumnDefinition(
          name: 'key',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'savedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'cached_read_key_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'chore',
      dartName: 'Chore',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'name',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'period',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'Duration',
        ),
        _isd.ColumnDefinition(
          name: 'startDay',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'rotation',
          columnType: _isd.ColumnType.json,
          isNullable: false,
          dartType: 'List<UuidValue>',
        ),
        _isd.ColumnDefinition(
          name: 'rotationIndex',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'archived',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isd.ColumnDefinition(
          name: 'turnTime',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'flatmates_shared:TurnTime',
          columnDefault: '\'evening\'',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'chore_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'flat',
      dartName: 'Flat',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'name',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'timezone',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'adminMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isd.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'inviteExpiresAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'awayRule',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'flatmates_shared:AwayRule',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'flat_invite_code_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'flat_event',
      dartName: 'FlatEvent',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'mateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'title',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'note',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'startsAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'endsAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'allDay',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'flat_event_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'grocery_item',
      dartName: 'GroceryItem',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'name',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'note',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'addedByMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'boughtByMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isd.ColumnDefinition(
          name: 'boughtAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'grocery_item_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'mate',
      dartName: 'Mate',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'authUserId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'displayName',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'leftAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'color',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MateColor',
          columnDefault: '\'tomato\'',
        ),
        _isd.ColumnDefinition(
          name: 'notifyTurnStarts',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'notifyReminder',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'notifyMatesNotDone',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'notifyNotice',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'notifyAddedToRotation',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'notifyNightSummary',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'welcomed',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isd.ColumnDefinition(
          name: 'onboardedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'mate_auth_user_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isd.IndexDefinition(
          indexName: 'mate_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'notice',
      dartName: 'Notice',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'mateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'text',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'pinned',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'notice_flat_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'notice_got_it',
      dartName: 'NoticeGotIt',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'noticeId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'mateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'notice_got_it_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'noticeId',
            ),
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'swap_debt',
      dartName: 'SwapDebt',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'choreId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'debtorMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'creditorMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'swap_debt_chore_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    _isd.TableDefinition(
      name: 'turn',
      dartName: 'Turn',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'random_v7',
        ),
        _isd.ColumnDefinition(
          name: 'flatId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'choreId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'mateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'coveringForMateId',
          columnType: _isd.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isd.ColumnDefinition(
          name: 'day',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'lastDay',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'status',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TurnStatus',
        ),
        _isd.ColumnDefinition(
          name: 'doneAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'turn_chore_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'choreId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isd.IndexDefinition(
          indexName: 'turn_flat_day_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
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
    ..._iaic.Protocol() is _isd.DatabaseSerializationManager
        ? (_iaic.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._iacc.Protocol() is _isd.DatabaseSerializationManager
        ? (_iacc.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._ij0lpv6z.Protocol() is _isd.DatabaseSerializationManager
        ? (_ij0lpv6z.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _isc.getType<_injc6hlm.Away?>()) {
      return (data != null ? _injc6hlm.Away.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3z62lxk.AwayEffect?>()) {
      return (data != null ? _i3z62lxk.AwayEffect.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i78xomdp.CachedRead?>()) {
      return (data != null ? _i78xomdp.CachedRead.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imnq0nzy.Chore?>()) {
      return (data != null ? _imnq0nzy.Chore.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilggw95u.DeviceToken?>()) {
      return (data != null ? _ilggw95u.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu57571s.FlatEvent?>()) {
      return (data != null ? _iu57571s.FlatEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_io7qq7p8.Flat?>()) {
      return (data != null ? _io7qq7p8.Flat.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izxtvxcg.FlatChange?>()) {
      return (data != null ? _izxtvxcg.FlatChange.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyrv7gay.FlatChangeKind?>()) {
      return (data != null ? _iyrv7gay.FlatChangeKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_id68d40p.FlatmatesException?>()) {
      return (data != null ? _id68d40p.FlatmatesException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idc9is2h.GroceryItem?>()) {
      return (data != null ? _idc9is2h.GroceryItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itahn62i.Mate?>()) {
      return (data != null ? _itahn62i.Mate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieys87jp.MateColor?>()) {
      return (data != null ? _ieys87jp.MateColor.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9fqeegk.MyFlat?>()) {
      return (data != null ? _i9fqeegk.MyFlat.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8bpb14y.Notice?>()) {
      return (data != null ? _i8bpb14y.Notice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia5ed1vr.NoticeGotIt?>()) {
      return (data != null ? _ia5ed1vr.NoticeGotIt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijdri2o7.SwapDebt?>()) {
      return (data != null ? _ijdri2o7.SwapDebt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0nsa51h.Turn?>()) {
      return (data != null ? _i0nsa51h.Turn.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5yk6qf9.TurnStatus?>()) {
      return (data != null ? _i5yk6qf9.TurnStatus.fromJson(data) : null) as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_itahn62i.Mate>) {
      return (data as List).map((e) => deserialize<_itahn62i.Mate>(e)).toList()
          as T;
    }
    if (t == _isc.getType<List<_isc.UuidValue>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_isc.UuidValue>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_irs4lusq.Away>) {
      return (data as List).map((e) => deserialize<_irs4lusq.Away>(e)).toList()
          as T;
    }
    if (t == List<_ipou5iyr.Chore>) {
      return (data as List).map((e) => deserialize<_ipou5iyr.Chore>(e)).toList()
          as T;
    }
    if (t == List<_i4k8bhoi.Turn>) {
      return (data as List).map((e) => deserialize<_i4k8bhoi.Turn>(e)).toList()
          as T;
    }
    if (t == List<_isc.UuidValue>) {
      return (data as List).map((e) => deserialize<_isc.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_icdhy1dj.SwapDebt>) {
      return (data as List)
              .map((e) => deserialize<_icdhy1dj.SwapDebt>(e))
              .toList()
          as T;
    }
    if (t == List<_igj22k42.FlatEvent>) {
      return (data as List)
              .map((e) => deserialize<_igj22k42.FlatEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_iy9ydfy6.GroceryItem>) {
      return (data as List)
              .map((e) => deserialize<_iy9ydfy6.GroceryItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iynhw2wx.Notice>) {
      return (data as List)
              .map((e) => deserialize<_iynhw2wx.Notice>(e))
              .toList()
          as T;
    }
    if (t == List<_i8dhtq4g.NoticeGotIt>) {
      return (data as List)
              .map((e) => deserialize<_i8dhtq4g.NoticeGotIt>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _ij0lpv6z.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('flatmates_shared.')) {
      data['className'] = dataClassName.substring(17);
      return _ij0lpv6z.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('flatmates', this);
    _iacc.Protocol().registerHostProtocol('flatmates', this);
    _ij0lpv6z.Protocol().registerHostProtocol('flatmates', this);
  }

  @override
  _isd.Table? getTableForType(Type t) {
    {
      var protocol = _iaic.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _iacc.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _ij0lpv6z.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _injc6hlm.Away:
        return _injc6hlm.Away.t;
      case _i78xomdp.CachedRead:
        return _i78xomdp.CachedRead.t;
      case _imnq0nzy.Chore:
        return _imnq0nzy.Chore.t;
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
  List<_isd.TableDefinition> getTargetTableDefinitions() =>
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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
