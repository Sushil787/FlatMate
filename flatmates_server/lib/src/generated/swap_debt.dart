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

/// A Turn owed back under the Swap rule: [debtorMateId] takes [creditorMateId]'s next Turn.
abstract class SwapDebt
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
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
    _is.UuidValue? id,
    required _is.UuidValue choreId,
    required _is.UuidValue debtorMateId,
    required _is.UuidValue creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SwapDebtImpl;

  factory SwapDebt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapDebt(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      choreId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['choreId'],
      ),
      debtorMateId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['debtorMateId'],
      ),
      creditorMateId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['creditorMateId'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SwapDebtTable();

  static const db = SwapDebtRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue choreId;

  _is.UuidValue debtorMateId;

  _is.UuidValue creditorMateId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SwapDebt copyWith({
    _is.UuidValue? id,
    _is.UuidValue? choreId,
    _is.UuidValue? debtorMateId,
    _is.UuidValue? creditorMateId,
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
    _is.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapDebtImpl extends SwapDebt {
  _SwapDebtImpl({
    _is.UuidValue? id,
    required _is.UuidValue choreId,
    required _is.UuidValue debtorMateId,
    required _is.UuidValue creditorMateId,
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
  @_is.useResult
  @override
  SwapDebt copyWith({
    Object? id = _Undefined,
    _is.UuidValue? choreId,
    _is.UuidValue? debtorMateId,
    _is.UuidValue? creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SwapDebt(
      id: id is _is.UuidValue? ? id : this.id,
      choreId: choreId ?? this.choreId,
      debtorMateId: debtorMateId ?? this.debtorMateId,
      creditorMateId: creditorMateId ?? this.creditorMateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SwapDebtUpdateTable extends _is.UpdateTable<SwapDebtTable> {
  SwapDebtUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> choreId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.choreId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> debtorMateId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.debtorMateId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> creditorMateId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.creditorMateId,
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

class SwapDebtTable extends _is.Table<_is.UuidValue?> {
  SwapDebtTable({super.tableRelation}) : super(tableName: 'swap_debt') {
    updateTable = SwapDebtUpdateTable(this);
    choreId = _is.ColumnUuid(
      'choreId',
      this,
    );
    debtorMateId = _is.ColumnUuid(
      'debtorMateId',
      this,
    );
    creditorMateId = _is.ColumnUuid(
      'creditorMateId',
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

  late final SwapDebtUpdateTable updateTable;

  late final _is.ColumnUuid choreId;

  late final _is.ColumnUuid debtorMateId;

  late final _is.ColumnUuid creditorMateId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    choreId,
    debtorMateId,
    creditorMateId,
    createdAt,
    updatedAt,
  ];
}

class SwapDebtInclude extends _is.IncludeObject {
  SwapDebtInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => SwapDebt.t;
}

class SwapDebtIncludeList extends _is.IncludeList {
  SwapDebtIncludeList._({
    _is.WhereExpressionBuilder<SwapDebtTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwapDebt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => SwapDebt.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapDebtTable>? where,
    int? offset,
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    List<SwapDebt> rows, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    SwapDebt row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<SwapDebt> rows, {
    required _is.ColumnSelections<SwapDebtTable> conflictColumns,
    _is.ColumnSelections<SwapDebtTable>? updateColumns,
    _is.WhereExpressionBuilder<SwapDebtTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    SwapDebt row, {
    required _is.ColumnSelections<SwapDebtTable> conflictColumns,
    _is.ColumnSelections<SwapDebtTable>? updateColumns,
    _is.WhereExpressionBuilder<SwapDebtTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<SwapDebt> rows, {
    _is.ColumnSelections<SwapDebtTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    SwapDebt row, {
    _is.ColumnSelections<SwapDebtTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SwapDebtTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<SwapDebt> rows, {
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    SwapDebt row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwapDebtTable> where,
    _is.OrderByBuilder<SwapDebtTable>? orderBy,
    _is.OrderByListBuilder<SwapDebtTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SwapDebt>(
      where: where?.call(SwapDebt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwapDebt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwapDebtTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwapDebt>(
      where: where(SwapDebt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
