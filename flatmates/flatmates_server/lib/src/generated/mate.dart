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

/// A member of a Flat. A Mate with [leftAt] set has left the Flat.
abstract class Mate implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Mate._({
    this.id,
    required this.flatId,
    required this.authUserId,
    required this.displayName,
    required this.joinedAt,
    this.leftAt,
  });

  factory Mate({
    int? id,
    required int flatId,
    required _i1.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
  }) = _MateImpl;

  factory Mate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mate(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      leftAt: jsonSerialization['leftAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['leftAt']),
    );
  }

  static final t = MateTable();

  static const db = MateRepository._();

  @override
  int? id;

  int flatId;

  _i1.UuidValue authUserId;

  String displayName;

  DateTime joinedAt;

  DateTime? leftAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Mate copyWith({
    int? id,
    int? flatId,
    _i1.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    DateTime? leftAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id,
      'flatId': flatId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id,
      'flatId': flatId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
    };
  }

  static MateInclude include() {
    return MateInclude._();
  }

  static MateIncludeList includeList({
    _i1.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MateTable>? orderByList,
    MateInclude? include,
  }) {
    return MateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Mate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MateImpl extends Mate {
  _MateImpl({
    int? id,
    required int flatId,
    required _i1.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
  }) : super._(
         id: id,
         flatId: flatId,
         authUserId: authUserId,
         displayName: displayName,
         joinedAt: joinedAt,
         leftAt: leftAt,
       );

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Mate copyWith({
    Object? id = _Undefined,
    int? flatId,
    _i1.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    Object? leftAt = _Undefined,
  }) {
    return Mate(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt is DateTime? ? leftAt : this.leftAt,
    );
  }
}

class MateUpdateTable extends _i1.UpdateTable<MateTable> {
  MateUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _i1.ColumnValue(
        table.joinedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> leftAt(DateTime? value) =>
      _i1.ColumnValue(
        table.leftAt,
        value,
      );
}

class MateTable extends _i1.Table<int?> {
  MateTable({super.tableRelation}) : super(tableName: 'mate') {
    updateTable = MateUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    joinedAt = _i1.ColumnDateTime(
      'joinedAt',
      this,
    );
    leftAt = _i1.ColumnDateTime(
      'leftAt',
      this,
    );
  }

  late final MateUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnUuid authUserId;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnDateTime joinedAt;

  late final _i1.ColumnDateTime leftAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    authUserId,
    displayName,
    joinedAt,
    leftAt,
  ];
}

class MateInclude extends _i1.IncludeObject {
  MateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Mate.t;
}

class MateIncludeList extends _i1.IncludeList {
  MateIncludeList._({
    _i1.WhereExpressionBuilder<MateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Mate.t;
}

class MateRepository {
  const MateRepository._();

  /// Returns a list of [Mate]s matching the given query parameters.
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
  Future<List<Mate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mate] matching the given query parameters.
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
  Future<Mate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MateTable>? where,
    int? offset,
    _i1.OrderByBuilder<MateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mate] by its [id] or null if no such row exists.
  Future<Mate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mate]s in the list and returns the inserted rows.
  ///
  /// The returned [Mate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Mate>> insert(
    _i1.DatabaseSession session,
    List<Mate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Mate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Mate] and returns the inserted row.
  ///
  /// The returned [Mate] will have its `id` field set.
  Future<Mate> insertRow(
    _i1.DatabaseSession session,
    Mate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Mate>> update(
    _i1.DatabaseSession session,
    List<Mate> rows, {
    _i1.ColumnSelections<MateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Mate>(
      rows,
      columns: columns?.call(Mate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mate> updateRow(
    _i1.DatabaseSession session,
    Mate row, {
    _i1.ColumnSelections<MateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mate>(
      row,
      columns: columns?.call(Mate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MateUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Mate>(
      id,
      columnValues: columnValues(Mate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Mate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MateUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MateTable>? orderBy,
    _i1.OrderByListBuilder<MateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Mate>(
      columnValues: columnValues(Mate.t.updateTable),
      where: where(Mate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Mate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Mate>> delete(
    _i1.DatabaseSession session,
    List<Mate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Mate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Mate].
  Future<Mate> deleteRow(
    _i1.DatabaseSession session,
    Mate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Mate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Mate>(
      where: where(Mate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Mate>(
      where: where?.call(Mate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mate>(
      where: where(Mate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
