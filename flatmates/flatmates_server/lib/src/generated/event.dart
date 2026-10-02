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

/// A one-off happening on the Flat's shared calendar.
abstract class FlatEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FlatEvent._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.title,
    this.note,
    required this.startsAt,
    this.endsAt,
  });

  factory FlatEvent({
    int? id,
    required int flatId,
    required int mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
  }) = _FlatEventImpl;

  factory FlatEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatEvent(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      title: jsonSerialization['title'] as String,
      note: jsonSerialization['note'] as String?,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
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

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlatEvent copyWith({
    int? id,
    int? flatId,
    int? mateId,
    String? title,
    String? note,
    DateTime? startsAt,
    DateTime? endsAt,
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
    };
  }

  static FlatEventInclude include() {
    return FlatEventInclude._();
  }

  static FlatEventIncludeList includeList({
    _i1.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatEventTable>? orderByList,
    FlatEventInclude? include,
  }) {
    return FlatEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlatEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FlatEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         title: title,
         note: note,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlatEvent copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    String? title,
    Object? note = _Undefined,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
  }) {
    return FlatEvent(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      title: title ?? this.title,
      note: note is String? ? note : this.note,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
    );
  }
}

class FlatEventUpdateTable extends _i1.UpdateTable<FlatEventTable> {
  FlatEventUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<int, int> mateId(int value) => _i1.ColumnValue(
    table.mateId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endsAt(DateTime? value) =>
      _i1.ColumnValue(
        table.endsAt,
        value,
      );
}

class FlatEventTable extends _i1.Table<int?> {
  FlatEventTable({super.tableRelation}) : super(tableName: 'flat_event') {
    updateTable = FlatEventUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    mateId = _i1.ColumnInt(
      'mateId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
  }

  late final FlatEventUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnInt mateId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    mateId,
    title,
    note,
    startsAt,
    endsAt,
  ];
}

class FlatEventInclude extends _i1.IncludeObject {
  FlatEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FlatEvent.t;
}

class FlatEventIncludeList extends _i1.IncludeList {
  FlatEventIncludeList._({
    _i1.WhereExpressionBuilder<FlatEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FlatEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FlatEvent.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FlatEvent>(
      where: where?.call(FlatEvent.t),
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<FlatEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FlatEvent>(
      where: where?.call(FlatEvent.t),
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FlatEvent] by its [id] or null if no such row exists.
  Future<FlatEvent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<FlatEvent>> insert(
    _i1.DatabaseSession session,
    List<FlatEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FlatEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FlatEvent] and returns the inserted row.
  ///
  /// The returned [FlatEvent] will have its `id` field set.
  Future<FlatEvent> insertRow(
    _i1.DatabaseSession session,
    FlatEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FlatEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FlatEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FlatEvent>> update(
    _i1.DatabaseSession session,
    List<FlatEvent> rows, {
    _i1.ColumnSelections<FlatEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FlatEvent>(
      rows,
      columns: columns?.call(FlatEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlatEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FlatEvent> updateRow(
    _i1.DatabaseSession session,
    FlatEvent row, {
    _i1.ColumnSelections<FlatEventTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FlatEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FlatEvent>(
      id,
      columnValues: columnValues(FlatEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FlatEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FlatEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FlatEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FlatEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatEventTable>? orderBy,
    _i1.OrderByListBuilder<FlatEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FlatEvent>(
      columnValues: columnValues(FlatEvent.t.updateTable),
      where: where(FlatEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlatEvent.t),
      orderByList: orderByList?.call(FlatEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FlatEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FlatEvent>> delete(
    _i1.DatabaseSession session,
    List<FlatEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FlatEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FlatEvent].
  Future<FlatEvent> deleteRow(
    _i1.DatabaseSession session,
    FlatEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FlatEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FlatEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FlatEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FlatEvent>(
      where: where(FlatEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FlatEvent>(
      where: where?.call(FlatEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FlatEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FlatEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FlatEvent>(
      where: where(FlatEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
