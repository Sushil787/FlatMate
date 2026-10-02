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

/// Something on the Flat's shared grocery list.
abstract class GroceryItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GroceryItem._({
    this.id,
    required this.flatId,
    required this.name,
    this.note,
    required this.addedByMateId,
    this.boughtByMateId,
    this.boughtAt,
    required this.createdAt,
  });

  factory GroceryItem({
    int? id,
    required int flatId,
    required String name,
    String? note,
    required int addedByMateId,
    int? boughtByMateId,
    DateTime? boughtAt,
    required DateTime createdAt,
  }) = _GroceryItemImpl;

  factory GroceryItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return GroceryItem(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      name: jsonSerialization['name'] as String,
      note: jsonSerialization['note'] as String?,
      addedByMateId: jsonSerialization['addedByMateId'] as int,
      boughtByMateId: jsonSerialization['boughtByMateId'] as int?,
      boughtAt: jsonSerialization['boughtAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['boughtAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = GroceryItemTable();

  static const db = GroceryItemRepository._();

  @override
  int? id;

  int flatId;

  String name;

  String? note;

  int addedByMateId;

  int? boughtByMateId;

  DateTime? boughtAt;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GroceryItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GroceryItem copyWith({
    int? id,
    int? flatId,
    String? name,
    String? note,
    int? addedByMateId,
    int? boughtByMateId,
    DateTime? boughtAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GroceryItem',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      if (note != null) 'note': note,
      'addedByMateId': addedByMateId,
      if (boughtByMateId != null) 'boughtByMateId': boughtByMateId,
      if (boughtAt != null) 'boughtAt': boughtAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GroceryItem',
      if (id != null) 'id': id,
      'flatId': flatId,
      'name': name,
      if (note != null) 'note': note,
      'addedByMateId': addedByMateId,
      if (boughtByMateId != null) 'boughtByMateId': boughtByMateId,
      if (boughtAt != null) 'boughtAt': boughtAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static GroceryItemInclude include() {
    return GroceryItemInclude._();
  }

  static GroceryItemIncludeList includeList({
    _i1.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GroceryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroceryItemTable>? orderByList,
    GroceryItemInclude? include,
  }) {
    return GroceryItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GroceryItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GroceryItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GroceryItemImpl extends GroceryItem {
  _GroceryItemImpl({
    int? id,
    required int flatId,
    required String name,
    String? note,
    required int addedByMateId,
    int? boughtByMateId,
    DateTime? boughtAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         flatId: flatId,
         name: name,
         note: note,
         addedByMateId: addedByMateId,
         boughtByMateId: boughtByMateId,
         boughtAt: boughtAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [GroceryItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GroceryItem copyWith({
    Object? id = _Undefined,
    int? flatId,
    String? name,
    Object? note = _Undefined,
    int? addedByMateId,
    Object? boughtByMateId = _Undefined,
    Object? boughtAt = _Undefined,
    DateTime? createdAt,
  }) {
    return GroceryItem(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      note: note is String? ? note : this.note,
      addedByMateId: addedByMateId ?? this.addedByMateId,
      boughtByMateId: boughtByMateId is int?
          ? boughtByMateId
          : this.boughtByMateId,
      boughtAt: boughtAt is DateTime? ? boughtAt : this.boughtAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class GroceryItemUpdateTable extends _i1.UpdateTable<GroceryItemTable> {
  GroceryItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> flatId(int value) => _i1.ColumnValue(
    table.flatId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<int, int> addedByMateId(int value) => _i1.ColumnValue(
    table.addedByMateId,
    value,
  );

  _i1.ColumnValue<int, int> boughtByMateId(int? value) => _i1.ColumnValue(
    table.boughtByMateId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> boughtAt(DateTime? value) =>
      _i1.ColumnValue(
        table.boughtAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class GroceryItemTable extends _i1.Table<int?> {
  GroceryItemTable({super.tableRelation}) : super(tableName: 'grocery_item') {
    updateTable = GroceryItemUpdateTable(this);
    flatId = _i1.ColumnInt(
      'flatId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    addedByMateId = _i1.ColumnInt(
      'addedByMateId',
      this,
    );
    boughtByMateId = _i1.ColumnInt(
      'boughtByMateId',
      this,
    );
    boughtAt = _i1.ColumnDateTime(
      'boughtAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final GroceryItemUpdateTable updateTable;

  late final _i1.ColumnInt flatId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString note;

  late final _i1.ColumnInt addedByMateId;

  late final _i1.ColumnInt boughtByMateId;

  late final _i1.ColumnDateTime boughtAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flatId,
    name,
    note,
    addedByMateId,
    boughtByMateId,
    boughtAt,
    createdAt,
  ];
}

class GroceryItemInclude extends _i1.IncludeObject {
  GroceryItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GroceryItem.t;
}

class GroceryItemIncludeList extends _i1.IncludeList {
  GroceryItemIncludeList._({
    _i1.WhereExpressionBuilder<GroceryItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GroceryItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GroceryItem.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GroceryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroceryItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GroceryItem>(
      where: where?.call(GroceryItem.t),
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GroceryItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<GroceryItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GroceryItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GroceryItem>(
      where: where?.call(GroceryItem.t),
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GroceryItem] by its [id] or null if no such row exists.
  Future<GroceryItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<GroceryItem>> insert(
    _i1.DatabaseSession session,
    List<GroceryItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<GroceryItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [GroceryItem] and returns the inserted row.
  ///
  /// The returned [GroceryItem] will have its `id` field set.
  Future<GroceryItem> insertRow(
    _i1.DatabaseSession session,
    GroceryItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GroceryItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GroceryItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GroceryItem>> update(
    _i1.DatabaseSession session,
    List<GroceryItem> rows, {
    _i1.ColumnSelections<GroceryItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GroceryItem>(
      rows,
      columns: columns?.call(GroceryItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GroceryItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GroceryItem> updateRow(
    _i1.DatabaseSession session,
    GroceryItem row, {
    _i1.ColumnSelections<GroceryItemTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<GroceryItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GroceryItem>(
      id,
      columnValues: columnValues(GroceryItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GroceryItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GroceryItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<GroceryItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GroceryItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GroceryItemTable>? orderBy,
    _i1.OrderByListBuilder<GroceryItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GroceryItem>(
      columnValues: columnValues(GroceryItem.t.updateTable),
      where: where(GroceryItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GroceryItem.t),
      orderByList: orderByList?.call(GroceryItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GroceryItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GroceryItem>> delete(
    _i1.DatabaseSession session,
    List<GroceryItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GroceryItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GroceryItem].
  Future<GroceryItem> deleteRow(
    _i1.DatabaseSession session,
    GroceryItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GroceryItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GroceryItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GroceryItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GroceryItem>(
      where: where(GroceryItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GroceryItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GroceryItem>(
      where: where?.call(GroceryItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GroceryItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GroceryItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GroceryItem>(
      where: where(GroceryItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
