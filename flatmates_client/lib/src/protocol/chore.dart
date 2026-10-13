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
import 'package:flatmates_client/src/protocol/protocol.dart' as _iyp1dgna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// A recurring responsibility passed round-robin through [rotation].
abstract class Chore
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Chore._({
    this.id,
    required this.flatId,
    required this.name,
    required this.period,
    required this.startDay,
    required this.rotation,
    required this.rotationIndex,
    required this.archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Chore({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<_isc.UuidValue> rotation,
    required int rotationIndex,
    required bool archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChoreImpl;

  factory Chore.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chore(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      name: jsonSerialization['name'] as String,
      period: _isc.DurationJsonExtension.fromJson(jsonSerialization['period']),
      startDay: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDay'],
      ),
      rotation: _iyp1dgna.Protocol().deserialize<List<_isc.UuidValue>>(
        jsonSerialization['rotation'],
      ),
      rotationIndex: jsonSerialization['rotationIndex'] as int,
      archived: _isc.BoolJsonExtension.fromJson(jsonSerialization['archived']),
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

  /// Rotation period: time from one Turn's start to the next, whole days.
  Duration period;

  /// The day of the first Turn (12:00 UTC on that date, see day.dart).
  DateTime startDay;

  /// Mate ids in order; a Mate may appear more than once.
  List<_isc.UuidValue> rotation;

  /// Index in [rotation] of the slot the latest Turn was taken from.
  int rotationIndex;

  bool archived;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Chore copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<_isc.UuidValue>? rotation,
    int? rotationIndex,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(valueToJson: (v) => v.toJson()),
      'rotationIndex': rotationIndex,
      'archived': archived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chore',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'name': name,
      'period': period.toJson(),
      'startDay': startDay.toJson(),
      'rotation': rotation.toJson(valueToJson: (v) => v.toJson()),
      'rotationIndex': rotationIndex,
      'archived': archived,
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

class _ChoreImpl extends Chore {
  _ChoreImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<_isc.UuidValue> rotation,
    required int rotationIndex,
    required bool archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         name: name,
         period: period,
         startDay: startDay,
         rotation: rotation,
         rotationIndex: rotationIndex,
         archived: archived,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chore]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Chore copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    String? name,
    Duration? period,
    DateTime? startDay,
    List<_isc.UuidValue>? rotation,
    int? rotationIndex,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chore(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      name: name ?? this.name,
      period: period ?? this.period,
      startDay: startDay ?? this.startDay,
      rotation: rotation ?? this.rotation.map((e0) => e0).toList(),
      rotationIndex: rotationIndex ?? this.rotationIndex,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
