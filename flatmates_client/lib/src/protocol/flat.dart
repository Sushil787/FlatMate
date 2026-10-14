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
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// The shared home; the boundary for everything else.
abstract class Flat
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  Flat._({
    this.id,
    required this.name,
    required this.timezone,
    this.adminMateId,
    required this.inviteCode,
    required this.inviteExpiresAt,
    required this.awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Flat({
    _isc.UuidValue? id,
    required String name,
    required String timezone,
    _isc.UuidValue? adminMateId,
    required String inviteCode,
    required DateTime inviteExpiresAt,
    required _ij0lpv6z.AwayRule awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FlatImpl;

  factory Flat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Flat(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      timezone: jsonSerialization['timezone'] as String,
      adminMateId: jsonSerialization['adminMateId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['adminMateId'],
            ),
      inviteCode: jsonSerialization['inviteCode'] as String,
      inviteExpiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['inviteExpiresAt'],
      ),
      awayRule: _ij0lpv6z.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FlatTable();

  static const db = FlatRepository._();

  @override
  _isc.UuidValue? id;

  String name;

  /// IANA name, e.g. Asia/Kathmandu: when the Flat's days start and end.
  String timezone;

  _isc.UuidValue? adminMateId;

  String inviteCode;

  /// When [inviteCode] stops working; 7 days after it was made.
  DateTime inviteExpiresAt;

  _ij0lpv6z.AwayRule awayRule;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Flat copyWith({
    _isc.UuidValue? id,
    String? name,
    String? timezone,
    _isc.UuidValue? adminMateId,
    String? inviteCode,
    DateTime? inviteExpiresAt,
    _ij0lpv6z.AwayRule? awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId?.toJson(),
      'inviteCode': inviteCode,
      'inviteExpiresAt': inviteExpiresAt.toJson(),
      'awayRule': awayRule.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId?.toJson(),
      'inviteCode': inviteCode,
      'inviteExpiresAt': inviteExpiresAt.toJson(),
      'awayRule': awayRule.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FlatInclude include() {
    return FlatInclude._();
  }

  static FlatIncludeList includeList({
    _isd.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    FlatInclude? include,
  }) {
    return FlatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlatImpl extends Flat {
  _FlatImpl({
    _isc.UuidValue? id,
    required String name,
    required String timezone,
    _isc.UuidValue? adminMateId,
    required String inviteCode,
    required DateTime inviteExpiresAt,
    required _ij0lpv6z.AwayRule awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         timezone: timezone,
         adminMateId: adminMateId,
         inviteCode: inviteCode,
         inviteExpiresAt: inviteExpiresAt,
         awayRule: awayRule,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Flat copyWith({
    Object? id = _Undefined,
    String? name,
    String? timezone,
    Object? adminMateId = _Undefined,
    String? inviteCode,
    DateTime? inviteExpiresAt,
    _ij0lpv6z.AwayRule? awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Flat(
      id: id is _isc.UuidValue? ? id : this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      adminMateId: adminMateId is _isc.UuidValue?
          ? adminMateId
          : this.adminMateId,
      inviteCode: inviteCode ?? this.inviteCode,
      inviteExpiresAt: inviteExpiresAt ?? this.inviteExpiresAt,
      awayRule: awayRule ?? this.awayRule,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FlatUpdateTable extends _isd.UpdateTable<FlatTable> {
  FlatUpdateTable(super.table);

  _isd.ColumnValue<String, String> name(String value) => _isd.ColumnValue(
    table.name,
    value,
  );

  _isd.ColumnValue<String, String> timezone(String value) => _isd.ColumnValue(
    table.timezone,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> adminMateId(
    _isc.UuidValue? value,
  ) => _isd.ColumnValue(
    table.adminMateId,
    value,
  );

  _isd.ColumnValue<String, String> inviteCode(String value) => _isd.ColumnValue(
    table.inviteCode,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> inviteExpiresAt(DateTime value) =>
      _isd.ColumnValue(
        table.inviteExpiresAt,
        value,
      );

  _isd.ColumnValue<_ij0lpv6z.AwayRule, _ij0lpv6z.AwayRule> awayRule(
    _ij0lpv6z.AwayRule value,
  ) => _isd.ColumnValue(
    table.awayRule,
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

class FlatTable extends _isd.Table<_isc.UuidValue?> {
  FlatTable({super.tableRelation}) : super(tableName: 'flat') {
    updateTable = FlatUpdateTable(this);
    name = _isd.ColumnString(
      'name',
      this,
    );
    timezone = _isd.ColumnString(
      'timezone',
      this,
    );
    adminMateId = _isd.ColumnUuid(
      'adminMateId',
      this,
    );
    inviteCode = _isd.ColumnString(
      'inviteCode',
      this,
    );
    inviteExpiresAt = _isd.ColumnDateTime(
      'inviteExpiresAt',
      this,
    );
    awayRule = _isd.ColumnEnum(
      'awayRule',
      this,
      _isd.EnumSerialization.byName,
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

  late final FlatUpdateTable updateTable;

  late final _isd.ColumnString name;

  /// IANA name, e.g. Asia/Kathmandu: when the Flat's days start and end.
  late final _isd.ColumnString timezone;

  late final _isd.ColumnUuid adminMateId;

  late final _isd.ColumnString inviteCode;

  /// When [inviteCode] stops working; 7 days after it was made.
  late final _isd.ColumnDateTime inviteExpiresAt;

  late final _isd.ColumnEnum<_ij0lpv6z.AwayRule> awayRule;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    name,
    timezone,
    adminMateId,
    inviteCode,
    inviteExpiresAt,
    awayRule,
    createdAt,
    updatedAt,
  ];
}

class FlatInclude extends _isd.IncludeObject {
  FlatInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Flat.t;
}

class FlatIncludeList extends _isd.IncludeList {
  FlatIncludeList._({
    _isd.WhereExpressionBuilder<FlatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Flat.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => Flat.t;
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
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Flat>(
      where: where?.call(Flat.t),
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
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
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<FlatTable>? where,
    int? offset,
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Flat>(
      where: where?.call(Flat.t),
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Flat] by its [id] or null if no such row exists.
  Future<Flat?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Flat>> insert(
    _isd.DatabaseSession session,
    List<Flat> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Flat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Flat] and returns the inserted row.
  ///
  /// The returned [Flat] will have its `id` field set.
  Future<Flat> insertRow(
    _isd.DatabaseSession session,
    Flat row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<Flat>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Flat]s in the list and returns the resulting rows.
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
  /// The returned [Flat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Flat>> upsert(
    _isd.DatabaseSession session,
    List<Flat> rows, {
    required _isd.ColumnSelections<FlatTable> conflictColumns,
    _isd.ColumnSelections<FlatTable>? updateColumns,
    _isd.WhereExpressionBuilder<FlatTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Flat>(
      rows,
      conflictColumns: conflictColumns(Flat.t),
      updateColumns: updateColumns?.call(Flat.t),
      updateWhere: updateWhere?.call(Flat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Flat] and returns the resulting row.
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
  /// The returned [Flat] will have its `id` field set.
  Future<Flat?> upsertRow(
    _isd.DatabaseSession session,
    Flat row, {
    required _isd.ColumnSelections<FlatTable> conflictColumns,
    _isd.ColumnSelections<FlatTable>? updateColumns,
    _isd.WhereExpressionBuilder<FlatTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Flat>(
      row,
      conflictColumns: conflictColumns(Flat.t),
      updateColumns: updateColumns?.call(Flat.t),
      updateWhere: updateWhere?.call(Flat.t),
      transaction: transaction,
    );
  }

  /// Updates all [Flat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Flat>> update(
    _isd.DatabaseSession session,
    List<Flat> rows, {
    _isd.ColumnSelections<FlatTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Flat>(
      rows,
      columns: columns?.call(Flat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Flat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Flat> updateRow(
    _isd.DatabaseSession session,
    Flat row, {
    _isd.ColumnSelections<FlatTable>? columns,
    _isd.Transaction? transaction,
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
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<FlatUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<Flat>(
      id,
      columnValues: columnValues(Flat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Flat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Flat>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<FlatUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<FlatTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Flat>(
      columnValues: columnValues(Flat.t.updateTable),
      where: where(Flat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Flat]s in the list and returns the deleted rows.
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
  Future<List<Flat>> delete(
    _isd.DatabaseSession session,
    List<Flat> rows, {
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Flat>(
      rows,
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Flat].
  Future<Flat> deleteRow(
    _isd.DatabaseSession session,
    Flat row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Flat>(
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
  Future<List<Flat>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<FlatTable> where,
    _isd.OrderByBuilder<FlatTable>? orderBy,
    _isd.OrderByListBuilder<FlatTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Flat>(
      where: where(Flat.t),
      orderBy: orderBy?.call(Flat.t),
      orderByList: orderByList?.call(Flat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<FlatTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<Flat>(
      where: where?.call(Flat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Flat] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<FlatTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Flat>(
      where: where(Flat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
