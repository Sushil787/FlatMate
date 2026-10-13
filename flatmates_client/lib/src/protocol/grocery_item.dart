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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  _isc.UuidValue flatId;

  String name;

  String? note;

  _isc.UuidValue addedByMateId;

  _isc.UuidValue? boughtByMateId;

  DateTime? boughtAt;

  DateTime createdAt;

  DateTime updatedAt;

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
