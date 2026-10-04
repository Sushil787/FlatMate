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
import 'package:serverpod/serverpod.dart' as _is;
import 'turn_status.dart' as _i5yk6qf9;

/// One Mate's responsibility for a Chore for one day.
abstract class Turn implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Turn._({
    this.id,
    required this.flatId,
    required this.choreId,
    required this.mateId,
    this.coveringForMateId,
    required this.day,
    required this.lastDay,
    required this.status,
    this.doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Turn({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime day,
    required DateTime lastDay,
    required _i5yk6qf9.TurnStatus status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TurnImpl;

  factory Turn.fromJson(Map<String, dynamic> jsonSerialization) {
    return Turn(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      choreId: jsonSerialization['choreId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      coveringForMateId: jsonSerialization['coveringForMateId'] as int?,
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      lastDay: _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastDay']),
      status: _i5yk6qf9.TurnStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = TurnTable();

  static const db = TurnRepository._();

  @override
  int? id;

  int flatId;

  int choreId;

  int mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  int? coveringForMateId;

  /// The Turn's day (12:00 UTC on that date, see day.dart).
  DateTime day;

  /// Inclusive; later than [day] only when Pause extended the Turn.
  DateTime lastDay;

  _i5yk6qf9.TurnStatus status;

  DateTime? doneAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Turn copyWith({
    int? id,
    int? flatId,
    int? choreId,
    int? mateId,
    int? coveringForMateId,
    DateTime? day,
    DateTime? lastDay,
    _i5yk6qf9.TurnStatus? status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id,
      'flatId': flatId,
      'choreId': choreId,
      'mateId': mateId,
      if (coveringForMateId != null) 'coveringForMateId': coveringForMateId,
      'day': day.toJson(),
      'lastDay': lastDay.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id,
      'flatId': flatId,
      'choreId': choreId,
      'mateId': mateId,
      if (coveringForMateId != null) 'coveringForMateId': coveringForMateId,
      'day': day.toJson(),
      'lastDay': lastDay.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static TurnInclude include() {
    return TurnInclude._();
  }

  static TurnIncludeList includeList({
    _is.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    TurnInclude? include,
  }) {
    return TurnIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TurnImpl extends Turn {
  _TurnImpl({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime day,
    required DateTime lastDay,
    required _i5yk6qf9.TurnStatus status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         choreId: choreId,
         mateId: mateId,
         coveringForMateId: coveringForMateId,
         day: day,
         lastDay: lastDay,
         status: status,
         doneAt: doneAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Turn copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? choreId,
    int? mateId,
    Object? coveringForMateId = _Undefined,
    DateTime? day,
    DateTime? lastDay,
    _i5yk6qf9.TurnStatus? status,
    Object? doneAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Turn(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      choreId: choreId ?? this.choreId,
      mateId: mateId ?? this.mateId,
      coveringForMateId: coveringForMateId is int?
          ? coveringForMateId
          : this.coveringForMateId,
      day: day ?? this.day,
      lastDay: lastDay ?? this.lastDay,
      status: status ?? this.status,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TurnUpdateTable extends _is.UpdateTable<TurnTable> {
  TurnUpdateTable(super.table);

  _is.ColumnValue<int, int> flatId(int value) => _is.ColumnValue(
    table.flatId,
    value,
  );

  _is.ColumnValue<int, int> choreId(int value) => _is.ColumnValue(
    table.choreId,
    value,
  );

  _is.ColumnValue<int, int> mateId(int value) => _is.ColumnValue(
    table.mateId,
    value,
  );

  _is.ColumnValue<int, int> coveringForMateId(int? value) => _is.ColumnValue(
    table.coveringForMateId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> day(DateTime value) => _is.ColumnValue(
    table.day,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastDay(DateTime value) =>
      _is.ColumnValue(
        table.lastDay,
        value,
      );

  _is.ColumnValue<_i5yk6qf9.TurnStatus, _i5yk6qf9.TurnStatus> status(
    _i5yk6qf9.TurnStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> doneAt(DateTime? value) =>
      _is.ColumnValue(
        table.doneAt,
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

class TurnTable extends _is.Table<int?> {
  TurnTable({super.tableRelation}) : super(tableName: 'turn') {
    updateTable = TurnUpdateTable(this);
    flatId = _is.ColumnInt(
      'flatId',
      this,
    );
    choreId = _is.ColumnInt(
      'choreId',
      this,
    );
    mateId = _is.ColumnInt(
      'mateId',
      this,
    );
    coveringForMateId = _is.ColumnInt(
      'coveringForMateId',
      this,
    );
    day = _is.ColumnDateTime(
      'day',
      this,
    );
    lastDay = _is.ColumnDateTime(
      'lastDay',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    doneAt = _is.ColumnDateTime(
      'doneAt',
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

  late final TurnUpdateTable updateTable;

  late final _is.ColumnInt flatId;

  late final _is.ColumnInt choreId;

  late final _is.ColumnInt mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  late final _is.ColumnInt coveringForMateId;

  /// The Turn's day (12:00 UTC on that date, see day.dart).
  late final _is.ColumnDateTime day;

  /// Inclusive; later than [day] only when Pause extended the Turn.
  late final _is.ColumnDateTime lastDay;

  late final _is.ColumnEnum<_i5yk6qf9.TurnStatus> status;

  late final _is.ColumnDateTime doneAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    flatId,
    choreId,
    mateId,
    coveringForMateId,
    day,
    lastDay,
    status,
    doneAt,
    createdAt,
    updatedAt,
  ];
}

class TurnInclude extends _is.IncludeObject {
  TurnInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Turn.t;
}

class TurnIncludeList extends _is.IncludeList {
  TurnIncludeList._({
    _is.WhereExpressionBuilder<TurnTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Turn.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Turn.t;
}

class TurnRepository {
  const TurnRepository._();

  /// Returns a list of [Turn]s matching the given query parameters.
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
  Future<List<Turn>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Turn>(
      where: where?.call(Turn.t),
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Turn] matching the given query parameters.
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
  Future<Turn?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TurnTable>? where,
    int? offset,
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Turn>(
      where: where?.call(Turn.t),
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Turn] by its [id] or null if no such row exists.
  Future<Turn?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Turn>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Turn]s in the list and returns the inserted rows.
  ///
  /// The returned [Turn]s will have their `id` fields set.
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
  Future<List<Turn>> insert(
    _is.DatabaseSession session,
    List<Turn> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Turn>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Turn] and returns the inserted row.
  ///
  /// The returned [Turn] will have its `id` field set.
  Future<Turn> insertRow(
    _is.DatabaseSession session,
    Turn row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Turn>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Turn]s in the list and returns the resulting rows.
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
  /// The returned [Turn]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Turn>> upsert(
    _is.DatabaseSession session,
    List<Turn> rows, {
    required _is.ColumnSelections<TurnTable> conflictColumns,
    _is.ColumnSelections<TurnTable>? updateColumns,
    _is.WhereExpressionBuilder<TurnTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Turn>(
      rows,
      conflictColumns: conflictColumns(Turn.t),
      updateColumns: updateColumns?.call(Turn.t),
      updateWhere: updateWhere?.call(Turn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Turn] and returns the resulting row.
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
  /// The returned [Turn] will have its `id` field set.
  Future<Turn?> upsertRow(
    _is.DatabaseSession session,
    Turn row, {
    required _is.ColumnSelections<TurnTable> conflictColumns,
    _is.ColumnSelections<TurnTable>? updateColumns,
    _is.WhereExpressionBuilder<TurnTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Turn>(
      row,
      conflictColumns: conflictColumns(Turn.t),
      updateColumns: updateColumns?.call(Turn.t),
      updateWhere: updateWhere?.call(Turn.t),
      transaction: transaction,
    );
  }

  /// Updates all [Turn]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Turn>> update(
    _is.DatabaseSession session,
    List<Turn> rows, {
    _is.ColumnSelections<TurnTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Turn>(
      rows,
      columns: columns?.call(Turn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Turn]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Turn> updateRow(
    _is.DatabaseSession session,
    Turn row, {
    _is.ColumnSelections<TurnTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Turn>(
      row,
      columns: columns?.call(Turn.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Turn] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Turn?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TurnUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Turn>(
      id,
      columnValues: columnValues(Turn.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Turn]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Turn>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TurnUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TurnTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Turn>(
      columnValues: columnValues(Turn.t.updateTable),
      where: where(Turn.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Turn]s in the list and returns the deleted rows.
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
  Future<List<Turn>> delete(
    _is.DatabaseSession session,
    List<Turn> rows, {
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Turn>(
      rows,
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Turn].
  Future<Turn> deleteRow(
    _is.DatabaseSession session,
    Turn row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Turn>(
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
  Future<List<Turn>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TurnTable> where,
    _is.OrderByBuilder<TurnTable>? orderBy,
    _is.OrderByListBuilder<TurnTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Turn>(
      where: where(Turn.t),
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Turn>(
      where: where?.call(Turn.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Turn] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TurnTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Turn>(
      where: where(Turn.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
