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

/// A Turn owed back under the Swap rule: [debtorMateId] takes [creditorMateId]'s next Turn.
abstract class SwapDebt
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SwapDebt._({
    this.id,
    required this.choreId,
    required this.debtorMateId,
    required this.creditorMateId,
    required this.createdAt,
  });

  factory SwapDebt({
    int? id,
    required int choreId,
    required int debtorMateId,
    required int creditorMateId,
    required DateTime createdAt,
  }) = _SwapDebtImpl;

  factory SwapDebt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapDebt(
      id: jsonSerialization['id'] as int?,
      choreId: jsonSerialization['choreId'] as int,
      debtorMateId: jsonSerialization['debtorMateId'] as int,
      creditorMateId: jsonSerialization['creditorMateId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SwapDebtTable();

  static const db = SwapDebtRepository._();

  @override
  int? id;

  int choreId;

  int debtorMateId;

  int creditorMateId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SwapDebt copyWith({
    int? id,
    int? choreId,
    int? debtorMateId,
    int? creditorMateId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id,
      'choreId': choreId,
      'debtorMateId': debtorMateId,
      'creditorMateId': creditorMateId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id,
      'choreId': choreId,
      'debtorMateId': debtorMateId,
      'creditorMateId': creditorMateId,
      'createdAt': createdAt.toJson(),
    };
  }

  static SwapDebtInclude include() {
    return SwapDebtInclude._();
  }

  static SwapDebtIncludeList includeList({
    _i1.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwapDebtTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwapDebtTable>? orderByList,
    SwapDebtInclude? include,
  }) {
    return SwapDebtIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapDebt.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SwapDebt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapDebtImpl extends SwapDebt {
  _SwapDebtImpl({
    int? id,
    required int choreId,
    required int debtorMateId,
    required int creditorMateId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         choreId: choreId,
         debtorMateId: debtorMateId,
         creditorMateId: creditorMateId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SwapDebt copyWith({
    Object? id = _Undefined,
    int? choreId,
    int? debtorMateId,
    int? creditorMateId,
    DateTime? createdAt,
  }) {
    return SwapDebt(
      id: id is int? ? id : this.id,
      choreId: choreId ?? this.choreId,
      debtorMateId: debtorMateId ?? this.debtorMateId,
      creditorMateId: creditorMateId ?? this.creditorMateId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SwapDebtUpdateTable extends _i1.UpdateTable<SwapDebtTable> {
  SwapDebtUpdateTable(super.table);

  _i1.ColumnValue<int, int> choreId(int value) => _i1.ColumnValue(
    table.choreId,
    value,
  );

  _i1.ColumnValue<int, int> debtorMateId(int value) => _i1.ColumnValue(
    table.debtorMateId,
    value,
  );

  _i1.ColumnValue<int, int> creditorMateId(int value) => _i1.ColumnValue(
    table.creditorMateId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SwapDebtTable extends _i1.Table<int?> {
  SwapDebtTable({super.tableRelation}) : super(tableName: 'swap_debt') {
    updateTable = SwapDebtUpdateTable(this);
    choreId = _i1.ColumnInt(
      'choreId',
      this,
    );
    debtorMateId = _i1.ColumnInt(
      'debtorMateId',
      this,
    );
    creditorMateId = _i1.ColumnInt(
      'creditorMateId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SwapDebtUpdateTable updateTable;

  late final _i1.ColumnInt choreId;

  late final _i1.ColumnInt debtorMateId;

  late final _i1.ColumnInt creditorMateId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    choreId,
    debtorMateId,
    creditorMateId,
    createdAt,
  ];
}

class SwapDebtInclude extends _i1.IncludeObject {
  SwapDebtInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SwapDebt.t;
}

class SwapDebtIncludeList extends _i1.IncludeList {
  SwapDebtIncludeList._({
    _i1.WhereExpressionBuilder<SwapDebtTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwapDebt.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SwapDebt.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwapDebtTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwapDebtTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SwapDebt>(
      where: where?.call(SwapDebt.t),
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwapDebtTable>? where,
    int? offset,
    _i1.OrderByBuilder<SwapDebtTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwapDebtTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SwapDebt>(
      where: where?.call(SwapDebt.t),
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SwapDebt] by its [id] or null if no such row exists.
  Future<SwapDebt?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<SwapDebt>> insert(
    _i1.DatabaseSession session,
    List<SwapDebt> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SwapDebt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SwapDebt] and returns the inserted row.
  ///
  /// The returned [SwapDebt] will have its `id` field set.
  Future<SwapDebt> insertRow(
    _i1.DatabaseSession session,
    SwapDebt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SwapDebt>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SwapDebt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SwapDebt>> update(
    _i1.DatabaseSession session,
    List<SwapDebt> rows, {
    _i1.ColumnSelections<SwapDebtTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SwapDebt>(
      rows,
      columns: columns?.call(SwapDebt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SwapDebt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SwapDebt> updateRow(
    _i1.DatabaseSession session,
    SwapDebt row, {
    _i1.ColumnSelections<SwapDebtTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SwapDebt>(
      id,
      columnValues: columnValues(SwapDebt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SwapDebt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SwapDebt>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SwapDebtUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SwapDebtTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwapDebtTable>? orderBy,
    _i1.OrderByListBuilder<SwapDebtTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SwapDebt>(
      columnValues: columnValues(SwapDebt.t.updateTable),
      where: where(SwapDebt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapDebt.t),
      orderByList: orderByList?.call(SwapDebt.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SwapDebt]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SwapDebt>> delete(
    _i1.DatabaseSession session,
    List<SwapDebt> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SwapDebt>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SwapDebt].
  Future<SwapDebt> deleteRow(
    _i1.DatabaseSession session,
    SwapDebt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SwapDebt>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SwapDebt>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SwapDebtTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SwapDebt>(
      where: where(SwapDebt.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwapDebtTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SwapDebt>(
      where: where?.call(SwapDebt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwapDebt] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SwapDebtTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwapDebt>(
      where: where(SwapDebt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
