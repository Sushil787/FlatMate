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

/// A Mate saying "Got it" on a Notice: they've read it.
abstract class NoticeGotIt
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  NoticeGotIt._({
    this.id,
    required this.noticeId,
    required this.mateId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NoticeGotIt({
    _is.UuidValue? id,
    required _is.UuidValue noticeId,
    required _is.UuidValue mateId,
    DateTime? createdAt,
  }) = _NoticeGotItImpl;

  factory NoticeGotIt.fromJson(Map<String, dynamic> jsonSerialization) {
    return NoticeGotIt(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      noticeId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['noticeId'],
      ),
      mateId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = NoticeGotItTable();

  static const db = NoticeGotItRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue noticeId;

  _is.UuidValue mateId;

  DateTime createdAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NoticeGotIt copyWith({
    _is.UuidValue? id,
    _is.UuidValue? noticeId,
    _is.UuidValue? mateId,
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
    _is.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NoticeGotItImpl extends NoticeGotIt {
  _NoticeGotItImpl({
    _is.UuidValue? id,
    required _is.UuidValue noticeId,
    required _is.UuidValue mateId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         noticeId: noticeId,
         mateId: mateId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NoticeGotIt copyWith({
    Object? id = _Undefined,
    _is.UuidValue? noticeId,
    _is.UuidValue? mateId,
    DateTime? createdAt,
  }) {
    return NoticeGotIt(
      id: id is _is.UuidValue? ? id : this.id,
      noticeId: noticeId ?? this.noticeId,
      mateId: mateId ?? this.mateId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class NoticeGotItUpdateTable extends _is.UpdateTable<NoticeGotItTable> {
  NoticeGotItUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> noticeId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.noticeId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> mateId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.mateId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class NoticeGotItTable extends _is.Table<_is.UuidValue?> {
  NoticeGotItTable({super.tableRelation}) : super(tableName: 'notice_got_it') {
    updateTable = NoticeGotItUpdateTable(this);
    noticeId = _is.ColumnUuid(
      'noticeId',
      this,
    );
    mateId = _is.ColumnUuid(
      'mateId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final NoticeGotItUpdateTable updateTable;

  late final _is.ColumnUuid noticeId;

  late final _is.ColumnUuid mateId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    noticeId,
    mateId,
    createdAt,
  ];
}

class NoticeGotItInclude extends _is.IncludeObject {
  NoticeGotItInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => NoticeGotIt.t;
}

class NoticeGotItIncludeList extends _is.IncludeList {
  NoticeGotItIncludeList._({
    _is.WhereExpressionBuilder<NoticeGotItTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(NoticeGotIt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => NoticeGotIt.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? offset,
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
    _is.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    NoticeGotIt row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<NoticeGotIt> rows, {
    required _is.ColumnSelections<NoticeGotItTable> conflictColumns,
    _is.ColumnSelections<NoticeGotItTable>? updateColumns,
    _is.WhereExpressionBuilder<NoticeGotItTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    NoticeGotIt row, {
    required _is.ColumnSelections<NoticeGotItTable> conflictColumns,
    _is.ColumnSelections<NoticeGotItTable>? updateColumns,
    _is.WhereExpressionBuilder<NoticeGotItTable>? updateWhere,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _is.ColumnSelections<NoticeGotItTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    NoticeGotIt row, {
    _is.ColumnSelections<NoticeGotItTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<NoticeGotItUpdateTable> columnValues,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<NoticeGotItUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<NoticeGotItTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    List<NoticeGotIt> rows, {
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    NoticeGotIt row, {
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NoticeGotItTable> where,
    _is.OrderByBuilder<NoticeGotItTable>? orderBy,
    _is.OrderByListBuilder<NoticeGotItTable>? orderByList,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeGotItTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<NoticeGotIt>(
      where: where?.call(NoticeGotIt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [NoticeGotIt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NoticeGotItTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<NoticeGotIt>(
      where: where(NoticeGotIt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
