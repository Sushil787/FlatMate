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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// A period a Mate is not around to do Chores.
abstract class Away implements _i1.SerializableModel {
  Away._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.startsAt,
    required this.endsAt,
  });

  factory Away({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _AwayImpl;

  factory Away.fromJson(Map<String, dynamic> jsonSerialization) {
    return Away(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int flatId;

  int mateId;

  DateTime startsAt;

  DateTime endsAt;

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Away copyWith({
    int? id,
    int? flatId,
    int? mateId,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Away',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AwayImpl extends Away {
  _AwayImpl({
    int? id,
    required int flatId,
    required int mateId,
    required DateTime startsAt,
    required DateTime endsAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [Away]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Away copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    DateTime? startsAt,
    DateTime? endsAt,
  }) {
    return Away(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}
