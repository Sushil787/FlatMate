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

/// A Mate saying "Got it" on a Notice: they've read it.
abstract class NoticeGotIt
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  NoticeGotIt._({
    this.id,
    required this.noticeId,
    required this.mateId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NoticeGotIt({
    _isc.UuidValue? id,
    required _isc.UuidValue noticeId,
    required _isc.UuidValue mateId,
    DateTime? createdAt,
  }) = _NoticeGotItImpl;

  factory NoticeGotIt.fromJson(Map<String, dynamic> jsonSerialization) {
    return NoticeGotIt(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      noticeId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['noticeId'],
      ),
      mateId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = NoticeGotItTable();

  static const db = NoticeGotItRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue noticeId;

  _isc.UuidValue mateId;

  DateTime createdAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NoticeGotIt copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? noticeId,
    _isc.UuidValue? mateId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NoticeGotIt',
      if (id != null) 'id': id?.toJson(),
      'noticeId': noticeId.toJson(),
      'mateId': mateId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NoticeGotIt',
      if (id != null) 'id': id?.toJson(),
      'noticeId': noticeId.toJson(),
      'mateId': mateId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static NoticeGotItInclude include() {
    return NoticeGotItInclude._();
  }

  static NoticeGotItIncludeList includeList({
    _isd.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    NoticeGotItInclude? include,
  }) {
    return NoticeGotItIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NoticeGotItImpl extends NoticeGotIt {
  _NoticeGotItImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue noticeId,
    required _isc.UuidValue mateId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         noticeId: noticeId,
         mateId: mateId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NoticeGotIt copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? noticeId,
    _isc.UuidValue? mateId,
    DateTime? createdAt,
  }) {
    return NoticeGotIt(
      id: id is _isc.UuidValue? ? id : this.id,
      noticeId: noticeId ?? this.noticeId,
      mateId: mateId ?? this.mateId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NoticeGotItUpdateTable extends _isd.UpdateTable<NoticeGotItTable> {
  NoticeGotItUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> noticeId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.noticeId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> mateId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.mateId,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _isd.ColumnValue(
        table.createdAt,
        value,
      );
}

class NoticeGotItTable extends _isd.Table<_isc.UuidValue?> {
  NoticeGotItTable({super.tableRelation}) : super(tableName: 'notice_got_it') {
    updateTable = NoticeGotItUpdateTable(this);
    noticeId = _isd.ColumnUuid(
      'noticeId',
      this,
    );
    mateId = _isd.ColumnUuid(
      'mateId',
      this,
    );
    createdAt = _isd.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final NoticeGotItUpdateTable updateTable;

  late final _isd.ColumnUuid noticeId;

  late final _isd.ColumnUuid mateId;

  late final _isd.ColumnDateTime createdAt;

  @override
  List<_isd.Column> get columns => [
    id,
    noticeId,
    mateId,
    createdAt,
  ];
}

class NoticeGotItInclude extends _isd.IncludeObject {
  NoticeGotItInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => NoticeGotIt.t;
}

class NoticeGotItIncludeList extends _isd.IncludeList {
  NoticeGotItIncludeList._({
    _isd.WhereExpressionBuilder<NoticeGotItTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NoticeGotIt.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => NoticeGotIt.t;
}

class NoticeGotItRepository {
  const NoticeGotItRepository._();

  /// Returns a list of [NoticeGotIt]s matching the given query parameters.
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
  Future<List<NoticeGotIt>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<NoticeGotIt>(
      where: where?.call(NoticeGotIt.t),
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [NoticeGotIt] matching the given query parameters.
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
  Future<NoticeGotIt?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? offset,
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<NoticeGotIt>(
      where: where?.call(NoticeGotIt.t),
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [NoticeGotIt] by its [id] or null if no such row exists.
  Future<NoticeGotIt?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<NoticeGotIt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [NoticeGotIt]s in the list and returns the inserted rows.
  ///
  /// The returned [NoticeGotIt]s will have their `id` fields set.
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
  Future<List<NoticeGotIt>> insert(
    _isd.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<NoticeGotIt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [NoticeGotIt] and returns the inserted row.
  ///
  /// The returned [NoticeGotIt] will have its `id` field set.
  Future<NoticeGotIt> insertRow(
    _isd.DatabaseSession session,
    NoticeGotIt row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<NoticeGotIt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [NoticeGotIt]s in the list and returns the resulting rows.
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
  /// The returned [NoticeGotIt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NoticeGotIt>> upsert(
    _isd.DatabaseSession session,
    List<NoticeGotIt> rows, {
    required _isd.ColumnSelections<NoticeGotItTable> conflictColumns,
    _isd.ColumnSelections<NoticeGotItTable>? updateColumns,
    _isd.WhereExpressionBuilder<NoticeGotItTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<NoticeGotIt>(
      rows,
      conflictColumns: conflictColumns(NoticeGotIt.t),
      updateColumns: updateColumns?.call(NoticeGotIt.t),
      updateWhere: updateWhere?.call(NoticeGotIt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [NoticeGotIt] and returns the resulting row.
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
  /// The returned [NoticeGotIt] will have its `id` field set.
  Future<NoticeGotIt?> upsertRow(
    _isd.DatabaseSession session,
    NoticeGotIt row, {
    required _isd.ColumnSelections<NoticeGotItTable> conflictColumns,
    _isd.ColumnSelections<NoticeGotItTable>? updateColumns,
    _isd.WhereExpressionBuilder<NoticeGotItTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<NoticeGotIt>(
      row,
      conflictColumns: conflictColumns(NoticeGotIt.t),
      updateColumns: updateColumns?.call(NoticeGotIt.t),
      updateWhere: updateWhere?.call(NoticeGotIt.t),
      transaction: transaction,
    );
  }

  /// Updates all [NoticeGotIt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NoticeGotIt>> update(
    _isd.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _isd.ColumnSelections<NoticeGotItTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<NoticeGotIt>(
      rows,
      columns: columns?.call(NoticeGotIt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [NoticeGotIt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<NoticeGotIt> updateRow(
    _isd.DatabaseSession session,
    NoticeGotIt row, {
    _isd.ColumnSelections<NoticeGotItTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<NoticeGotIt>(
      row,
      columns: columns?.call(NoticeGotIt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [NoticeGotIt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<NoticeGotIt?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<NoticeGotItUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<NoticeGotIt>(
      id,
      columnValues: columnValues(NoticeGotIt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [NoticeGotIt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<NoticeGotIt>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<NoticeGotItUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<NoticeGotItTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<NoticeGotIt>(
      columnValues: columnValues(NoticeGotIt.t.updateTable),
      where: where(NoticeGotIt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [NoticeGotIt]s in the list and returns the deleted rows.
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
  Future<List<NoticeGotIt>> delete(
    _isd.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<NoticeGotIt>(
      rows,
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [NoticeGotIt].
  Future<NoticeGotIt> deleteRow(
    _isd.DatabaseSession session,
    NoticeGotIt row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<NoticeGotIt>(
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
  Future<List<NoticeGotIt>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<NoticeGotItTable> where,
    _isd.OrderByBuilder<NoticeGotItTable>? orderBy,
    _isd.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<NoticeGotIt>(
      where: where(NoticeGotIt.t),
      orderBy: orderBy?.call(NoticeGotIt.t),
      orderByList: orderByList?.call(NoticeGotIt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<NoticeGotIt>(
      where: where?.call(NoticeGotIt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NoticeGotIt] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<NoticeGotItTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NoticeGotIt>(
      where: where(NoticeGotIt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
