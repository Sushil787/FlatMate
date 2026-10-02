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
import 'turn_status.dart' as _i2;

/// One Mate's responsibility for a Chore during one Rotation period.
abstract class Turn implements _i1.SerializableModel {
  Turn._({
    this.id,
    required this.flatId,
    required this.choreId,
    required this.mateId,
    this.coveringForMateId,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    this.doneAt,
  });

  factory Turn({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _i2.TurnStatus status,
    DateTime? doneAt,
  }) = _TurnImpl;

  factory Turn.fromJson(Map<String, dynamic> jsonSerialization) {
    return Turn(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      choreId: jsonSerialization['choreId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      coveringForMateId: jsonSerialization['coveringForMateId'] as int?,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      status: _i2.TurnStatus.fromJson((jsonSerialization['status'] as String)),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int flatId;

  int choreId;

  int mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  int? coveringForMateId;

  DateTime startsAt;

  DateTime endsAt;

  _i2.TurnStatus status;

  DateTime? doneAt;

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Turn copyWith({
    int? id,
    int? flatId,
    int? choreId,
    int? mateId,
    int? coveringForMateId,
    DateTime? startsAt,
    DateTime? endsAt,
    _i2.TurnStatus? status,
    DateTime? doneAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id,
      'flatId': flatId,
      'choreId': choreId,
      'mateId': mateId,
      if (coveringForMateId != null) 'coveringForMateId': coveringForMateId,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TurnImpl extends Turn {
  _TurnImpl({
    int? id,
    required int flatId,
    required int choreId,
    required int mateId,
    int? coveringForMateId,
    required DateTime startsAt,
    required DateTime endsAt,
    required _i2.TurnStatus status,
    DateTime? doneAt,
  }) : super._(
         id: id,
         flatId: flatId,
         choreId: choreId,
         mateId: mateId,
         coveringForMateId: coveringForMateId,
         startsAt: startsAt,
         endsAt: endsAt,
         status: status,
         doneAt: doneAt,
       );

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Turn copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? choreId,
    int? mateId,
    Object? coveringForMateId = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    _i2.TurnStatus? status,
    Object? doneAt = _Undefined,
  }) {
    return Turn(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      choreId: choreId ?? this.choreId,
      mateId: mateId ?? this.mateId,
      coveringForMateId: coveringForMateId is int?
          ? coveringForMateId
          : this.coveringForMateId,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
    );
  }
}
