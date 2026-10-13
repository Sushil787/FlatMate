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

/// The app's offline cache: one row per read call whose answer is saved
/// in the mirrored tables. Only on the phone; a read without one has
/// nothing saved, even if some of its rows are there from other reads.
abstract class CachedRead
    implements _isd.TableRow<int?>, _isc.ProtocolSerialization {
  CachedRead._({
    this.id,
    required this.key,
    required this.savedAt,
  });

  factory CachedRead({
    int? id,
    required String key,
    required DateTime savedAt,
  }) = _CachedReadImpl;

  factory CachedRead.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedRead(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      savedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['savedAt'],
      ),
    );
  }

  static final t = CachedReadTable();

  static const db = CachedReadRepository._();

  @override
  int? id;

  /// The read call and its arguments, e.g. "turn:2026-10-01:2026-11-07".
  String key;

  DateTime savedAt;

  @override
  _isd.Table<int?> get table => t;

  /// Returns a shallow copy of this [CachedRead]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CachedRead copyWith({
    int? id,
    String? key,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedRead',
      if (id != null) 'id': id,
      'key': key,
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachedRead',
      if (id != null) 'id': id,
      'key': key,
      'savedAt': savedAt.toJson(),
    };
  }

  static CachedReadInclude include() {
    return CachedReadInclude._();
  }

  static CachedReadIncludeList includeList({
    _isd.WhereExpressionBuilder<CachedReadTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    CachedReadInclude? include,
  }) {
    return CachedReadIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachedReadImpl extends CachedRead {
  _CachedReadImpl({
    int? id,
    required String key,
    required DateTime savedAt,
  }) : super._(
         id: id,
         key: key,
         savedAt: savedAt,
       );

  /// Returns a shallow copy of this [CachedRead]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CachedRead copyWith({
    Object? id = _Undefined,
    String? key,
    DateTime? savedAt,
  }) {
    return CachedRead(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}

class CachedReadUpdateTable extends _isd.UpdateTable<CachedReadTable> {
  CachedReadUpdateTable(super.table);

  _isd.ColumnValue<String, String> key(String value) => _isd.ColumnValue(
    table.key,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> savedAt(DateTime value) =>
      _isd.ColumnValue(
        table.savedAt,
        value,
      );
}

class CachedReadTable extends _isd.Table<int?> {
  CachedReadTable({super.tableRelation}) : super(tableName: 'cached_read') {
    updateTable = CachedReadUpdateTable(this);
    key = _isd.ColumnString(
      'key',
      this,
    );
    savedAt = _isd.ColumnDateTime(
      'savedAt',
      this,
    );
  }

  late final CachedReadUpdateTable updateTable;

  /// The read call and its arguments, e.g. "turn:2026-10-01:2026-11-07".
  late final _isd.ColumnString key;

  late final _isd.ColumnDateTime savedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    key,
    savedAt,
  ];
}

class CachedReadInclude extends _isd.IncludeObject {
  CachedReadInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<int?> get table => CachedRead.t;
}

class CachedReadIncludeList extends _isd.IncludeList {
  CachedReadIncludeList._({
    _isd.WhereExpressionBuilder<CachedReadTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CachedRead.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<int?> get table => CachedRead.t;
}

class CachedReadRepository {
  const CachedReadRepository._();

  /// Returns a list of [CachedRead]s matching the given query parameters.
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
  Future<List<CachedRead>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedReadTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CachedRead>(
      where: where?.call(CachedRead.t),
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CachedRead] matching the given query parameters.
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
  Future<CachedRead?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedReadTable>? where,
    int? offset,
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CachedRead>(
      where: where?.call(CachedRead.t),
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CachedRead] by its [id] or null if no such row exists.
  Future<CachedRead?> findById(
    _isd.DatabaseSession session,
    int id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CachedRead>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CachedRead]s in the list and returns the inserted rows.
  ///
  /// The returned [CachedRead]s will have their `id` fields set.
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
  Future<List<CachedRead>> insert(
    _isd.DatabaseSession session,
    List<CachedRead> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CachedRead>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CachedRead] and returns the inserted row.
  ///
  /// The returned [CachedRead] will have its `id` field set.
  Future<CachedRead> insertRow(
    _isd.DatabaseSession session,
    CachedRead row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<CachedRead>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CachedRead]s in the list and returns the resulting rows.
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
  /// The returned [CachedRead]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedRead>> upsert(
    _isd.DatabaseSession session,
    List<CachedRead> rows, {
    required _isd.ColumnSelections<CachedReadTable> conflictColumns,
    _isd.ColumnSelections<CachedReadTable>? updateColumns,
    _isd.WhereExpressionBuilder<CachedReadTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CachedRead>(
      rows,
      conflictColumns: conflictColumns(CachedRead.t),
      updateColumns: updateColumns?.call(CachedRead.t),
      updateWhere: updateWhere?.call(CachedRead.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CachedRead] and returns the resulting row.
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
  /// The returned [CachedRead] will have its `id` field set.
  Future<CachedRead?> upsertRow(
    _isd.DatabaseSession session,
    CachedRead row, {
    required _isd.ColumnSelections<CachedReadTable> conflictColumns,
    _isd.ColumnSelections<CachedReadTable>? updateColumns,
    _isd.WhereExpressionBuilder<CachedReadTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CachedRead>(
      row,
      conflictColumns: conflictColumns(CachedRead.t),
      updateColumns: updateColumns?.call(CachedRead.t),
      updateWhere: updateWhere?.call(CachedRead.t),
      transaction: transaction,
    );
  }

  /// Updates all [CachedRead]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedRead>> update(
    _isd.DatabaseSession session,
    List<CachedRead> rows, {
    _isd.ColumnSelections<CachedReadTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CachedRead>(
      rows,
      columns: columns?.call(CachedRead.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CachedRead]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CachedRead> updateRow(
    _isd.DatabaseSession session,
    CachedRead row, {
    _isd.ColumnSelections<CachedReadTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<CachedRead>(
      row,
      columns: columns?.call(CachedRead.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CachedRead] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CachedRead?> updateById(
    _isd.DatabaseSession session,
    int id, {
    required _isd.ColumnValueListBuilder<CachedReadUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<CachedRead>(
      id,
      columnValues: columnValues(CachedRead.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CachedRead]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedRead>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<CachedReadUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<CachedReadTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CachedRead>(
      columnValues: columnValues(CachedRead.t.updateTable),
      where: where(CachedRead.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CachedRead]s in the list and returns the deleted rows.
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
  Future<List<CachedRead>> delete(
    _isd.DatabaseSession session,
    List<CachedRead> rows, {
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CachedRead>(
      rows,
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CachedRead].
  Future<CachedRead> deleteRow(
    _isd.DatabaseSession session,
    CachedRead row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CachedRead>(
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
  Future<List<CachedRead>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<CachedReadTable> where,
    _isd.OrderByBuilder<CachedReadTable>? orderBy,
    _isd.OrderByListBuilder<CachedReadTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CachedRead>(
      where: where(CachedRead.t),
      orderBy: orderBy?.call(CachedRead.t),
      orderByList: orderByList?.call(CachedRead.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedReadTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<CachedRead>(
      where: where?.call(CachedRead.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CachedRead] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<CachedReadTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CachedRead>(
      where: where(CachedRead.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
