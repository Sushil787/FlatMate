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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'mate_color.dart' as _ieys87jp;

/// A member of a Flat. A Mate with [leftAt] set has left the Flat.
abstract class Mate
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  Mate._({
    this.id,
    required this.flatId,
    required this.authUserId,
    required this.displayName,
    required this.joinedAt,
    this.leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : color = color ?? _ieys87jp.MateColor.tomato,
       notifyTurnStarts = notifyTurnStarts ?? true,
       notifyReminder = notifyReminder ?? true,
       notifyMatesNotDone = notifyMatesNotDone ?? true,
       notifyNotice = notifyNotice ?? true,
       notifyAddedToRotation = notifyAddedToRotation ?? true,
       welcomed = welcomed ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Mate({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MateImpl;

  factory Mate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mate(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      leftAt: jsonSerialization['leftAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['leftAt']),
      color: jsonSerialization['color'] == null
          ? null
          : _ieys87jp.MateColor.fromJson(
              (jsonSerialization['color'] as String),
            ),
      notifyTurnStarts: jsonSerialization['notifyTurnStarts'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyTurnStarts'],
            ),
      notifyReminder: jsonSerialization['notifyReminder'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyReminder'],
            ),
      notifyMatesNotDone: jsonSerialization['notifyMatesNotDone'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyMatesNotDone'],
            ),
      notifyNotice: jsonSerialization['notifyNotice'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['notifyNotice']),
      notifyAddedToRotation: jsonSerialization['notifyAddedToRotation'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyAddedToRotation'],
            ),
      welcomed: jsonSerialization['welcomed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['welcomed']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MateTable();

  static const db = MateRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  _isc.UuidValue authUserId;

  String displayName;

  DateTime joinedAt;

  DateTime? leftAt;

  _ieys87jp.MateColor color;

  /// Which push notifications the Mate wants.
  bool notifyTurnStarts;

  bool notifyReminder;

  /// The evening push about other Mates' Turns not Done yet.
  bool notifyMatesNotDone;

  bool notifyNotice;

  bool notifyAddedToRotation;

  /// False until the Admin has seen that this Mate joined and picked their
  /// Chores (or chose to do it later).
  bool welcomed;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Mate copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    _isc.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMatesNotDone': notifyMatesNotDone,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
      'welcomed': welcomed,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMatesNotDone': notifyMatesNotDone,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
      'welcomed': welcomed,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MateInclude include() {
    return MateInclude._();
  }

  static MateIncludeList includeList({
    _isd.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    MateInclude? include,
  }) {
    return MateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MateImpl extends Mate {
  _MateImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         authUserId: authUserId,
         displayName: displayName,
         joinedAt: joinedAt,
         leftAt: leftAt,
         color: color,
         notifyTurnStarts: notifyTurnStarts,
         notifyReminder: notifyReminder,
         notifyMatesNotDone: notifyMatesNotDone,
         notifyNotice: notifyNotice,
         notifyAddedToRotation: notifyAddedToRotation,
         welcomed: welcomed,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Mate copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    _isc.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    Object? leftAt = _Undefined,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mate(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt is DateTime? ? leftAt : this.leftAt,
      color: color ?? this.color,
      notifyTurnStarts: notifyTurnStarts ?? this.notifyTurnStarts,
      notifyReminder: notifyReminder ?? this.notifyReminder,
      notifyMatesNotDone: notifyMatesNotDone ?? this.notifyMatesNotDone,
      notifyNotice: notifyNotice ?? this.notifyNotice,
      notifyAddedToRotation:
          notifyAddedToRotation ?? this.notifyAddedToRotation,
      welcomed: welcomed ?? this.welcomed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MateUpdateTable extends _isd.UpdateTable<MateTable> {
  MateUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> flatId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.flatId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> authUserId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.authUserId,
    value,
  );

  _isd.ColumnValue<String, String> displayName(String value) =>
      _isd.ColumnValue(
        table.displayName,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _isd.ColumnValue(
        table.joinedAt,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> leftAt(DateTime? value) =>
      _isd.ColumnValue(
        table.leftAt,
        value,
      );

  _isd.ColumnValue<_ieys87jp.MateColor, _ieys87jp.MateColor> color(
    _ieys87jp.MateColor value,
  ) => _isd.ColumnValue(
    table.color,
    value,
  );

  _isd.ColumnValue<bool, bool> notifyTurnStarts(bool value) => _isd.ColumnValue(
    table.notifyTurnStarts,
    value,
  );

  _isd.ColumnValue<bool, bool> notifyReminder(bool value) => _isd.ColumnValue(
    table.notifyReminder,
    value,
  );

  _isd.ColumnValue<bool, bool> notifyMatesNotDone(bool value) =>
      _isd.ColumnValue(
        table.notifyMatesNotDone,
        value,
      );

  _isd.ColumnValue<bool, bool> notifyNotice(bool value) => _isd.ColumnValue(
    table.notifyNotice,
    value,
  );

  _isd.ColumnValue<bool, bool> notifyAddedToRotation(bool value) =>
      _isd.ColumnValue(
        table.notifyAddedToRotation,
        value,
      );

  _isd.ColumnValue<bool, bool> welcomed(bool value) => _isd.ColumnValue(
    table.welcomed,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _isd.ColumnValue(
        table.createdAt,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _isd.ColumnValue(
        table.updatedAt,
        value,
      );
}

class MateTable extends _isd.Table<_isc.UuidValue?> {
  MateTable({super.tableRelation}) : super(tableName: 'mate') {
    updateTable = MateUpdateTable(this);
    flatId = _isd.ColumnUuid(
      'flatId',
      this,
    );
    authUserId = _isd.ColumnUuid(
      'authUserId',
      this,
    );
    displayName = _isd.ColumnString(
      'displayName',
      this,
    );
    joinedAt = _isd.ColumnDateTime(
      'joinedAt',
      this,
    );
    leftAt = _isd.ColumnDateTime(
      'leftAt',
      this,
    );
    color = _isd.ColumnEnum(
      'color',
      this,
      _isd.EnumSerialization.byName,
      hasDefault: true,
    );
    notifyTurnStarts = _isd.ColumnBool(
      'notifyTurnStarts',
      this,
      hasDefault: true,
    );
    notifyReminder = _isd.ColumnBool(
      'notifyReminder',
      this,
      hasDefault: true,
    );
    notifyMatesNotDone = _isd.ColumnBool(
      'notifyMatesNotDone',
      this,
      hasDefault: true,
    );
    notifyNotice = _isd.ColumnBool(
      'notifyNotice',
      this,
      hasDefault: true,
    );
    notifyAddedToRotation = _isd.ColumnBool(
      'notifyAddedToRotation',
      this,
      hasDefault: true,
    );
    welcomed = _isd.ColumnBool(
      'welcomed',
      this,
      hasDefault: true,
    );
    createdAt = _isd.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _isd.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final MateUpdateTable updateTable;

  late final _isd.ColumnUuid flatId;

  late final _isd.ColumnUuid authUserId;

  late final _isd.ColumnString displayName;

  late final _isd.ColumnDateTime joinedAt;

  late final _isd.ColumnDateTime leftAt;

  late final _isd.ColumnEnum<_ieys87jp.MateColor> color;

  /// Which push notifications the Mate wants.
  late final _isd.ColumnBool notifyTurnStarts;

  late final _isd.ColumnBool notifyReminder;

  /// The evening push about other Mates' Turns not Done yet.
  late final _isd.ColumnBool notifyMatesNotDone;

  late final _isd.ColumnBool notifyNotice;

  late final _isd.ColumnBool notifyAddedToRotation;

  /// False until the Admin has seen that this Mate joined and picked their
  /// Chores (or chose to do it later).
  late final _isd.ColumnBool welcomed;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    flatId,
    authUserId,
    displayName,
    joinedAt,
    leftAt,
    color,
    notifyTurnStarts,
    notifyReminder,
    notifyMatesNotDone,
    notifyNotice,
    notifyAddedToRotation,
    welcomed,
    createdAt,
    updatedAt,
  ];
}

class MateInclude extends _isd.IncludeObject {
  MateInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Mate.t;
}

class MateIncludeList extends _isd.IncludeList {
  MateIncludeList._({
    _isd.WhereExpressionBuilder<MateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mate.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Mate.t;
}

class MateRepository {
  const MateRepository._();

  /// Returns a list of [Mate]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Mate>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mate] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Mate?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<MateTable>? where,
    int? offset,
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mate] by its [id] or null if no such row exists.
  Future<Mate?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mate]s in the list and returns the inserted rows.
  ///
  /// The returned [Mate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> insert(
    _isd.DatabaseSession session,
    List<Mate> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Mate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Mate] and returns the inserted row.
  ///
  /// The returned [Mate] will have its `id` field set.
  Future<Mate> insertRow(
    _isd.DatabaseSession session,
    Mate row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Mate]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Mate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> upsert(
    _isd.DatabaseSession session,
    List<Mate> rows, {
    required _isd.ColumnSelections<MateTable> conflictColumns,
    _isd.ColumnSelections<MateTable>? updateColumns,
    _isd.WhereExpressionBuilder<MateTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Mate>(
      rows,
      conflictColumns: conflictColumns(Mate.t),
      updateColumns: updateColumns?.call(Mate.t),
      updateWhere: updateWhere?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Mate] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Mate] will have its `id` field set.
  Future<Mate?> upsertRow(
    _isd.DatabaseSession session,
    Mate row, {
    required _isd.ColumnSelections<MateTable> conflictColumns,
    _isd.ColumnSelections<MateTable>? updateColumns,
    _isd.WhereExpressionBuilder<MateTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Mate>(
      row,
      conflictColumns: conflictColumns(Mate.t),
      updateColumns: updateColumns?.call(Mate.t),
      updateWhere: updateWhere?.call(Mate.t),
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> update(
    _isd.DatabaseSession session,
    List<Mate> rows, {
    _isd.ColumnSelections<MateTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Mate>(
      rows,
      columns: columns?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Mate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mate> updateRow(
    _isd.DatabaseSession session,
    Mate row, {
    _isd.ColumnSelections<MateTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mate>(
      row,
      columns: columns?.call(Mate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mate?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<MateUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<Mate>(
      id,
      columnValues: columnValues(Mate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<MateUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<MateTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Mate>(
      columnValues: columnValues(Mate.t.updateTable),
      where: where(Mate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Mate]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> delete(
    _isd.DatabaseSession session,
    List<Mate> rows, {
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Mate>(
      rows,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Mate].
  Future<Mate> deleteRow(
    _isd.DatabaseSession session,
    Mate row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<MateTable> where,
    _isd.OrderByBuilder<MateTable>? orderBy,
    _isd.OrderByListBuilder<MateTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Mate>(
      where: where(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Mate>(
      where: where?.call(Mate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mate] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<MateTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mate>(
      where: where(Mate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
