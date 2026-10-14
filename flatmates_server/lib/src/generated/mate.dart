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
import 'mate_color.dart' as _ieys87jp;

/// A member of a Flat. A Mate with [leftAt] set has left the Flat.
abstract class Mate
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Mate._({
    this.id,
    required this.flatId,
    required this.authUserId,
    required this.displayName,
    required this.joinedAt,
    this.leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    this.onboardedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : color = color ?? _ieys87jp.MateColor.tomato,
       notifyTurnStarts = notifyTurnStarts ?? true,
       notifyReminder = notifyReminder ?? true,
       notifyMatesNotDone = notifyMatesNotDone ?? true,
       notifyNotice = notifyNotice ?? true,
       notifyAddedToRotation = notifyAddedToRotation ?? true,
       welcomed = welcomed ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Mate({
    _is.UuidValue? id,
    required _is.UuidValue flatId,
    required _is.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? onboardedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MateImpl;

  factory Mate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mate(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      joinedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      leftAt: jsonSerialization['leftAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['leftAt']),
      color: jsonSerialization['color'] == null
          ? null
          : _ieys87jp.MateColor.fromJson(
              (jsonSerialization['color'] as String),
            ),
      notifyTurnStarts: jsonSerialization['notifyTurnStarts'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['notifyTurnStarts'],
            ),
      notifyReminder: jsonSerialization['notifyReminder'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['notifyReminder']),
      notifyMatesNotDone: jsonSerialization['notifyMatesNotDone'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['notifyMatesNotDone'],
            ),
      notifyNotice: jsonSerialization['notifyNotice'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['notifyNotice']),
      notifyAddedToRotation: jsonSerialization['notifyAddedToRotation'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['notifyAddedToRotation'],
            ),
      welcomed: jsonSerialization['welcomed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['welcomed']),
      onboardedAt: jsonSerialization['onboardedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['onboardedAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = MateTable();

  static const db = MateRepository._();

  @override
  _is.UuidValue? id;

  _is.UuidValue flatId;

  _is.UuidValue authUserId;

  String displayName;

  DateTime joinedAt;

  DateTime? leftAt;

  _ieys87jp.MateColor color;

  /// Which push notifications the Mate wants.
  bool notifyTurnStarts;

  bool notifyReminder;

  /// The evening push about other Mates' Turns not Done yet.
  bool notifyMatesNotDone;

  bool notifyNotice;

  bool notifyAddedToRotation;

  /// False until the Admin has seen that this Mate joined and picked their
  /// Chores (or chose to do it later).
  bool welcomed;

  /// When the Mate finished the practice run after joining or creating the
  /// Flat; null until then, so the app shows it again.
  DateTime? onboardedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Mate copyWith({
    _is.UuidValue? id,
    _is.UuidValue? flatId,
    _is.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? onboardedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMatesNotDone': notifyMatesNotDone,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
      'welcomed': welcomed,
      if (onboardedAt != null) 'onboardedAt': onboardedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMatesNotDone': notifyMatesNotDone,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
      'welcomed': welcomed,
      if (onboardedAt != null) 'onboardedAt': onboardedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MateInclude include() {
    return MateInclude._();
  }

  static MateIncludeList includeList({
    _is.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    MateInclude? include,
  }) {
    return MateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MateImpl extends Mate {
  _MateImpl({
    _is.UuidValue? id,
    required _is.UuidValue flatId,
    required _is.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    DateTime? onboardedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         authUserId: authUserId,
         displayName: displayName,
         joinedAt: joinedAt,
         leftAt: leftAt,
         color: color,
         notifyTurnStarts: notifyTurnStarts,
         notifyReminder: notifyReminder,
         notifyMatesNotDone: notifyMatesNotDone,
         notifyNotice: notifyNotice,
         notifyAddedToRotation: notifyAddedToRotation,
         welcomed: welcomed,
         onboardedAt: onboardedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Mate copyWith({
    Object? id = _Undefined,
    _is.UuidValue? flatId,
    _is.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    Object? leftAt = _Undefined,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMatesNotDone,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    bool? welcomed,
    Object? onboardedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mate(
      id: id is _is.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt is DateTime? ? leftAt : this.leftAt,
      color: color ?? this.color,
      notifyTurnStarts: notifyTurnStarts ?? this.notifyTurnStarts,
      notifyReminder: notifyReminder ?? this.notifyReminder,
      notifyMatesNotDone: notifyMatesNotDone ?? this.notifyMatesNotDone,
      notifyNotice: notifyNotice ?? this.notifyNotice,
      notifyAddedToRotation:
          notifyAddedToRotation ?? this.notifyAddedToRotation,
      welcomed: welcomed ?? this.welcomed,
      onboardedAt: onboardedAt is DateTime? ? onboardedAt : this.onboardedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MateUpdateTable extends _is.UpdateTable<MateTable> {
  MateUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> flatId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.flatId,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> leftAt(DateTime? value) =>
      _is.ColumnValue(
        table.leftAt,
        value,
      );

  _is.ColumnValue<_ieys87jp.MateColor, _ieys87jp.MateColor> color(
    _ieys87jp.MateColor value,
  ) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<bool, bool> notifyTurnStarts(bool value) => _is.ColumnValue(
    table.notifyTurnStarts,
    value,
  );

  _is.ColumnValue<bool, bool> notifyReminder(bool value) => _is.ColumnValue(
    table.notifyReminder,
    value,
  );

  _is.ColumnValue<bool, bool> notifyMatesNotDone(bool value) => _is.ColumnValue(
    table.notifyMatesNotDone,
    value,
  );

  _is.ColumnValue<bool, bool> notifyNotice(bool value) => _is.ColumnValue(
    table.notifyNotice,
    value,
  );

  _is.ColumnValue<bool, bool> notifyAddedToRotation(bool value) =>
      _is.ColumnValue(
        table.notifyAddedToRotation,
        value,
      );

  _is.ColumnValue<bool, bool> welcomed(bool value) => _is.ColumnValue(
    table.welcomed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> onboardedAt(DateTime? value) =>
      _is.ColumnValue(
        table.onboardedAt,
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

class MateTable extends _is.Table<_is.UuidValue?> {
  MateTable({super.tableRelation}) : super(tableName: 'mate') {
    updateTable = MateUpdateTable(this);
    flatId = _is.ColumnUuid(
      'flatId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
    );
    leftAt = _is.ColumnDateTime(
      'leftAt',
      this,
    );
    color = _is.ColumnEnum(
      'color',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    notifyTurnStarts = _is.ColumnBool(
      'notifyTurnStarts',
      this,
      hasDefault: true,
    );
    notifyReminder = _is.ColumnBool(
      'notifyReminder',
      this,
      hasDefault: true,
    );
    notifyMatesNotDone = _is.ColumnBool(
      'notifyMatesNotDone',
      this,
      hasDefault: true,
    );
    notifyNotice = _is.ColumnBool(
      'notifyNotice',
      this,
      hasDefault: true,
    );
    notifyAddedToRotation = _is.ColumnBool(
      'notifyAddedToRotation',
      this,
      hasDefault: true,
    );
    welcomed = _is.ColumnBool(
      'welcomed',
      this,
      hasDefault: true,
    );
    onboardedAt = _is.ColumnDateTime(
      'onboardedAt',
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

  late final MateUpdateTable updateTable;

  late final _is.ColumnUuid flatId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString displayName;

  late final _is.ColumnDateTime joinedAt;

  late final _is.ColumnDateTime leftAt;

  late final _is.ColumnEnum<_ieys87jp.MateColor> color;

  /// Which push notifications the Mate wants.
  late final _is.ColumnBool notifyTurnStarts;

  late final _is.ColumnBool notifyReminder;

  /// The evening push about other Mates' Turns not Done yet.
  late final _is.ColumnBool notifyMatesNotDone;

  late final _is.ColumnBool notifyNotice;

  late final _is.ColumnBool notifyAddedToRotation;

  /// False until the Admin has seen that this Mate joined and picked their
  /// Chores (or chose to do it later).
  late final _is.ColumnBool welcomed;

  /// When the Mate finished the practice run after joining or creating the
  /// Flat; null until then, so the app shows it again.
  late final _is.ColumnDateTime onboardedAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    flatId,
    authUserId,
    displayName,
    joinedAt,
    leftAt,
    color,
    notifyTurnStarts,
    notifyReminder,
    notifyMatesNotDone,
    notifyNotice,
    notifyAddedToRotation,
    welcomed,
    onboardedAt,
    createdAt,
    updatedAt,
  ];
}

class MateInclude extends _is.IncludeObject {
  MateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => Mate.t;
}

class MateIncludeList extends _is.IncludeList {
  MateIncludeList._({
    _is.WhereExpressionBuilder<MateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Mate.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MateTable>? where,
    int? offset,
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mate>(
      where: where?.call(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mate] by its [id] or null if no such row exists.
  Future<Mate?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> insert(
    _is.DatabaseSession session,
    List<Mate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Mate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Mate] and returns the inserted row.
  ///
  /// The returned [Mate] will have its `id` field set.
  Future<Mate> insertRow(
    _is.DatabaseSession session,
    Mate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Mate]s in the list and returns the resulting rows.
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
  /// The returned [Mate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> upsert(
    _is.DatabaseSession session,
    List<Mate> rows, {
    required _is.ColumnSelections<MateTable> conflictColumns,
    _is.ColumnSelections<MateTable>? updateColumns,
    _is.WhereExpressionBuilder<MateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Mate>(
      rows,
      conflictColumns: conflictColumns(Mate.t),
      updateColumns: updateColumns?.call(Mate.t),
      updateWhere: updateWhere?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Mate] and returns the resulting row.
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
  /// The returned [Mate] will have its `id` field set.
  Future<Mate?> upsertRow(
    _is.DatabaseSession session,
    Mate row, {
    required _is.ColumnSelections<MateTable> conflictColumns,
    _is.ColumnSelections<MateTable>? updateColumns,
    _is.WhereExpressionBuilder<MateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Mate>(
      row,
      conflictColumns: conflictColumns(Mate.t),
      updateColumns: updateColumns?.call(Mate.t),
      updateWhere: updateWhere?.call(Mate.t),
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> update(
    _is.DatabaseSession session,
    List<Mate> rows, {
    _is.ColumnSelections<MateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Mate>(
      rows,
      columns: columns?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Mate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mate> updateRow(
    _is.DatabaseSession session,
    Mate row, {
    _is.ColumnSelections<MateTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<MateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Mate>(
      id,
      columnValues: columnValues(Mate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Mate>(
      columnValues: columnValues(Mate.t.updateTable),
      where: where(Mate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Mate]s in the list and returns the deleted rows.
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
  Future<List<Mate>> delete(
    _is.DatabaseSession session,
    List<Mate> rows, {
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Mate>(
      rows,
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Mate].
  Future<Mate> deleteRow(
    _is.DatabaseSession session,
    Mate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mate>(
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
  Future<List<Mate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MateTable> where,
    _is.OrderByBuilder<MateTable>? orderBy,
    _is.OrderByListBuilder<MateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Mate>(
      where: where(Mate.t),
      orderBy: orderBy?.call(Mate.t),
      orderByList: orderByList?.call(Mate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Mate>(
      where: where?.call(Mate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mate>(
      where: where(Mate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
