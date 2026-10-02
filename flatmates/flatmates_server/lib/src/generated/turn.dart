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
import 'turn_status.dart' as _i2;

/// One Mate's responsibility for a Chore during one Rotation period.
abstract class Turn implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Turn._({
    this.id,
    required this.flatId,
    required this.choreId,
    required this.mateId,
    this.coveringForMateId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    this.doneAt,
  });

  factory Turn({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _i2.TurnStatus status,
    DateTime? doneAt,
  }) = _TurnImpl;

  factory Turn.fromJson(Map<String, dynamic> jsonSerialization) {
    return Turn(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      choreId: jsonSerialization['choreId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      coveringForMateId: jsonSerialization['coveringForMateId'] as int?,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      status: _i2.TurnStatus.fromJson((jsonSerialization['status'] as String)),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  static final t = TurnTable();

  static const db = TurnRepository._();

  @override
  int? id;

  int flatId;

  int choreId;

  int mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  int? coveringForMateId;

  DateTime startsAt;

  DateTime endsAt;

  _i2.TurnStatus status;

  DateTime? doneAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Turn copyWith({
    int? id,
    int? flatId,
    int? choreId,
    int? mateId,
    int? coveringForMateId,
    DateTime? startsAt,
    DateTime? endsAt,
    _i2.TurnStatus? status,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id,
      'flatId': flatId,
      'choreId': choreId,
      'mateId': mateId,
      if (coveringForMateId != null) 'coveringForMateId': coveringForMateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id,
      'flatId': flatId,
      'choreId': choreId,
      'mateId': mateId,
      if (coveringForMateId != null) 'coveringForMateId': coveringForMateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  static TurnInclude include() {
    return TurnInclude._();
  }

  static TurnIncludeList includeList({
    _i1.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TurnTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TurnTable>? orderByList,
    TurnInclude? include,
  }) {
    return TurnIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Turn.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Turn.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TurnImpl extends Turn {
  _TurnImpl({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _i2.TurnStatus status,
    DateTime? doneAt,
  }) : super._(
         id: id,
         flatId: flatId,
         choreId: choreId,
         mateId: mateId,
         coveringForMateId: coveringForMateId,
         startsAt: startsAt,
         endsAt: endsAt,
         status: status,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Turn copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? choreId,
    int? mateId,
    Object? coveringForMateId = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    _i2.TurnStatus? status,
    Object? doneAt = _Undefined,
  }) {
    return Turn(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      choreId: choreId ?? this.choreId,
      mateId: mateId ?? this.mateId,
      coveringForMateId: coveringForMateId is int?
          ? coveringForMateId
          : this.coveringForMateId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}

class TurnUpdateTable extends _i1.UpdateTable<TurnTable> {
  TurnUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<int, int> choreId(int value) => _i1.ColumnValue(
    table.choreId,
    value,
  );

  _i1.ColumnValue<int, int> mateId(int value) => _i1.ColumnValue(
    table.mateId,
    value,
  );

  _i1.ColumnValue<int, int> coveringForMateId(int? value) => _i1.ColumnValue(
    table.coveringForMateId,
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

  _i1.ColumnValue<_i2.TurnStatus, _i2.TurnStatus> status(
    _i2.TurnStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> doneAt(DateTime? value) =>
      _i1.ColumnValue(
        table.doneAt,
        value,
      );
}

class TurnTable extends _i1.Table<int?> {
  TurnTable({super.tableRelation}) : super(tableName: 'turn') {
    updateTable = TurnUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    choreId = _i1.ColumnInt(
      'choreId',
      this,
    );
    mateId = _i1.ColumnInt(
      'mateId',
      this,
    );
    coveringForMateId = _i1.ColumnInt(
      'coveringForMateId',
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
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    doneAt = _i1.ColumnDateTime(
      'doneAt',
      this,
    );
  }

  late final TurnUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnInt choreId;

  late final _i1.ColumnInt mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  late final _i1.ColumnInt coveringForMateId;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnEnum<_i2.TurnStatus> status;

  late final _i1.ColumnDateTime doneAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    choreId,
    mateId,
    coveringForMateId,
    startsAt,
    endsAt,
    status,
    doneAt,
  ];
}

class TurnInclude extends _i1.IncludeObject {
  TurnInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Turn.t;
}

class TurnIncludeList extends _i1.IncludeList {
  TurnIncludeList._({
    _i1.WhereExpressionBuilder<TurnTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Turn.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Turn.t;
}

class TurnRepository {
  const TurnRepository._();

  /// Returns a list of [Turn]s matching the given query parameters.
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
  Future<List<Turn>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TurnTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TurnTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Turn>(
      where: where?.call(Turn.t),
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Turn] matching the given query parameters.
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
  Future<Turn?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TurnTable>? where,
    int? offset,
    _i1.OrderByBuilder<TurnTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TurnTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Turn>(
      where: where?.call(Turn.t),
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Turn] by its [id] or null if no such row exists.
  Future<Turn?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Turn>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Turn]s in the list and returns the inserted rows.
  ///
  /// The returned [Turn]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Turn>> insert(
    _i1.DatabaseSession session,
    List<Turn> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Turn>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Turn] and returns the inserted row.
  ///
  /// The returned [Turn] will have its `id` field set.
  Future<Turn> insertRow(
    _i1.DatabaseSession session,
    Turn row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Turn>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Turn]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Turn>> update(
    _i1.DatabaseSession session,
    List<Turn> rows, {
    _i1.ColumnSelections<TurnTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Turn>(
      rows,
      columns: columns?.call(Turn.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Turn]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Turn> updateRow(
    _i1.DatabaseSession session,
    Turn row, {
    _i1.ColumnSelections<TurnTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Turn>(
      row,
      columns: columns?.call(Turn.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Turn] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Turn?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TurnUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Turn>(
      id,
      columnValues: columnValues(Turn.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Turn]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Turn>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TurnUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TurnTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TurnTable>? orderBy,
    _i1.OrderByListBuilder<TurnTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Turn>(
      columnValues: columnValues(Turn.t.updateTable),
      where: where(Turn.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Turn.t),
      orderByList: orderByList?.call(Turn.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Turn]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Turn>> delete(
    _i1.DatabaseSession session,
    List<Turn> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Turn>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Turn].
  Future<Turn> deleteRow(
    _i1.DatabaseSession session,
    Turn row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Turn>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Turn>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TurnTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Turn>(
      where: where(Turn.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TurnTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Turn>(
      where: where?.call(Turn.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Turn] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TurnTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Turn>(
      where: where(Turn.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
