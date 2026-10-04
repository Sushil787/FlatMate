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
import 'package:flatmates_server/src/generated/protocol.dart' as _ikjds9rx;
import 'package:serverpod/serverpod.dart' as _is;

/// A recurring responsibility passed round-robin through [rotation].
abstract class Chore implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Chore._({
    this.id,
    required this.flatId,
    required this.name,
    required this.period,
    required this.startDay,
    required this.rotation,
    required this.rotationIndex,
    required this.archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Chore({
    int? id,
    required int flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<int> rotation,
    required int rotationIndex,
    required bool archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChoreImpl;

  factory Chore.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chore(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      name: jsonSerialization['name'] as String,
      period: _is.DurationJsonExtension.fromJson(jsonSerialization['period']),
      startDay: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDay'],
      ),
      rotation: _ikjds9rx.Protocol().deserialize<List<int>>(
        jsonSerialization['rotation'],
      ),
      rotationIndex: jsonSerialization['rotationIndex'] as int,
      archived: _is.BoolJsonExtension.fromJson(jsonSerialization['archived']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChoreTable();

  static const db = ChoreRepository._();

  @override
  int? id;

  int flatId;

  String name;

  /// Rotation period: time from one Turn's start to the next, whole days.
  Duration period;

  /// The day of the first Turn (12:00 UTC on that date, see day.dart).
  DateTime startDay;

  /// Mate ids in order; a Mate may appear more than once.
  List<int> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  int rotationIndex;

  bool archived;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Chore copyWith({
    int? id,
    int? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<int>? rotation,
    int? rotationIndex,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(),
      'rotationIndex': rotationIndex,
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(),
      'rotationIndex': rotationIndex,
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChoreInclude include() {
    return ChoreInclude._();
  }

  static ChoreIncludeList includeList({
    _is.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoreImpl extends Chore {
  _ChoreImpl({
    int? id,
    required int flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<int> rotation,
    required int rotationIndex,
    required bool archived,
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
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Chore copyWith({
    Object? id = _Undefined,
    int? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<int>? rotation,
    int? rotationIndex,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chore(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      period: period ?? this.period,
      startDay: startDay ?? this.startDay,
      rotation: rotation ?? this.rotation.map((e0) => e0).toList(),
      rotationIndex: rotationIndex ?? this.rotationIndex,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChoreUpdateTable extends _is.UpdateTable<ChoreTable> {
  ChoreUpdateTable(super.table);

  _is.ColumnValue<int, int> flatId(int value) => _is.ColumnValue(
    table.flatId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<Duration, Duration> period(Duration value) => _is.ColumnValue(
    table.period,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startDay(DateTime value) =>
      _is.ColumnValue(
        table.startDay,
        value,
      );

  _is.ColumnValue<List<int>, List<int>> rotation(List<int> value) =>
      _is.ColumnValue(
        table.rotation,
        value,
      );

  _is.ColumnValue<int, int> rotationIndex(int value) => _is.ColumnValue(
    table.rotationIndex,
    value,
  );

  _is.ColumnValue<bool, bool> archived(bool value) => _is.ColumnValue(
    table.archived,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ChoreTable extends _is.Table<int?> {
  ChoreTable({super.tableRelation}) : super(tableName: 'chore') {
    updateTable = ChoreUpdateTable(this);
    flatId = _is.ColumnInt(
      'flatId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    period = _is.ColumnDuration(
      'period',
      this,
    );
    startDay = _is.ColumnDateTime(
      'startDay',
      this,
    );
    rotation = _is.ColumnSerializable<List<int>>(
      'rotation',
      this,
    );
    rotationIndex = _is.ColumnInt(
      'rotationIndex',
      this,
    );
    archived = _is.ColumnBool(
      'archived',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ChoreUpdateTable updateTable;

  late final _is.ColumnInt flatId;

  late final _is.ColumnString name;

  /// Rotation period: time from one Turn's start to the next, whole days.
  late final _is.ColumnDuration period;

  /// The day of the first Turn (12:00 UTC on that date, see day.dart).
  late final _is.ColumnDateTime startDay;

  /// Mate ids in order; a Mate may appear more than once.
  late final _is.ColumnSerializable<List<int>> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  late final _is.ColumnInt rotationIndex;

  late final _is.ColumnBool archived;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    flatId,
    name,
    period,
    startDay,
    rotation,
    rotationIndex,
    archived,
    createdAt,
    updatedAt,
  ];
}

class ChoreInclude extends _is.IncludeObject {
  ChoreInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Chore.t;
}

class ChoreIncludeList extends _is.IncludeList {
  ChoreIncludeList._({
    _is.WhereExpressionBuilder<ChoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chore.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Chore.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoreTable>? where,
    int? offset,
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    List<Chore> rows, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    Chore row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<Chore> rows, {
    required _is.ColumnSelections<ChoreTable> conflictColumns,
    _is.ColumnSelections<ChoreTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoreTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    Chore row, {
    required _is.ColumnSelections<ChoreTable> conflictColumns,
    _is.ColumnSelections<ChoreTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoreTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<Chore> rows, {
    _is.ColumnSelections<ChoreTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    Chore row, {
    _is.ColumnSelections<ChoreTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ChoreTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<Chore> rows, {
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    Chore row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoreTable> where,
    _is.OrderByBuilder<ChoreTable>? orderBy,
    _is.OrderByListBuilder<ChoreTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Chore>(
      where: where?.call(Chore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Chore] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoreTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Chore>(
      where: where(Chore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
