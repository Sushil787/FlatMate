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

/// A period of whole days a Mate is not around to do Chores.
/// Days are stored as 12:00 UTC on that date (see day.dart).
abstract class Away
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Away._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.startDay,
    required this.lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Away({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startDay,
    required DateTime lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AwayImpl;

  factory Away.fromJson(Map<String, dynamic> jsonSerialization) {
    return Away(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      startDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDay'],
      ),
      lastDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastDay'],
      ),
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
  int? id;

  int flatId;

  int mateId;

  DateTime startDay;

  /// Inclusive.
  DateTime lastDay;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Away copyWith({
    int? id,
    int? flatId,
    int? mateId,
    DateTime? startDay,
    DateTime? lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'startDay': startDay.toJson(),
      'lastDay': lastDay.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'startDay': startDay.toJson(),
      'lastDay': lastDay.toJson(),
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

class _AwayImpl extends Away {
  _AwayImpl({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startDay,
    required DateTime lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         startDay: startDay,
         lastDay: lastDay,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Away copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    DateTime? startDay,
    DateTime? lastDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Away(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      startDay: startDay ?? this.startDay,
      lastDay: lastDay ?? this.lastDay,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
