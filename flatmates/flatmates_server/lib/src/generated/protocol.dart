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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'away.dart' as _i5;
import 'away_rule.dart' as _i6;
import 'chore.dart' as _i7;
import 'device_token.dart' as _i8;
import 'event.dart' as _i9;
import 'flat.dart' as _i10;
import 'flat_change.dart' as _i11;
import 'flat_change_kind.dart' as _i12;
import 'flatmates_exception.dart' as _i13;
import 'future_calls_generated_models/turn_calls_ended_model.dart' as _i14;
import 'future_calls_generated_models/turn_calls_reminder_model.dart' as _i15;
import 'future_calls_generated_models/turn_calls_started_model.dart' as _i16;
import 'grocery_item.dart' as _i17;
import 'mate.dart' as _i18;
import 'my_flat.dart' as _i19;
import 'notice.dart' as _i20;
import 'swap_debt.dart' as _i21;
import 'turn.dart' as _i22;
import 'turn_status.dart' as _i23;
import 'package:flatmates_server/src/generated/away.dart' as _i24;
import 'package:flatmates_server/src/generated/chore.dart' as _i25;
import 'package:flatmates_server/src/generated/turn.dart' as _i26;
import 'package:flatmates_server/src/generated/event.dart' as _i27;
import 'package:flatmates_server/src/generated/grocery_item.dart' as _i28;
import 'package:flatmates_server/src/generated/notice.dart' as _i29;
export 'away.dart';
export 'away_rule.dart';
export 'chore.dart';
export 'device_token.dart';
export 'event.dart';
export 'flat.dart';
export 'flat_change.dart';
export 'flat_change_kind.dart';
export 'flatmates_exception.dart';
export 'grocery_item.dart';
export 'mate.dart';
export 'my_flat.dart';
export 'notice.dart';
export 'swap_debt.dart';
export 'turn.dart';
export 'turn_status.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'away',
      dartName: 'Away',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'away_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'away_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'away_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'chore',
      dartName: 'Chore',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chore_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'period',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'Duration',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'rotation',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<int>',
        ),
        _i2.ColumnDefinition(
          name: 'rotationIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'archived',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chore_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'chore_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'device_token',
      dartName: 'DeviceToken',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'token',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'device_token_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'device_token_token_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_token_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'flat',
      dartName: 'Flat',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'flat_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timezone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'adminMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'inviteCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'awayRule',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AwayRule',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'flat_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'flat_invite_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'flat_event',
      dartName: 'FlatEvent',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'flat_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'flat_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'flat_event_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'grocery_item',
      dartName: 'GroceryItem',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'grocery_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'addedByMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'boughtByMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'boughtAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'grocery_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'grocery_item_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'mate',
      dartName: 'Mate',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'mate_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'joinedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'leftAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'mate_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'mate_auth_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'mate_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'notice',
      dartName: 'Notice',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notice_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pinned',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notice_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'notice_flat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'swap_debt',
      dartName: 'SwapDebt',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'swap_debt_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'choreId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'debtorMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'creditorMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'swap_debt_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'swap_debt_chore_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    _i2.TableDefinition(
      name: 'turn',
      dartName: 'Turn',
      schema: 'public',
      module: 'flatmates',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'turn_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'choreId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'mateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'coveringForMateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TurnStatus',
        ),
        _i2.ColumnDefinition(
          name: 'doneAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'turn_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'turn_chore_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'choreId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'turn_flat_time_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'flatId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
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
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
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
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Away) {
      return _i5.Away.fromJson(data) as T;
    }
    if (t == _i6.AwayRule) {
      return _i6.AwayRule.fromJson(data) as T;
    }
    if (t == _i7.Chore) {
      return _i7.Chore.fromJson(data) as T;
    }
    if (t == _i8.DeviceToken) {
      return _i8.DeviceToken.fromJson(data) as T;
    }
    if (t == _i9.FlatEvent) {
      return _i9.FlatEvent.fromJson(data) as T;
    }
    if (t == _i10.Flat) {
      return _i10.Flat.fromJson(data) as T;
    }
    if (t == _i11.FlatChange) {
      return _i11.FlatChange.fromJson(data) as T;
    }
    if (t == _i12.FlatChangeKind) {
      return _i12.FlatChangeKind.fromJson(data) as T;
    }
    if (t == _i13.FlatmatesException) {
      return _i13.FlatmatesException.fromJson(data) as T;
    }
    if (t == _i14.TurnCallsEndedModel) {
      return _i14.TurnCallsEndedModel.fromJson(data) as T;
    }
    if (t == _i15.TurnCallsReminderModel) {
      return _i15.TurnCallsReminderModel.fromJson(data) as T;
    }
    if (t == _i16.TurnCallsStartedModel) {
      return _i16.TurnCallsStartedModel.fromJson(data) as T;
    }
    if (t == _i17.GroceryItem) {
      return _i17.GroceryItem.fromJson(data) as T;
    }
    if (t == _i18.Mate) {
      return _i18.Mate.fromJson(data) as T;
    }
    if (t == _i19.MyFlat) {
      return _i19.MyFlat.fromJson(data) as T;
    }
    if (t == _i20.Notice) {
      return _i20.Notice.fromJson(data) as T;
    }
    if (t == _i21.SwapDebt) {
      return _i21.SwapDebt.fromJson(data) as T;
    }
    if (t == _i22.Turn) {
      return _i22.Turn.fromJson(data) as T;
    }
    if (t == _i23.TurnStatus) {
      return _i23.TurnStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Away?>()) {
      return (data != null ? _i5.Away.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AwayRule?>()) {
      return (data != null ? _i6.AwayRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Chore?>()) {
      return (data != null ? _i7.Chore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DeviceToken?>()) {
      return (data != null ? _i8.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.FlatEvent?>()) {
      return (data != null ? _i9.FlatEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Flat?>()) {
      return (data != null ? _i10.Flat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.FlatChange?>()) {
      return (data != null ? _i11.FlatChange.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.FlatChangeKind?>()) {
      return (data != null ? _i12.FlatChangeKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.FlatmatesException?>()) {
      return (data != null ? _i13.FlatmatesException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.TurnCallsEndedModel?>()) {
      return (data != null ? _i14.TurnCallsEndedModel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.TurnCallsReminderModel?>()) {
      return (data != null ? _i15.TurnCallsReminderModel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.TurnCallsStartedModel?>()) {
      return (data != null ? _i16.TurnCallsStartedModel.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.GroceryItem?>()) {
      return (data != null ? _i17.GroceryItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Mate?>()) {
      return (data != null ? _i18.Mate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.MyFlat?>()) {
      return (data != null ? _i19.MyFlat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Notice?>()) {
      return (data != null ? _i20.Notice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SwapDebt?>()) {
      return (data != null ? _i21.SwapDebt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Turn?>()) {
      return (data != null ? _i22.Turn.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.TurnStatus?>()) {
      return (data != null ? _i23.TurnStatus.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i18.Mate>) {
      return (data as List).map((e) => deserialize<_i18.Mate>(e)).toList() as T;
    }
    if (t == List<_i24.Away>) {
      return (data as List).map((e) => deserialize<_i24.Away>(e)).toList() as T;
    }
    if (t == List<_i25.Chore>) {
      return (data as List).map((e) => deserialize<_i25.Chore>(e)).toList()
          as T;
    }
    if (t == List<_i26.Turn>) {
      return (data as List).map((e) => deserialize<_i26.Turn>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i27.FlatEvent>) {
      return (data as List).map((e) => deserialize<_i27.FlatEvent>(e)).toList()
          as T;
    }
    if (t == List<_i28.GroceryItem>) {
      return (data as List)
              .map((e) => deserialize<_i28.GroceryItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.Notice>) {
      return (data as List).map((e) => deserialize<_i29.Notice>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Away => 'Away',
      _i6.AwayRule => 'AwayRule',
      _i7.Chore => 'Chore',
      _i8.DeviceToken => 'DeviceToken',
      _i9.FlatEvent => 'FlatEvent',
      _i10.Flat => 'Flat',
      _i11.FlatChange => 'FlatChange',
      _i12.FlatChangeKind => 'FlatChangeKind',
      _i13.FlatmatesException => 'FlatmatesException',
      _i14.TurnCallsEndedModel => 'TurnCallsEndedModel',
      _i15.TurnCallsReminderModel => 'TurnCallsReminderModel',
      _i16.TurnCallsStartedModel => 'TurnCallsStartedModel',
      _i17.GroceryItem => 'GroceryItem',
      _i18.Mate => 'Mate',
      _i19.MyFlat => 'MyFlat',
      _i20.Notice => 'Notice',
      _i21.SwapDebt => 'SwapDebt',
      _i22.Turn => 'Turn',
      _i23.TurnStatus => 'TurnStatus',
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
      case _i5.Away():
        return 'Away';
      case _i6.AwayRule():
        return 'AwayRule';
      case _i7.Chore():
        return 'Chore';
      case _i8.DeviceToken():
        return 'DeviceToken';
      case _i9.FlatEvent():
        return 'FlatEvent';
      case _i10.Flat():
        return 'Flat';
      case _i11.FlatChange():
        return 'FlatChange';
      case _i12.FlatChangeKind():
        return 'FlatChangeKind';
      case _i13.FlatmatesException():
        return 'FlatmatesException';
      case _i14.TurnCallsEndedModel():
        return 'TurnCallsEndedModel';
      case _i15.TurnCallsReminderModel():
        return 'TurnCallsReminderModel';
      case _i16.TurnCallsStartedModel():
        return 'TurnCallsStartedModel';
      case _i17.GroceryItem():
        return 'GroceryItem';
      case _i18.Mate():
        return 'Mate';
      case _i19.MyFlat():
        return 'MyFlat';
      case _i20.Notice():
        return 'Notice';
      case _i21.SwapDebt():
        return 'SwapDebt';
      case _i22.Turn():
        return 'Turn';
      case _i23.TurnStatus():
        return 'TurnStatus';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
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
      return deserialize<_i5.Away>(data['data']);
    }
    if (dataClassName == 'AwayRule') {
      return deserialize<_i6.AwayRule>(data['data']);
    }
    if (dataClassName == 'Chore') {
      return deserialize<_i7.Chore>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_i8.DeviceToken>(data['data']);
    }
    if (dataClassName == 'FlatEvent') {
      return deserialize<_i9.FlatEvent>(data['data']);
    }
    if (dataClassName == 'Flat') {
      return deserialize<_i10.Flat>(data['data']);
    }
    if (dataClassName == 'FlatChange') {
      return deserialize<_i11.FlatChange>(data['data']);
    }
    if (dataClassName == 'FlatChangeKind') {
      return deserialize<_i12.FlatChangeKind>(data['data']);
    }
    if (dataClassName == 'FlatmatesException') {
      return deserialize<_i13.FlatmatesException>(data['data']);
    }
    if (dataClassName == 'TurnCallsEndedModel') {
      return deserialize<_i14.TurnCallsEndedModel>(data['data']);
    }
    if (dataClassName == 'TurnCallsReminderModel') {
      return deserialize<_i15.TurnCallsReminderModel>(data['data']);
    }
    if (dataClassName == 'TurnCallsStartedModel') {
      return deserialize<_i16.TurnCallsStartedModel>(data['data']);
    }
    if (dataClassName == 'GroceryItem') {
      return deserialize<_i17.GroceryItem>(data['data']);
    }
    if (dataClassName == 'Mate') {
      return deserialize<_i18.Mate>(data['data']);
    }
    if (dataClassName == 'MyFlat') {
      return deserialize<_i19.MyFlat>(data['data']);
    }
    if (dataClassName == 'Notice') {
      return deserialize<_i20.Notice>(data['data']);
    }
    if (dataClassName == 'SwapDebt') {
      return deserialize<_i21.SwapDebt>(data['data']);
    }
    if (dataClassName == 'Turn') {
      return deserialize<_i22.Turn>(data['data']);
    }
    if (dataClassName == 'TurnStatus') {
      return deserialize<_i23.TurnStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Away:
        return _i5.Away.t;
      case _i7.Chore:
        return _i7.Chore.t;
      case _i8.DeviceToken:
        return _i8.DeviceToken.t;
      case _i9.FlatEvent:
        return _i9.FlatEvent.t;
      case _i10.Flat:
        return _i10.Flat.t;
      case _i17.GroceryItem:
        return _i17.GroceryItem.t;
      case _i18.Mate:
        return _i18.Mate.t;
      case _i20.Notice:
        return _i20.Notice.t;
      case _i21.SwapDebt:
        return _i21.SwapDebt.t;
      case _i22.Turn:
        return _i22.Turn.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
