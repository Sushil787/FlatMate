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

/// A period a Mate is not around to do Chores.
abstract class Away implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Away._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.startsAt,
    required this.endsAt,
  });

  factory Away({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _AwayImpl;

  factory Away.fromJson(Map<String, dynamic> jsonSerialization) {
    return Away(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  static final t = AwayTable();

  static const db = AwayRepository._();

  @override
  int? id;

  int flatId;

  int mateId;

  DateTime startsAt;

  DateTime endsAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Away copyWith({
    int? id,
    int? flatId,
    int? mateId,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  static AwayInclude include() {
    return AwayInclude._();
  }

  static AwayIncludeList includeList({
    _i1.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AwayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AwayTable>? orderByList,
    AwayInclude? include,
  }) {
    return AwayIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Away.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Away.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AwayImpl extends Away {
  _AwayImpl({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Away copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return Away(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}

class AwayUpdateTable extends _i1.UpdateTable<AwayTable> {
  AwayUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<int, int> mateId(int value) => _i1.ColumnValue(
    table.mateId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _i1.ColumnValue(
    table.endsAt,
    value,
  );
}

class AwayTable extends _i1.Table<int?> {
  AwayTable({super.tableRelation}) : super(tableName: 'away') {
    updateTable = AwayUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    mateId = _i1.ColumnInt(
      'mateId',
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

  late final AwayUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnInt mateId;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    mateId,
    startsAt,
    endsAt,
  ];
}

class AwayInclude extends _i1.IncludeObject {
  AwayInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Away.t;
}

class AwayIncludeList extends _i1.IncludeList {
  AwayIncludeList._({
    _i1.WhereExpressionBuilder<AwayTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Away.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Away.t;
}

class AwayRepository {
  const AwayRepository._();

  /// Returns a list of [Away]s matching the given query parameters.
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
  Future<List<Away>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AwayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AwayTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Away>(
      where: where?.call(Away.t),
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Away] matching the given query parameters.
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
  Future<Away?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AwayTable>? where,
    int? offset,
    _i1.OrderByBuilder<AwayTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AwayTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Away>(
      where: where?.call(Away.t),
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Away] by its [id] or null if no such row exists.
  Future<Away?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Away>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Away]s in the list and returns the inserted rows.
  ///
  /// The returned [Away]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Away>> insert(
    _i1.DatabaseSession session,
    List<Away> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Away>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Away] and returns the inserted row.
  ///
  /// The returned [Away] will have its `id` field set.
  Future<Away> insertRow(
    _i1.DatabaseSession session,
    Away row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Away>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Away]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Away>> update(
    _i1.DatabaseSession session,
    List<Away> rows, {
    _i1.ColumnSelections<AwayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Away>(
      rows,
      columns: columns?.call(Away.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Away]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Away> updateRow(
    _i1.DatabaseSession session,
    Away row, {
    _i1.ColumnSelections<AwayTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Away>(
      row,
      columns: columns?.call(Away.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Away] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Away?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AwayUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Away>(
      id,
      columnValues: columnValues(Away.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Away]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Away>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AwayUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AwayTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AwayTable>? orderBy,
    _i1.OrderByListBuilder<AwayTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Away>(
      columnValues: columnValues(Away.t.updateTable),
      where: where(Away.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Away.t),
      orderByList: orderByList?.call(Away.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Away]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Away>> delete(
    _i1.DatabaseSession session,
    List<Away> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Away>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Away].
  Future<Away> deleteRow(
    _i1.DatabaseSession session,
    Away row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Away>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Away>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AwayTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Away>(
      where: where(Away.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AwayTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Away>(
      where: where?.call(Away.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Away] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AwayTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Away>(
      where: where(Away.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
