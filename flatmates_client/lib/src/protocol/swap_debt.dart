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

/// A Turn owed back under the Swap rule: [debtorMateId] takes [creditorMateId]'s next Turn.
abstract class SwapDebt
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  SwapDebt._({
    this.id,
    required this.choreId,
    required this.debtorMateId,
    required this.creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SwapDebt({
    _isc.UuidValue? id,
    required _isc.UuidValue choreId,
    required _isc.UuidValue debtorMateId,
    required _isc.UuidValue creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SwapDebtImpl;

  factory SwapDebt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapDebt(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      choreId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['choreId'],
      ),
      debtorMateId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['debtorMateId'],
      ),
      creditorMateId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['creditorMateId'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SwapDebtTable();

  static const db = SwapDebtRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue choreId;

  _isc.UuidValue debtorMateId;

  _isc.UuidValue creditorMateId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SwapDebt copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? choreId,
    _isc.UuidValue? debtorMateId,
    _isc.UuidValue? creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id?.toJson(),
      'choreId': choreId.toJson(),
      'debtorMateId': debtorMateId.toJson(),
      'creditorMateId': creditorMateId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id?.toJson(),
      'choreId': choreId.toJson(),
      'debtorMateId': debtorMateId.toJson(),
      'creditorMateId': creditorMateId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SwapDebtInclude include() {
    return SwapDebtInclude._();
  }

  static SwapDebtIncludeList includeList({
    _isd.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    SwapDebtInclude? include,
  }) {
    return SwapDebtIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapDebtImpl extends SwapDebt {
  _SwapDebtImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue choreId,
    required _isc.UuidValue debtorMateId,
    required _isc.UuidValue creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         choreId: choreId,
         debtorMateId: debtorMateId,
         creditorMateId: creditorMateId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SwapDebt copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? choreId,
    _isc.UuidValue? debtorMateId,
    _isc.UuidValue? creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SwapDebt(
      id: id is _isc.UuidValue? ? id : this.id,
      choreId: choreId ?? this.choreId,
      debtorMateId: debtorMateId ?? this.debtorMateId,
      creditorMateId: creditorMateId ?? this.creditorMateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SwapDebtUpdateTable extends _isd.UpdateTable<SwapDebtTable> {
  SwapDebtUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> choreId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.choreId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> debtorMateId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.debtorMateId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> creditorMateId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.creditorMateId,
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

class SwapDebtTable extends _isd.Table<_isc.UuidValue?> {
  SwapDebtTable({super.tableRelation}) : super(tableName: 'swap_debt') {
    updateTable = SwapDebtUpdateTable(this);
    choreId = _isd.ColumnUuid(
      'choreId',
      this,
    );
    debtorMateId = _isd.ColumnUuid(
      'debtorMateId',
      this,
    );
    creditorMateId = _isd.ColumnUuid(
      'creditorMateId',
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

  late final SwapDebtUpdateTable updateTable;

  late final _isd.ColumnUuid choreId;

  late final _isd.ColumnUuid debtorMateId;

  late final _isd.ColumnUuid creditorMateId;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    choreId,
    debtorMateId,
    creditorMateId,
    createdAt,
    updatedAt,
  ];
}

class SwapDebtInclude extends _isd.IncludeObject {
  SwapDebtInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => SwapDebt.t;
}

class SwapDebtIncludeList extends _isd.IncludeList {
  SwapDebtIncludeList._({
    _isd.WhereExpressionBuilder<SwapDebtTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwapDebt.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => SwapDebt.t;
}

class SwapDebtRepository {
  const SwapDebtRepository._();

  /// Returns a list of [SwapDebt]s matching the given query parameters.
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
  Future<List<SwapDebt>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SwapDebt>(
      where: where?.call(SwapDebt.t),
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SwapDebt] matching the given query parameters.
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
  Future<SwapDebt?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<SwapDebtTable>? where,
    int? offset,
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SwapDebt>(
      where: where?.call(SwapDebt.t),
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SwapDebt] by its [id] or null if no such row exists.
  Future<SwapDebt?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SwapDebt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SwapDebt]s in the list and returns the inserted rows.
  ///
  /// The returned [SwapDebt]s will have their `id` fields set.
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
  Future<List<SwapDebt>> insert(
    _isd.DatabaseSession session,
    List<SwapDebt> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SwapDebt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SwapDebt] and returns the inserted row.
  ///
  /// The returned [SwapDebt] will have its `id` field set.
  Future<SwapDebt> insertRow(
    _isd.DatabaseSession session,
    SwapDebt row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<SwapDebt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SwapDebt]s in the list and returns the resulting rows.
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
  /// The returned [SwapDebt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapDebt>> upsert(
    _isd.DatabaseSession session,
    List<SwapDebt> rows, {
    required _isd.ColumnSelections<SwapDebtTable> conflictColumns,
    _isd.ColumnSelections<SwapDebtTable>? updateColumns,
    _isd.WhereExpressionBuilder<SwapDebtTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SwapDebt>(
      rows,
      conflictColumns: conflictColumns(SwapDebt.t),
      updateColumns: updateColumns?.call(SwapDebt.t),
      updateWhere: updateWhere?.call(SwapDebt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SwapDebt] and returns the resulting row.
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
  /// The returned [SwapDebt] will have its `id` field set.
  Future<SwapDebt?> upsertRow(
    _isd.DatabaseSession session,
    SwapDebt row, {
    required _isd.ColumnSelections<SwapDebtTable> conflictColumns,
    _isd.ColumnSelections<SwapDebtTable>? updateColumns,
    _isd.WhereExpressionBuilder<SwapDebtTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SwapDebt>(
      row,
      conflictColumns: conflictColumns(SwapDebt.t),
      updateColumns: updateColumns?.call(SwapDebt.t),
      updateWhere: updateWhere?.call(SwapDebt.t),
      transaction: transaction,
    );
  }

  /// Updates all [SwapDebt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapDebt>> update(
    _isd.DatabaseSession session,
    List<SwapDebt> rows, {
    _isd.ColumnSelections<SwapDebtTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SwapDebt>(
      rows,
      columns: columns?.call(SwapDebt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SwapDebt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SwapDebt> updateRow(
    _isd.DatabaseSession session,
    SwapDebt row, {
    _isd.ColumnSelections<SwapDebtTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<SwapDebt>(
      row,
      columns: columns?.call(SwapDebt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SwapDebt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SwapDebt?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<SwapDebt>(
      id,
      columnValues: columnValues(SwapDebt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SwapDebt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapDebt>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<SwapDebtTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SwapDebt>(
      columnValues: columnValues(SwapDebt.t.updateTable),
      where: where(SwapDebt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SwapDebt]s in the list and returns the deleted rows.
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
  Future<List<SwapDebt>> delete(
    _isd.DatabaseSession session,
    List<SwapDebt> rows, {
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SwapDebt>(
      rows,
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SwapDebt].
  Future<SwapDebt> deleteRow(
    _isd.DatabaseSession session,
    SwapDebt row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SwapDebt>(
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
  Future<List<SwapDebt>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<SwapDebtTable> where,
    _isd.OrderByBuilder<SwapDebtTable>? orderBy,
    _isd.OrderByListBuilder<SwapDebtTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SwapDebt>(
      where: where(SwapDebt.t),
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<SwapDebt>(
      where: where?.call(SwapDebt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwapDebt] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<SwapDebtTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwapDebt>(
      where: where(SwapDebt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
