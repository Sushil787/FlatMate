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

/// A text post on the Flat's notice board.
abstract class Notice implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Notice._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.text,
    required this.pinned,
    this.gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Notice({
    int? id,
    required int flatId,
    required int mateId,
    required String text,
    required bool pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoticeImpl;

  factory Notice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notice(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      text: jsonSerialization['text'] as String,
      pinned: _is.BoolJsonExtension.fromJson(jsonSerialization['pinned']),
      gotItMateIds: jsonSerialization['gotItMateIds'] == null
          ? null
          : _ikjds9rx.Protocol().deserialize<List<int>>(
              jsonSerialization['gotItMateIds'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NoticeTable();

  static const db = NoticeRepository._();

  @override
  int? id;

  int flatId;

  int mateId;

  String text;

  bool pinned;

  /// Mates who said "Got it"; filled in by list().
  List<int>? gotItMateIds;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Notice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Notice copyWith({
    int? id,
    int? flatId,
    int? mateId,
    String? text,
    bool? pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null) 'gotItMateIds': gotItMateIds?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null) 'gotItMateIds': gotItMateIds?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NoticeInclude include() {
    return NoticeInclude._();
  }

  static NoticeIncludeList includeList({
    _is.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    NoticeInclude? include,
  }) {
    return NoticeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NoticeImpl extends Notice {
  _NoticeImpl({
    int? id,
    required int flatId,
    required int mateId,
    required String text,
    required bool pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         text: text,
         pinned: pinned,
         gotItMateIds: gotItMateIds,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Notice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Notice copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    String? text,
    bool? pinned,
    Object? gotItMateIds = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notice(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      text: text ?? this.text,
      pinned: pinned ?? this.pinned,
      gotItMateIds: gotItMateIds is List<int>?
          ? gotItMateIds
          : this.gotItMateIds?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NoticeUpdateTable extends _is.UpdateTable<NoticeTable> {
  NoticeUpdateTable(super.table);

  _is.ColumnValue<int, int> flatId(int value) => _is.ColumnValue(
    table.flatId,
    value,
  );

  _is.ColumnValue<int, int> mateId(int value) => _is.ColumnValue(
    table.mateId,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<bool, bool> pinned(bool value) => _is.ColumnValue(
    table.pinned,
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

class NoticeTable extends _is.Table<int?> {
  NoticeTable({super.tableRelation}) : super(tableName: 'notice') {
    updateTable = NoticeUpdateTable(this);
    flatId = _is.ColumnInt(
      'flatId',
      this,
    );
    mateId = _is.ColumnInt(
      'mateId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    pinned = _is.ColumnBool(
      'pinned',
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

  late final NoticeUpdateTable updateTable;

  late final _is.ColumnInt flatId;

  late final _is.ColumnInt mateId;

  late final _is.ColumnString text;

  late final _is.ColumnBool pinned;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    flatId,
    mateId,
    text,
    pinned,
    createdAt,
    updatedAt,
  ];
}

class NoticeInclude extends _is.IncludeObject {
  NoticeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Notice.t;
}

class NoticeIncludeList extends _is.IncludeList {
  NoticeIncludeList._({
    _is.WhereExpressionBuilder<NoticeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Notice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Notice.t;
}

class NoticeRepository {
  const NoticeRepository._();

  /// Returns a list of [Notice]s matching the given query parameters.
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
  Future<List<Notice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Notice>(
      where: where?.call(Notice.t),
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Notice] matching the given query parameters.
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
  Future<Notice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeTable>? where,
    int? offset,
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Notice>(
      where: where?.call(Notice.t),
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Notice] by its [id] or null if no such row exists.
  Future<Notice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Notice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Notice]s in the list and returns the inserted rows.
  ///
  /// The returned [Notice]s will have their `id` fields set.
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
  Future<List<Notice>> insert(
    _is.DatabaseSession session,
    List<Notice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Notice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Notice] and returns the inserted row.
  ///
  /// The returned [Notice] will have its `id` field set.
  Future<Notice> insertRow(
    _is.DatabaseSession session,
    Notice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Notice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Notice]s in the list and returns the resulting rows.
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
  /// The returned [Notice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Notice>> upsert(
    _is.DatabaseSession session,
    List<Notice> rows, {
    required _is.ColumnSelections<NoticeTable> conflictColumns,
    _is.ColumnSelections<NoticeTable>? updateColumns,
    _is.WhereExpressionBuilder<NoticeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Notice>(
      rows,
      conflictColumns: conflictColumns(Notice.t),
      updateColumns: updateColumns?.call(Notice.t),
      updateWhere: updateWhere?.call(Notice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Notice] and returns the resulting row.
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
  /// The returned [Notice] will have its `id` field set.
  Future<Notice?> upsertRow(
    _is.DatabaseSession session,
    Notice row, {
    required _is.ColumnSelections<NoticeTable> conflictColumns,
    _is.ColumnSelections<NoticeTable>? updateColumns,
    _is.WhereExpressionBuilder<NoticeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Notice>(
      row,
      conflictColumns: conflictColumns(Notice.t),
      updateColumns: updateColumns?.call(Notice.t),
      updateWhere: updateWhere?.call(Notice.t),
      transaction: transaction,
    );
  }

  /// Updates all [Notice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Notice>> update(
    _is.DatabaseSession session,
    List<Notice> rows, {
    _is.ColumnSelections<NoticeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Notice>(
      rows,
      columns: columns?.call(Notice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Notice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Notice> updateRow(
    _is.DatabaseSession session,
    Notice row, {
    _is.ColumnSelections<NoticeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Notice>(
      row,
      columns: columns?.call(Notice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Notice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Notice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<NoticeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Notice>(
      id,
      columnValues: columnValues(Notice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Notice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Notice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<NoticeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<NoticeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Notice>(
      columnValues: columnValues(Notice.t.updateTable),
      where: where(Notice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Notice]s in the list and returns the deleted rows.
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
  Future<List<Notice>> delete(
    _is.DatabaseSession session,
    List<Notice> rows, {
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Notice>(
      rows,
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Notice].
  Future<Notice> deleteRow(
    _is.DatabaseSession session,
    Notice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Notice>(
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
  Future<List<Notice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NoticeTable> where,
    _is.OrderByBuilder<NoticeTable>? orderBy,
    _is.OrderByListBuilder<NoticeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Notice>(
      where: where(Notice.t),
      orderBy: orderBy?.call(Notice.t),
      orderByList: orderByList?.call(Notice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Notice>(
      where: where?.call(Notice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Notice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<NoticeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Notice>(
      where: where(Notice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
