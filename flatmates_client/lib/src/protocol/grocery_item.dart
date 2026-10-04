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

/// Something on the Flat's shared grocery list.
abstract class GroceryItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['boughtAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int flatId;

  String name;

  String? note;

  int addedByMateId;

  int? boughtByMateId;

  DateTime? boughtAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [GroceryItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
