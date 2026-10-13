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
import 'turn_status.dart' as _i5yk6qf9;

/// One Mate's responsibility for a Chore for one day.
abstract class Turn
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Turn._({
    this.id,
    required this.flatId,
    required this.choreId,
    required this.mateId,
    this.coveringForMateId,
    required this.day,
    required this.lastDay,
    required this.status,
    this.doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Turn({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue choreId,
    required _isc.UuidValue mateId,
    _isc.UuidValue? coveringForMateId,
    required DateTime day,
    required DateTime lastDay,
    required _i5yk6qf9.TurnStatus status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TurnImpl;

  factory Turn.fromJson(Map<String, dynamic> jsonSerialization) {
    return Turn(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      choreId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['choreId'],
      ),
      mateId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      coveringForMateId: jsonSerialization['coveringForMateId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['coveringForMateId'],
            ),
      day: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      lastDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastDay'],
      ),
      status: _i5yk6qf9.TurnStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      doneAt: jsonSerialization['doneAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['doneAt']),
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

  _isc.UuidValue choreId;

  _isc.UuidValue mateId;

  /// Set when [mateId] is doing this Turn on someone else's behalf (Swap).
  _isc.UuidValue? coveringForMateId;

  /// The Turn's day (12:00 UTC on that date, see day.dart).
  DateTime day;

  /// Inclusive; later than [day] only when Pause extended the Turn.
  DateTime lastDay;

  _i5yk6qf9.TurnStatus status;

  DateTime? doneAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Turn copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    _isc.UuidValue? choreId,
    _isc.UuidValue? mateId,
    _isc.UuidValue? coveringForMateId,
    DateTime? day,
    DateTime? lastDay,
    _i5yk6qf9.TurnStatus? status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'choreId': choreId.toJson(),
      'mateId': mateId.toJson(),
      if (coveringForMateId != null)
        'coveringForMateId': coveringForMateId?.toJson(),
      'day': day.toJson(),
      'lastDay': lastDay.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Turn',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'choreId': choreId.toJson(),
      'mateId': mateId.toJson(),
      if (coveringForMateId != null)
        'coveringForMateId': coveringForMateId?.toJson(),
      'day': day.toJson(),
      'lastDay': lastDay.toJson(),
      'status': status.toJson(),
      if (doneAt != null) 'doneAt': doneAt?.toJson(),
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

class _TurnImpl extends Turn {
  _TurnImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue choreId,
    required _isc.UuidValue mateId,
    _isc.UuidValue? coveringForMateId,
    required DateTime day,
    required DateTime lastDay,
    required _i5yk6qf9.TurnStatus status,
    DateTime? doneAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         choreId: choreId,
         mateId: mateId,
         coveringForMateId: coveringForMateId,
         day: day,
         lastDay: lastDay,
         status: status,
         doneAt: doneAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Turn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Turn copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    _isc.UuidValue? choreId,
    _isc.UuidValue? mateId,
    Object? coveringForMateId = _Undefined,
    DateTime? day,
    DateTime? lastDay,
    _i5yk6qf9.TurnStatus? status,
    Object? doneAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Turn(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      choreId: choreId ?? this.choreId,
      mateId: mateId ?? this.mateId,
      coveringForMateId: coveringForMateId is _isc.UuidValue?
          ? coveringForMateId
          : this.coveringForMateId,
      day: day ?? this.day,
      lastDay: lastDay ?? this.lastDay,
      status: status ?? this.status,
      doneAt: doneAt is DateTime? ? doneAt : this.doneAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
