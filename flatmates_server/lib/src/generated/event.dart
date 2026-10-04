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

/// A one-off happening on the Flat's shared calendar.
abstract class FlatEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FlatEvent._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.title,
    this.note,
    required this.startsAt,
    this.endsAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FlatEvent({
    int? id,
    required int flatId,
    required int mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FlatEventImpl;

  factory FlatEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatEvent(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      title: jsonSerialization['title'] as String,
      note: jsonSerialization['note'] as String?,
      startsAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FlatEventTable();

  static const db = FlatEventRepository._();

  @override
  int? id;

  int flatId;

  int mateId;

  String title;

  String? note;

  DateTime startsAt;

  DateTime? endsAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FlatEvent copyWith({
    int? id,
    int? flatId,
    int? mateId,
    String? title,
    String? note,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FlatEventInclude include() {
    return FlatEventInclude._();
  }

  static FlatEventIncludeList includeList({
    _is.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    FlatEventInclude? include,
  }) {
    return FlatEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlatEventImpl extends FlatEvent {
  _FlatEventImpl({
    int? id,
    required int flatId,
    required int mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         title: title,
         note: note,
         startsAt: startsAt,
         endsAt: endsAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FlatEvent copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    String? title,
    Object? note = _Undefined,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FlatEvent(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      title: title ?? this.title,
      note: note is String? ? note : this.note,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FlatEventUpdateTable extends _is.UpdateTable<FlatEventTable> {
  FlatEventUpdateTable(super.table);

  _is.ColumnValue<int, int> flatId(int value) => _is.ColumnValue(
    table.flatId,
    value,
  );

  _is.ColumnValue<int, int> mateId(int value) => _is.ColumnValue(
    table.mateId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _is.ColumnValue(
        table.startsAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endsAt(DateTime? value) =>
      _is.ColumnValue(
        table.endsAt,
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

class FlatEventTable extends _is.Table<int?> {
  FlatEventTable({super.tableRelation}) : super(tableName: 'flat_event') {
    updateTable = FlatEventUpdateTable(this);
    flatId = _is.ColumnInt(
      'flatId',
      this,
    );
    mateId = _is.ColumnInt(
      'mateId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    startsAt = _is.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _is.ColumnDateTime(
      'endsAt',
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

  late final FlatEventUpdateTable updateTable;

  late final _is.ColumnInt flatId;

  late final _is.ColumnInt mateId;

  late final _is.ColumnString title;

  late final _is.ColumnString note;

  late final _is.ColumnDateTime startsAt;

  late final _is.ColumnDateTime endsAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    flatId,
    mateId,
    title,
    note,
    startsAt,
    endsAt,
    createdAt,
    updatedAt,
  ];
}

class FlatEventInclude extends _is.IncludeObject {
  FlatEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FlatEvent.t;
}

class FlatEventIncludeList extends _is.IncludeList {
  FlatEventIncludeList._({
    _is.WhereExpressionBuilder<FlatEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FlatEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FlatEvent.t;
}

class FlatEventRepository {
  const FlatEventRepository._();

  /// Returns a list of [FlatEvent]s matching the given query parameters.
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
  Future<List<FlatEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FlatEvent>(
      where: where?.call(FlatEvent.t),
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FlatEvent] matching the given query parameters.
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
  Future<FlatEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FlatEventTable>? where,
    int? offset,
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FlatEvent>(
      where: where?.call(FlatEvent.t),
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FlatEvent] by its [id] or null if no such row exists.
  Future<FlatEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FlatEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FlatEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [FlatEvent]s will have their `id` fields set.
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
  Future<List<FlatEvent>> insert(
    _is.DatabaseSession session,
    List<FlatEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FlatEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FlatEvent] and returns the inserted row.
  ///
  /// The returned [FlatEvent] will have its `id` field set.
  Future<FlatEvent> insertRow(
    _is.DatabaseSession session,
    FlatEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FlatEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FlatEvent]s in the list and returns the resulting rows.
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
  /// The returned [FlatEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FlatEvent>> upsert(
    _is.DatabaseSession session,
    List<FlatEvent> rows, {
    required _is.ColumnSelections<FlatEventTable> conflictColumns,
    _is.ColumnSelections<FlatEventTable>? updateColumns,
    _is.WhereExpressionBuilder<FlatEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FlatEvent>(
      rows,
      conflictColumns: conflictColumns(FlatEvent.t),
      updateColumns: updateColumns?.call(FlatEvent.t),
      updateWhere: updateWhere?.call(FlatEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FlatEvent] and returns the resulting row.
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
  /// The returned [FlatEvent] will have its `id` field set.
  Future<FlatEvent?> upsertRow(
    _is.DatabaseSession session,
    FlatEvent row, {
    required _is.ColumnSelections<FlatEventTable> conflictColumns,
    _is.ColumnSelections<FlatEventTable>? updateColumns,
    _is.WhereExpressionBuilder<FlatEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FlatEvent>(
      row,
      conflictColumns: conflictColumns(FlatEvent.t),
      updateColumns: updateColumns?.call(FlatEvent.t),
      updateWhere: updateWhere?.call(FlatEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [FlatEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FlatEvent>> update(
    _is.DatabaseSession session,
    List<FlatEvent> rows, {
    _is.ColumnSelections<FlatEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FlatEvent>(
      rows,
      columns: columns?.call(FlatEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FlatEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FlatEvent> updateRow(
    _is.DatabaseSession session,
    FlatEvent row, {
    _is.ColumnSelections<FlatEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FlatEvent>(
      row,
      columns: columns?.call(FlatEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlatEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FlatEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FlatEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FlatEvent>(
      id,
      columnValues: columnValues(FlatEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FlatEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FlatEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FlatEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FlatEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FlatEvent>(
      columnValues: columnValues(FlatEvent.t.updateTable),
      where: where(FlatEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FlatEvent]s in the list and returns the deleted rows.
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
  Future<List<FlatEvent>> delete(
    _is.DatabaseSession session,
    List<FlatEvent> rows, {
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FlatEvent>(
      rows,
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FlatEvent].
  Future<FlatEvent> deleteRow(
    _is.DatabaseSession session,
    FlatEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FlatEvent>(
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
  Future<List<FlatEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FlatEventTable> where,
    _is.OrderByBuilder<FlatEventTable>? orderBy,
    _is.OrderByListBuilder<FlatEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FlatEvent>(
      where: where(FlatEvent.t),
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FlatEvent>(
      where: where?.call(FlatEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FlatEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FlatEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FlatEvent>(
      where: where(FlatEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
