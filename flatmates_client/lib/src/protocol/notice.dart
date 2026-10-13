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
import 'package:flatmates_client/src/protocol/protocol.dart' as _iyp1dgna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// A text post on the Flat's notice board.
abstract class Notice
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
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
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required String text,
    required bool pinned,
    List<_isc.UuidValue>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoticeImpl;

  factory Notice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notice(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      mateId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      text: jsonSerialization['text'] as String,
      pinned: _isc.BoolJsonExtension.fromJson(jsonSerialization['pinned']),
      gotItMateIds: jsonSerialization['gotItMateIds'] == null
          ? null
          : _iyp1dgna.Protocol().deserialize<List<_isc.UuidValue>>(
              jsonSerialization['gotItMateIds'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = NoticeTable();

  static const db = NoticeRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  _isc.UuidValue mateId;

  String text;

  bool pinned;

  /// Mates who said "Got it"; the app fills it in from notice.gotIts().
  List<_isc.UuidValue>? gotItMateIds;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Notice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Notice copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    String? text,
    bool? pinned,
    List<_isc.UuidValue>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null)
        'gotItMateIds': gotItMateIds?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null)
        'gotItMateIds': gotItMateIds?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static NoticeInclude include() {
    return NoticeInclude._();
  }

  static NoticeIncludeList includeList({
    _isd.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NoticeImpl extends Notice {
  _NoticeImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required String text,
    required bool pinned,
    List<_isc.UuidValue>? gotItMateIds,
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
  @_isc.useResult
  @override
  Notice copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    String? text,
    bool? pinned,
    Object? gotItMateIds = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notice(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      text: text ?? this.text,
      pinned: pinned ?? this.pinned,
      gotItMateIds: gotItMateIds is List<_isc.UuidValue>?
          ? gotItMateIds
          : this.gotItMateIds?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class NoticeUpdateTable extends _isd.UpdateTable<NoticeTable> {
  NoticeUpdateTable(super.table);

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

  _isd.ColumnValue<String, String> text(String value) => _isd.ColumnValue(
    table.text,
    value,
  );

  _isd.ColumnValue<bool, bool> pinned(bool value) => _isd.ColumnValue(
    table.pinned,
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

class NoticeTable extends _isd.Table<_isc.UuidValue?> {
  NoticeTable({super.tableRelation}) : super(tableName: 'notice') {
    updateTable = NoticeUpdateTable(this);
    flatId = _isd.ColumnUuid(
      'flatId',
      this,
    );
    mateId = _isd.ColumnUuid(
      'mateId',
      this,
    );
    text = _isd.ColumnString(
      'text',
      this,
    );
    pinned = _isd.ColumnBool(
      'pinned',
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

  late final NoticeUpdateTable updateTable;

  late final _isd.ColumnUuid flatId;

  late final _isd.ColumnUuid mateId;

  late final _isd.ColumnString text;

  late final _isd.ColumnBool pinned;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    flatId,
    mateId,
    text,
    pinned,
    createdAt,
    updatedAt,
  ];
}

class NoticeInclude extends _isd.IncludeObject {
  NoticeInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Notice.t;
}

class NoticeIncludeList extends _isd.IncludeList {
  NoticeIncludeList._({
    _isd.WhereExpressionBuilder<NoticeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Notice.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Notice.t;
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
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
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
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeTable>? where,
    int? offset,
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
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
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
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
    _isd.DatabaseSession session,
    List<Notice> rows, {
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    Notice row, {
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    List<Notice> rows, {
    required _isd.ColumnSelections<NoticeTable> conflictColumns,
    _isd.ColumnSelections<NoticeTable>? updateColumns,
    _isd.WhereExpressionBuilder<NoticeTable>? updateWhere,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    Notice row, {
    required _isd.ColumnSelections<NoticeTable> conflictColumns,
    _isd.ColumnSelections<NoticeTable>? updateColumns,
    _isd.WhereExpressionBuilder<NoticeTable>? updateWhere,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    List<Notice> rows, {
    _isd.ColumnSelections<NoticeTable>? columns,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    Notice row, {
    _isd.ColumnSelections<NoticeTable>? columns,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<NoticeUpdateTable> columnValues,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<NoticeUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<NoticeTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    List<Notice> rows, {
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    Notice row, {
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<NoticeTable> where,
    _isd.OrderByBuilder<NoticeTable>? orderBy,
    _isd.OrderByListBuilder<NoticeTable>? orderByList,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<NoticeTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Notice>(
      where: where?.call(Notice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Notice] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<NoticeTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Notice>(
      where: where(Notice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
