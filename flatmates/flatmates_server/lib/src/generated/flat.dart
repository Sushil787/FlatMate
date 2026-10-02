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
import 'away_rule.dart' as _i2;

/// The shared home; the boundary for everything else.
abstract class Flat implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Flat._({
    this.id,
    required this.name,
    required this.timezone,
    this.adminMateId,
    required this.inviteCode,
    required this.awayRule,
    required this.createdAt,
  });

  factory Flat({
    int? id,
    required String name,
    required String timezone,
    int? adminMateId,
    required String inviteCode,
    required _i2.AwayRule awayRule,
    required DateTime createdAt,
  }) = _FlatImpl;

  factory Flat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Flat(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      timezone: jsonSerialization['timezone'] as String,
      adminMateId: jsonSerialization['adminMateId'] as int?,
      inviteCode: jsonSerialization['inviteCode'] as String,
      awayRule: _i2.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FlatTable();

  static const db = FlatRepository._();

  @override
  int? id;

  String name;

  String timezone;

  int? adminMateId;

  String inviteCode;

  _i2.AwayRule awayRule;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Flat copyWith({
    int? id,
    String? name,
    String? timezone,
    int? adminMateId,
    String? inviteCode,
    _i2.AwayRule? awayRule,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId,
      'inviteCode': inviteCode,
      'awayRule': awayRule.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId,
      'inviteCode': inviteCode,
      'awayRule': awayRule.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static FlatInclude include() {
    return FlatInclude._();
  }

  static FlatIncludeList includeList({
    _i1.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatTable>? orderByList,
    FlatInclude? include,
  }) {
    return FlatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Flat.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Flat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlatImpl extends Flat {
  _FlatImpl({
    int? id,
    required String name,
    required String timezone,
    int? adminMateId,
    required String inviteCode,
    required _i2.AwayRule awayRule,
    required DateTime createdAt,
  }) : super._(
         id: id,
         name: name,
         timezone: timezone,
         adminMateId: adminMateId,
         inviteCode: inviteCode,
         awayRule: awayRule,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Flat copyWith({
    Object? id = _Undefined,
    String? name,
    String? timezone,
    Object? adminMateId = _Undefined,
    String? inviteCode,
    _i2.AwayRule? awayRule,
    DateTime? createdAt,
  }) {
    return Flat(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      adminMateId: adminMateId is int? ? adminMateId : this.adminMateId,
      inviteCode: inviteCode ?? this.inviteCode,
      awayRule: awayRule ?? this.awayRule,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FlatUpdateTable extends _i1.UpdateTable<FlatTable> {
  FlatUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> timezone(String value) => _i1.ColumnValue(
    table.timezone,
    value,
  );

  _i1.ColumnValue<int, int> adminMateId(int? value) => _i1.ColumnValue(
    table.adminMateId,
    value,
  );

  _i1.ColumnValue<String, String> inviteCode(String value) => _i1.ColumnValue(
    table.inviteCode,
    value,
  );

  _i1.ColumnValue<_i2.AwayRule, _i2.AwayRule> awayRule(_i2.AwayRule value) =>
      _i1.ColumnValue(
        table.awayRule,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class FlatTable extends _i1.Table<int?> {
  FlatTable({super.tableRelation}) : super(tableName: 'flat') {
    updateTable = FlatUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    timezone = _i1.ColumnString(
      'timezone',
      this,
    );
    adminMateId = _i1.ColumnInt(
      'adminMateId',
      this,
    );
    inviteCode = _i1.ColumnString(
      'inviteCode',
      this,
    );
    awayRule = _i1.ColumnEnum(
      'awayRule',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FlatUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString timezone;

  late final _i1.ColumnInt adminMateId;

  late final _i1.ColumnString inviteCode;

  late final _i1.ColumnEnum<_i2.AwayRule> awayRule;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    timezone,
    adminMateId,
    inviteCode,
    awayRule,
    createdAt,
  ];
}

class FlatInclude extends _i1.IncludeObject {
  FlatInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Flat.t;
}

class FlatIncludeList extends _i1.IncludeList {
  FlatIncludeList._({
    _i1.WhereExpressionBuilder<FlatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Flat.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Flat.t;
}

class FlatRepository {
  const FlatRepository._();

  /// Returns a list of [Flat]s matching the given query parameters.
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
  Future<List<Flat>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Flat>(
      where: where?.call(Flat.t),
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Flat] matching the given query parameters.
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
  Future<Flat?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatTable>? where,
    int? offset,
    _i1.OrderByBuilder<FlatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Flat>(
      where: where?.call(Flat.t),
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Flat] by its [id] or null if no such row exists.
  Future<Flat?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Flat>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Flat]s in the list and returns the inserted rows.
  ///
  /// The returned [Flat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Flat>> insert(
    _i1.DatabaseSession session,
    List<Flat> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Flat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Flat] and returns the inserted row.
  ///
  /// The returned [Flat] will have its `id` field set.
  Future<Flat> insertRow(
    _i1.DatabaseSession session,
    Flat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Flat>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Flat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Flat>> update(
    _i1.DatabaseSession session,
    List<Flat> rows, {
    _i1.ColumnSelections<FlatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Flat>(
      rows,
      columns: columns?.call(Flat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Flat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Flat> updateRow(
    _i1.DatabaseSession session,
    Flat row, {
    _i1.ColumnSelections<FlatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Flat>(
      row,
      columns: columns?.call(Flat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Flat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Flat?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FlatUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Flat>(
      id,
      columnValues: columnValues(Flat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Flat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Flat>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FlatUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FlatTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlatTable>? orderBy,
    _i1.OrderByListBuilder<FlatTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Flat>(
      columnValues: columnValues(Flat.t.updateTable),
      where: where(Flat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Flat]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Flat>> delete(
    _i1.DatabaseSession session,
    List<Flat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Flat>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Flat].
  Future<Flat> deleteRow(
    _i1.DatabaseSession session,
    Flat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Flat>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Flat>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FlatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Flat>(
      where: where(Flat.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Flat>(
      where: where?.call(Flat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Flat] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FlatTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Flat>(
      where: where(Flat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
