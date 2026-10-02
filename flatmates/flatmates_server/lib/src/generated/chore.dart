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
import 'package:flatmates_server/src/generated/protocol.dart' as _i2;

/// A recurring responsibility passed round-robin through [rotation].
abstract class Chore implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Chore._({
    this.id,
    required this.flatId,
    required this.name,
    required this.period,
    required this.startsAt,
    required this.rotation,
    required this.rotationIndex,
    required this.archived,
  });

  factory Chore({
    int? id,
    required int flatId,
    required String name,
    required Duration period,
    required DateTime startsAt,
    required List<int> rotation,
    required int rotationIndex,
    required bool archived,
  }) = _ChoreImpl;

  factory Chore.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chore(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      name: jsonSerialization['name'] as String,
      period: _i1.DurationJsonExtension.fromJson(jsonSerialization['period']),
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      rotation: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['rotation'],
      ),
      rotationIndex: jsonSerialization['rotationIndex'] as int,
      archived: _i1.BoolJsonExtension.fromJson(jsonSerialization['archived']),
    );
  }

  static final t = ChoreTable();

  static const db = ChoreRepository._();

  @override
  int? id;

  int flatId;

  String name;

  /// Rotation period: how long one Turn lasts.
  Duration period;

  DateTime startsAt;

  /// Mate ids in order; a Mate may appear more than once.
  List<int> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  int rotationIndex;

  bool archived;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Chore copyWith({
    int? id,
    int? flatId,
    String? name,
    Duration? period,
    DateTime? startsAt,
    List<int>? rotation,
    int? rotationIndex,
    bool? archived,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      'period': period.toJson(),
      'startsAt': startsAt.toJson(),
      'rotation': rotation.toJson(),
      'rotationIndex': rotationIndex,
      'archived': archived,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      'period': period.toJson(),
      'startsAt': startsAt.toJson(),
      'rotation': rotation.toJson(),
      'rotationIndex': rotationIndex,
      'archived': archived,
    };
  }

  static ChoreInclude include() {
    return ChoreInclude._();
  }

  static ChoreIncludeList includeList({
    _i1.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoreTable>? orderByList,
    ChoreInclude? include,
  }) {
    return ChoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chore.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Chore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoreImpl extends Chore {
  _ChoreImpl({
    int? id,
    required int flatId,
    required String name,
    required Duration period,
    required DateTime startsAt,
    required List<int> rotation,
    required int rotationIndex,
    required bool archived,
  }) : super._(
         id: id,
         flatId: flatId,
         name: name,
         period: period,
         startsAt: startsAt,
         rotation: rotation,
         rotationIndex: rotationIndex,
         archived: archived,
       );

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Chore copyWith({
    Object? id = _Undefined,
    int? flatId,
    String? name,
    Duration? period,
    DateTime? startsAt,
    List<int>? rotation,
    int? rotationIndex,
    bool? archived,
  }) {
    return Chore(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      period: period ?? this.period,
      startsAt: startsAt ?? this.startsAt,
      rotation: rotation ?? this.rotation.map((e0) => e0).toList(),
      rotationIndex: rotationIndex ?? this.rotationIndex,
      archived: archived ?? this.archived,
    );
  }
}

class ChoreUpdateTable extends _i1.UpdateTable<ChoreTable> {
  ChoreUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<Duration, Duration> period(Duration value) => _i1.ColumnValue(
    table.period,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> rotation(List<int> value) =>
      _i1.ColumnValue(
        table.rotation,
        value,
      );

  _i1.ColumnValue<int, int> rotationIndex(int value) => _i1.ColumnValue(
    table.rotationIndex,
    value,
  );

  _i1.ColumnValue<bool, bool> archived(bool value) => _i1.ColumnValue(
    table.archived,
    value,
  );
}

class ChoreTable extends _i1.Table<int?> {
  ChoreTable({super.tableRelation}) : super(tableName: 'chore') {
    updateTable = ChoreUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    period = _i1.ColumnDuration(
      'period',
      this,
    );
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    rotation = _i1.ColumnSerializable<List<int>>(
      'rotation',
      this,
    );
    rotationIndex = _i1.ColumnInt(
      'rotationIndex',
      this,
    );
    archived = _i1.ColumnBool(
      'archived',
      this,
    );
  }

  late final ChoreUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnString name;

  /// Rotation period: how long one Turn lasts.
  late final _i1.ColumnDuration period;

  late final _i1.ColumnDateTime startsAt;

  /// Mate ids in order; a Mate may appear more than once.
  late final _i1.ColumnSerializable<List<int>> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  late final _i1.ColumnInt rotationIndex;

  late final _i1.ColumnBool archived;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    name,
    period,
    startsAt,
    rotation,
    rotationIndex,
    archived,
  ];
}

class ChoreInclude extends _i1.IncludeObject {
  ChoreInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Chore.t;
}

class ChoreIncludeList extends _i1.IncludeList {
  ChoreIncludeList._({
    _i1.WhereExpressionBuilder<ChoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chore.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Chore.t;
}

class ChoreRepository {
  const ChoreRepository._();

  /// Returns a list of [Chore]s matching the given query parameters.
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
  Future<List<Chore>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoreTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Chore>(
      where: where?.call(Chore.t),
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Chore] matching the given query parameters.
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
  Future<Chore?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChoreTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoreTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Chore>(
      where: where?.call(Chore.t),
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Chore] by its [id] or null if no such row exists.
  Future<Chore?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Chore>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Chore]s in the list and returns the inserted rows.
  ///
  /// The returned [Chore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Chore>> insert(
    _i1.DatabaseSession session,
    List<Chore> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Chore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Chore] and returns the inserted row.
  ///
  /// The returned [Chore] will have its `id` field set.
  Future<Chore> insertRow(
    _i1.DatabaseSession session,
    Chore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Chore>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Chore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Chore>> update(
    _i1.DatabaseSession session,
    List<Chore> rows, {
    _i1.ColumnSelections<ChoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Chore>(
      rows,
      columns: columns?.call(Chore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Chore> updateRow(
    _i1.DatabaseSession session,
    Chore row, {
    _i1.ColumnSelections<ChoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Chore>(
      row,
      columns: columns?.call(Chore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Chore?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Chore>(
      id,
      columnValues: columnValues(Chore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Chore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Chore>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChoreUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChoreTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoreTable>? orderBy,
    _i1.OrderByListBuilder<ChoreTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Chore>(
      columnValues: columnValues(Chore.t.updateTable),
      where: where(Chore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chore.t),
      orderByList: orderByList?.call(Chore.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Chore]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Chore>> delete(
    _i1.DatabaseSession session,
    List<Chore> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Chore>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Chore].
  Future<Chore> deleteRow(
    _i1.DatabaseSession session,
    Chore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Chore>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Chore>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChoreTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Chore>(
      where: where(Chore.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChoreTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Chore>(
      where: where?.call(Chore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Chore] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChoreTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Chore>(
      where: where(Chore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
