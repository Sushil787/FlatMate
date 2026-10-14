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
import 'package:flatmates_client/src/protocol/protocol.dart' as _iyp1dgna;
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// A recurring responsibility passed round-robin through [rotation].
abstract class Chore
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  Chore._({
    this.id,
    required this.flatId,
    required this.name,
    required this.period,
    required this.startDay,
    required this.rotation,
    required this.rotationIndex,
    required this.archived,
    _ij0lpv6z.TurnTime? turnTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : turnTime = turnTime ?? _ij0lpv6z.TurnTime.evening,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Chore({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<_isc.UuidValue> rotation,
    required int rotationIndex,
    required bool archived,
    _ij0lpv6z.TurnTime? turnTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChoreImpl;

  factory Chore.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chore(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      name: jsonSerialization['name'] as String,
      period: _isc.DurationJsonExtension.fromJson(jsonSerialization['period']),
      startDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDay'],
      ),
      rotation: _iyp1dgna.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['rotation'],
      ),
      rotationIndex: jsonSerialization['rotationIndex'] as int,
      archived: _isc.BoolJsonExtension.fromJson(jsonSerialization['archived']),
      turnTime: jsonSerialization['turnTime'] == null
          ? null
          : _ij0lpv6z.TurnTime.fromJson(
              (jsonSerialization['turnTime'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChoreTable();

  static const db = ChoreRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  String name;

  /// Rotation period: time from one Turn's start to the next, whole days.
  Duration period;

  /// The day of the first Turn (12:00 UTC on that date, see day.dart).
  DateTime startDay;

  /// Mate ids in order; a Mate may appear more than once.
  List<_isc.UuidValue> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  int rotationIndex;

  bool archived;

  /// When in the day its Turns are meant to be done; the Turn's pushes
  /// follow it.
  _ij0lpv6z.TurnTime turnTime;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Chore copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<_isc.UuidValue>? rotation,
    int? rotationIndex,
    bool? archived,
    _ij0lpv6z.TurnTime? turnTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(valueToJson: (v) => v.toJson()),
      'rotationIndex': rotationIndex,
      'archived': archived,
      'turnTime': turnTime.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(valueToJson: (v) => v.toJson()),
      'rotationIndex': rotationIndex,
      'archived': archived,
      'turnTime': turnTime.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChoreInclude include() {
    return ChoreInclude._();
  }

  static ChoreIncludeList includeList({
    _isd.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    ChoreInclude? include,
  }) {
    return ChoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoreImpl extends Chore {
  _ChoreImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<_isc.UuidValue> rotation,
    required int rotationIndex,
    required bool archived,
    _ij0lpv6z.TurnTime? turnTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         name: name,
         period: period,
         startDay: startDay,
         rotation: rotation,
         rotationIndex: rotationIndex,
         archived: archived,
         turnTime: turnTime,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Chore copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<_isc.UuidValue>? rotation,
    int? rotationIndex,
    bool? archived,
    _ij0lpv6z.TurnTime? turnTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chore(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      period: period ?? this.period,
      startDay: startDay ?? this.startDay,
      rotation: rotation ?? this.rotation.map((e0) => e0).toList(),
      rotationIndex: rotationIndex ?? this.rotationIndex,
      archived: archived ?? this.archived,
      turnTime: turnTime ?? this.turnTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChoreUpdateTable extends _isd.UpdateTable<ChoreTable> {
  ChoreUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> flatId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.flatId,
    value,
  );

  _isd.ColumnValue<String, String> name(String value) => _isd.ColumnValue(
    table.name,
    value,
  );

  _isd.ColumnValue<Duration, Duration> period(Duration value) =>
      _isd.ColumnValue(
        table.period,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> startDay(DateTime value) =>
      _isd.ColumnValue(
        table.startDay,
        value,
      );

  _isd.ColumnValue<List<_isc.UuidValue>, List<_isc.UuidValue>> rotation(
    List<_isc.UuidValue> value,
  ) => _isd.ColumnValue(
    table.rotation,
    value,
  );

  _isd.ColumnValue<int, int> rotationIndex(int value) => _isd.ColumnValue(
    table.rotationIndex,
    value,
  );

  _isd.ColumnValue<bool, bool> archived(bool value) => _isd.ColumnValue(
    table.archived,
    value,
  );

  _isd.ColumnValue<_ij0lpv6z.TurnTime, _ij0lpv6z.TurnTime> turnTime(
    _ij0lpv6z.TurnTime value,
  ) => _isd.ColumnValue(
    table.turnTime,
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

class ChoreTable extends _isd.Table<_isc.UuidValue?> {
  ChoreTable({super.tableRelation}) : super(tableName: 'chore') {
    updateTable = ChoreUpdateTable(this);
    flatId = _isd.ColumnUuid(
      'flatId',
      this,
    );
    name = _isd.ColumnString(
      'name',
      this,
    );
    period = _isd.ColumnDuration(
      'period',
      this,
    );
    startDay = _isd.ColumnDateTime(
      'startDay',
      this,
    );
    rotation = _isd.ColumnSerializable<List<_isc.UuidValue>>(
      'rotation',
      this,
    );
    rotationIndex = _isd.ColumnInt(
      'rotationIndex',
      this,
    );
    archived = _isd.ColumnBool(
      'archived',
      this,
    );
    turnTime = _isd.ColumnEnum(
      'turnTime',
      this,
      _isd.EnumSerialization.byName,
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

  late final ChoreUpdateTable updateTable;

  late final _isd.ColumnUuid flatId;

  late final _isd.ColumnString name;

  /// Rotation period: time from one Turn's start to the next, whole days.
  late final _isd.ColumnDuration period;

  /// The day of the first Turn (12:00 UTC on that date, see day.dart).
  late final _isd.ColumnDateTime startDay;

  /// Mate ids in order; a Mate may appear more than once.
  late final _isd.ColumnSerializable<List<_isc.UuidValue>> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  late final _isd.ColumnInt rotationIndex;

  late final _isd.ColumnBool archived;

  /// When in the day its Turns are meant to be done; the Turn's pushes
  /// follow it.
  late final _isd.ColumnEnum<_ij0lpv6z.TurnTime> turnTime;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    flatId,
    name,
    period,
    startDay,
    rotation,
    rotationIndex,
    archived,
    turnTime,
    createdAt,
    updatedAt,
  ];
}

class ChoreInclude extends _isd.IncludeObject {
  ChoreInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Chore.t;
}

class ChoreIncludeList extends _isd.IncludeList {
  ChoreIncludeList._({
    _isd.WhereExpressionBuilder<ChoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chore.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Chore.t;
}

class ChoreRepository {
  const ChoreRepository._();

  /// Returns a list of [Chore]s matching the given query parameters.
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
  Future<List<Chore>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Chore>(
      where: where?.call(Chore.t),
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Chore] matching the given query parameters.
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
  Future<Chore?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ChoreTable>? where,
    int? offset,
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Chore>(
      where: where?.call(Chore.t),
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Chore] by its [id] or null if no such row exists.
  Future<Chore?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Chore>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Chore]s in the list and returns the inserted rows.
  ///
  /// The returned [Chore]s will have their `id` fields set.
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
  Future<List<Chore>> insert(
    _isd.DatabaseSession session,
    List<Chore> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Chore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Chore] and returns the inserted row.
  ///
  /// The returned [Chore] will have its `id` field set.
  Future<Chore> insertRow(
    _isd.DatabaseSession session,
    Chore row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<Chore>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Chore]s in the list and returns the resulting rows.
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
  /// The returned [Chore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chore>> upsert(
    _isd.DatabaseSession session,
    List<Chore> rows, {
    required _isd.ColumnSelections<ChoreTable> conflictColumns,
    _isd.ColumnSelections<ChoreTable>? updateColumns,
    _isd.WhereExpressionBuilder<ChoreTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Chore>(
      rows,
      conflictColumns: conflictColumns(Chore.t),
      updateColumns: updateColumns?.call(Chore.t),
      updateWhere: updateWhere?.call(Chore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Chore] and returns the resulting row.
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
  /// The returned [Chore] will have its `id` field set.
  Future<Chore?> upsertRow(
    _isd.DatabaseSession session,
    Chore row, {
    required _isd.ColumnSelections<ChoreTable> conflictColumns,
    _isd.ColumnSelections<ChoreTable>? updateColumns,
    _isd.WhereExpressionBuilder<ChoreTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Chore>(
      row,
      conflictColumns: conflictColumns(Chore.t),
      updateColumns: updateColumns?.call(Chore.t),
      updateWhere: updateWhere?.call(Chore.t),
      transaction: transaction,
    );
  }

  /// Updates all [Chore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chore>> update(
    _isd.DatabaseSession session,
    List<Chore> rows, {
    _isd.ColumnSelections<ChoreTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Chore>(
      rows,
      columns: columns?.call(Chore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Chore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Chore> updateRow(
    _isd.DatabaseSession session,
    Chore row, {
    _isd.ColumnSelections<ChoreTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<Chore>(
      row,
      columns: columns?.call(Chore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Chore?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<Chore>(
      id,
      columnValues: columnValues(Chore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Chore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Chore>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<ChoreTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Chore>(
      columnValues: columnValues(Chore.t.updateTable),
      where: where(Chore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Chore]s in the list and returns the deleted rows.
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
  Future<List<Chore>> delete(
    _isd.DatabaseSession session,
    List<Chore> rows, {
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Chore>(
      rows,
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Chore].
  Future<Chore> deleteRow(
    _isd.DatabaseSession session,
    Chore row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Chore>(
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
  Future<List<Chore>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<ChoreTable> where,
    _isd.OrderByBuilder<ChoreTable>? orderBy,
    _isd.OrderByListBuilder<ChoreTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Chore>(
      where: where(Chore.t),
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Chore>(
      where: where?.call(Chore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Chore] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<ChoreTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Chore>(
      where: where(Chore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
