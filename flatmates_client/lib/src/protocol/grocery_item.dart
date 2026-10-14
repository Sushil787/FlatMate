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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;

/// Something on the Flat's shared grocery list.
abstract class GroceryItem
    implements _isd.TableRow<_isc.UuidValue?>, _isc.ProtocolSerialization {
  GroceryItem._({
    this.id,
    required this.flatId,
    required this.name,
    this.note,
    required this.addedByMateId,
    this.boughtByMateId,
    this.boughtAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory GroceryItem({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    String? note,
    required _isc.UuidValue addedByMateId,
    _isc.UuidValue? boughtByMateId,
    DateTime? boughtAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GroceryItemImpl;

  factory GroceryItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return GroceryItem(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      name: jsonSerialization['name'] as String,
      note: jsonSerialization['note'] as String?,
      addedByMateId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['addedByMateId'],
      ),
      boughtByMateId: jsonSerialization['boughtByMateId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['boughtByMateId'],
            ),
      boughtAt: jsonSerialization['boughtAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['boughtAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = GroceryItemTable();

  static const db = GroceryItemRepository._();

  @override
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  String name;

  String? note;

  _isc.UuidValue addedByMateId;

  _isc.UuidValue? boughtByMateId;

  DateTime? boughtAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _isd.Table<_isc.UuidValue?> get table => t;

  /// Returns a shallow copy of this [GroceryItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GroceryItem copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    String? name,
    String? note,
    _isc.UuidValue? addedByMateId,
    _isc.UuidValue? boughtByMateId,
    DateTime? boughtAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GroceryItem',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      if (note != null) 'note': note,
      'addedByMateId': addedByMateId.toJson(),
      if (boughtByMateId != null) 'boughtByMateId': boughtByMateId?.toJson(),
      if (boughtAt != null) 'boughtAt': boughtAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GroceryItem',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      if (note != null) 'note': note,
      'addedByMateId': addedByMateId.toJson(),
      if (boughtByMateId != null) 'boughtByMateId': boughtByMateId?.toJson(),
      if (boughtAt != null) 'boughtAt': boughtAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static GroceryItemInclude include() {
    return GroceryItemInclude._();
  }

  static GroceryItemIncludeList includeList({
    _isd.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    GroceryItemInclude? include,
  }) {
    return GroceryItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GroceryItemImpl extends GroceryItem {
  _GroceryItemImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    String? note,
    required _isc.UuidValue addedByMateId,
    _isc.UuidValue? boughtByMateId,
    DateTime? boughtAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         name: name,
         note: note,
         addedByMateId: addedByMateId,
         boughtByMateId: boughtByMateId,
         boughtAt: boughtAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GroceryItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GroceryItem copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    String? name,
    Object? note = _Undefined,
    _isc.UuidValue? addedByMateId,
    Object? boughtByMateId = _Undefined,
    Object? boughtAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroceryItem(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      note: note is String? ? note : this.note,
      addedByMateId: addedByMateId ?? this.addedByMateId,
      boughtByMateId: boughtByMateId is _isc.UuidValue?
          ? boughtByMateId
          : this.boughtByMateId,
      boughtAt: boughtAt is DateTime? ? boughtAt : this.boughtAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class GroceryItemUpdateTable extends _isd.UpdateTable<GroceryItemTable> {
  GroceryItemUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> flatId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.flatId,
    value,
  );

  _isd.ColumnValue<String, String> name(String value) => _isd.ColumnValue(
    table.name,
    value,
  );

  _isd.ColumnValue<String, String> note(String? value) => _isd.ColumnValue(
    table.note,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> addedByMateId(
    _isc.UuidValue value,
  ) => _isd.ColumnValue(
    table.addedByMateId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> boughtByMateId(
    _isc.UuidValue? value,
  ) => _isd.ColumnValue(
    table.boughtByMateId,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> boughtAt(DateTime? value) =>
      _isd.ColumnValue(
        table.boughtAt,
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

class GroceryItemTable extends _isd.Table<_isc.UuidValue?> {
  GroceryItemTable({super.tableRelation}) : super(tableName: 'grocery_item') {
    updateTable = GroceryItemUpdateTable(this);
    flatId = _isd.ColumnUuid(
      'flatId',
      this,
    );
    name = _isd.ColumnString(
      'name',
      this,
    );
    note = _isd.ColumnString(
      'note',
      this,
    );
    addedByMateId = _isd.ColumnUuid(
      'addedByMateId',
      this,
    );
    boughtByMateId = _isd.ColumnUuid(
      'boughtByMateId',
      this,
    );
    boughtAt = _isd.ColumnDateTime(
      'boughtAt',
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

  late final GroceryItemUpdateTable updateTable;

  late final _isd.ColumnUuid flatId;

  late final _isd.ColumnString name;

  late final _isd.ColumnString note;

  late final _isd.ColumnUuid addedByMateId;

  late final _isd.ColumnUuid boughtByMateId;

  late final _isd.ColumnDateTime boughtAt;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    flatId,
    name,
    note,
    addedByMateId,
    boughtByMateId,
    boughtAt,
    createdAt,
    updatedAt,
  ];
}

class GroceryItemInclude extends _isd.IncludeObject {
  GroceryItemInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<_isc.UuidValue?> get table => GroceryItem.t;
}

class GroceryItemIncludeList extends _isd.IncludeList {
  GroceryItemIncludeList._({
    _isd.WhereExpressionBuilder<GroceryItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GroceryItem.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<_isc.UuidValue?> get table => GroceryItem.t;
}

class GroceryItemRepository {
  const GroceryItemRepository._();

  /// Returns a list of [GroceryItem]s matching the given query parameters.
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
  Future<List<GroceryItem>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GroceryItem>(
      where: where?.call(GroceryItem.t),
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GroceryItem] matching the given query parameters.
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
  Future<GroceryItem?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<GroceryItemTable>? where,
    int? offset,
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GroceryItem>(
      where: where?.call(GroceryItem.t),
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GroceryItem] by its [id] or null if no such row exists.
  Future<GroceryItem?> findById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GroceryItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GroceryItem]s in the list and returns the inserted rows.
  ///
  /// The returned [GroceryItem]s will have their `id` fields set.
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
  Future<List<GroceryItem>> insert(
    _isd.DatabaseSession session,
    List<GroceryItem> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<GroceryItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [GroceryItem] and returns the inserted row.
  ///
  /// The returned [GroceryItem] will have its `id` field set.
  Future<GroceryItem> insertRow(
    _isd.DatabaseSession session,
    GroceryItem row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<GroceryItem>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [GroceryItem]s in the list and returns the resulting rows.
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
  /// The returned [GroceryItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GroceryItem>> upsert(
    _isd.DatabaseSession session,
    List<GroceryItem> rows, {
    required _isd.ColumnSelections<GroceryItemTable> conflictColumns,
    _isd.ColumnSelections<GroceryItemTable>? updateColumns,
    _isd.WhereExpressionBuilder<GroceryItemTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<GroceryItem>(
      rows,
      conflictColumns: conflictColumns(GroceryItem.t),
      updateColumns: updateColumns?.call(GroceryItem.t),
      updateWhere: updateWhere?.call(GroceryItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [GroceryItem] and returns the resulting row.
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
  /// The returned [GroceryItem] will have its `id` field set.
  Future<GroceryItem?> upsertRow(
    _isd.DatabaseSession session,
    GroceryItem row, {
    required _isd.ColumnSelections<GroceryItemTable> conflictColumns,
    _isd.ColumnSelections<GroceryItemTable>? updateColumns,
    _isd.WhereExpressionBuilder<GroceryItemTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<GroceryItem>(
      row,
      conflictColumns: conflictColumns(GroceryItem.t),
      updateColumns: updateColumns?.call(GroceryItem.t),
      updateWhere: updateWhere?.call(GroceryItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [GroceryItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GroceryItem>> update(
    _isd.DatabaseSession session,
    List<GroceryItem> rows, {
    _isd.ColumnSelections<GroceryItemTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<GroceryItem>(
      rows,
      columns: columns?.call(GroceryItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [GroceryItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GroceryItem> updateRow(
    _isd.DatabaseSession session,
    GroceryItem row, {
    _isd.ColumnSelections<GroceryItemTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<GroceryItem>(
      row,
      columns: columns?.call(GroceryItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GroceryItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GroceryItem?> updateById(
    _isd.DatabaseSession session,
    _isc.UuidValue id, {
    required _isd.ColumnValueListBuilder<GroceryItemUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<GroceryItem>(
      id,
      columnValues: columnValues(GroceryItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GroceryItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GroceryItem>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<GroceryItemUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<GroceryItemTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<GroceryItem>(
      columnValues: columnValues(GroceryItem.t.updateTable),
      where: where(GroceryItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [GroceryItem]s in the list and returns the deleted rows.
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
  Future<List<GroceryItem>> delete(
    _isd.DatabaseSession session,
    List<GroceryItem> rows, {
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<GroceryItem>(
      rows,
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [GroceryItem].
  Future<GroceryItem> deleteRow(
    _isd.DatabaseSession session,
    GroceryItem row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GroceryItem>(
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
  Future<List<GroceryItem>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<GroceryItemTable> where,
    _isd.OrderByBuilder<GroceryItemTable>? orderBy,
    _isd.OrderByListBuilder<GroceryItemTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<GroceryItem>(
      where: where(GroceryItem.t),
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<GroceryItem>(
      where: where?.call(GroceryItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GroceryItem] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<GroceryItemTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GroceryItem>(
      where: where(GroceryItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
