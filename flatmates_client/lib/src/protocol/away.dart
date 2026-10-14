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

/// A period of whole days a Mate is not around to do Chores.
/// Days are stored as 12:00 UTC on that date (see day.dart).
abstract class Away
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  Away._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.startDay,
    required this.lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Away({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required DateTime startDay,
    required DateTime lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AwayImpl;

  factory Away.fromJson(Map<String, dynamic> jsonSerialization) {
    return Away(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      mateId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      startDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDay'],
      ),
      lastDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastDay'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AwayTable();

  static const db = AwayRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  _isc.UuidValue mateId;

  DateTime startDay;

  /// Inclusive.
  DateTime lastDay;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Away copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    DateTime? startDay,
    DateTime? lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'startDay': startDay.toJson(),
      'lastDay': lastDay.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'startDay': startDay.toJson(),
      'lastDay': lastDay.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AwayInclude include() {
    return AwayInclude._();
  }

  static AwayIncludeList includeList({
    _isd.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    AwayInclude? include,
  }) {
    return AwayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AwayImpl extends Away {
  _AwayImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required DateTime startDay,
    required DateTime lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         startDay: startDay,
         lastDay: lastDay,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Away copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    DateTime? startDay,
    DateTime? lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Away(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      startDay: startDay ?? this.startDay,
      lastDay: lastDay ?? this.lastDay,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AwayUpdateTable extends _isd.UpdateTable<AwayTable> {
  AwayUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> flatId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.flatId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> mateId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.mateId,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> startDay(DateTime value) =>
      _isd.ColumnValue(
        table.startDay,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> lastDay(DateTime value) =>
      _isd.ColumnValue(
        table.lastDay,
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

class AwayTable extends _isd.Table<_isc.UuidValue?> {
  AwayTable({super.tableRelation}) : super(tableName: 'away') {
    updateTable = AwayUpdateTable(this);
    flatId = _isd.ColumnUuid(
      'flatId',
      this,
    );
    mateId = _isd.ColumnUuid(
      'mateId',
      this,
    );
    startDay = _isd.ColumnDateTime(
      'startDay',
      this,
    );
    lastDay = _isd.ColumnDateTime(
      'lastDay',
      this,
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

  late final AwayUpdateTable updateTable;

  late final _isd.ColumnUuid flatId;

  late final _isd.ColumnUuid mateId;

  late final _isd.ColumnDateTime startDay;

  /// Inclusive.
  late final _isd.ColumnDateTime lastDay;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    flatId,
    mateId,
    startDay,
    lastDay,
    createdAt,
    updatedAt,
  ];
}

class AwayInclude extends _isd.IncludeObject {
  AwayInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Away.t;
}

class AwayIncludeList extends _isd.IncludeList {
  AwayIncludeList._({
    _isd.WhereExpressionBuilder<AwayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Away.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Away.t;
}

class AwayRepository {
  const AwayRepository._();

  /// Returns a list of [Away]s matching the given query parameters.
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
  Future<List<Away>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Away>(
      where: where?.call(Away.t),
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Away] matching the given query parameters.
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
  Future<Away?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<AwayTable>? where,
    int? offset,
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Away>(
      where: where?.call(Away.t),
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Away] by its [id] or null if no such row exists.
  Future<Away?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Away>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Away]s in the list and returns the inserted rows.
  ///
  /// The returned [Away]s will have their `id` fields set.
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
  Future<List<Away>> insert(
    _isd.DatabaseSession session,
    List<Away> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Away>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Away] and returns the inserted row.
  ///
  /// The returned [Away] will have its `id` field set.
  Future<Away> insertRow(
    _isd.DatabaseSession session,
    Away row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<Away>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Away]s in the list and returns the resulting rows.
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
  /// The returned [Away]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Away>> upsert(
    _isd.DatabaseSession session,
    List<Away> rows, {
    required _isd.ColumnSelections<AwayTable> conflictColumns,
    _isd.ColumnSelections<AwayTable>? updateColumns,
    _isd.WhereExpressionBuilder<AwayTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Away>(
      rows,
      conflictColumns: conflictColumns(Away.t),
      updateColumns: updateColumns?.call(Away.t),
      updateWhere: updateWhere?.call(Away.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Away] and returns the resulting row.
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
  /// The returned [Away] will have its `id` field set.
  Future<Away?> upsertRow(
    _isd.DatabaseSession session,
    Away row, {
    required _isd.ColumnSelections<AwayTable> conflictColumns,
    _isd.ColumnSelections<AwayTable>? updateColumns,
    _isd.WhereExpressionBuilder<AwayTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Away>(
      row,
      conflictColumns: conflictColumns(Away.t),
      updateColumns: updateColumns?.call(Away.t),
      updateWhere: updateWhere?.call(Away.t),
      transaction: transaction,
    );
  }

  /// Updates all [Away]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Away>> update(
    _isd.DatabaseSession session,
    List<Away> rows, {
    _isd.ColumnSelections<AwayTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Away>(
      rows,
      columns: columns?.call(Away.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Away]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Away> updateRow(
    _isd.DatabaseSession session,
    Away row, {
    _isd.ColumnSelections<AwayTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<Away>(
      row,
      columns: columns?.call(Away.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Away] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Away?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<AwayUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<Away>(
      id,
      columnValues: columnValues(Away.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Away]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Away>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<AwayUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<AwayTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Away>(
      columnValues: columnValues(Away.t.updateTable),
      where: where(Away.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Away]s in the list and returns the deleted rows.
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
  Future<List<Away>> delete(
    _isd.DatabaseSession session,
    List<Away> rows, {
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Away>(
      rows,
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Away].
  Future<Away> deleteRow(
    _isd.DatabaseSession session,
    Away row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Away>(
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
  Future<List<Away>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<AwayTable> where,
    _isd.OrderByBuilder<AwayTable>? orderBy,
    _isd.OrderByListBuilder<AwayTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Away>(
      where: where(Away.t),
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Away>(
      where: where?.call(Away.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Away] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<AwayTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Away>(
      where: where(Away.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
