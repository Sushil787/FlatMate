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

/// A one-off happening on the Flat's shared calendar.
abstract class FlatEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FlatEvent._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.title,
    this.note,
    required this.startsAt,
    this.endsAt,
    bool? allDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : allDay = allDay ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory FlatEvent({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
    bool? allDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FlatEventImpl;

  factory FlatEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      flatId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['flatId']),
      mateId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['mateId']),
      title: jsonSerialization['title'] as String,
      note: jsonSerialization['note'] as String?,
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      allDay: jsonSerialization['allDay'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['allDay']),
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

  _isc.UuidValue mateId;

  String title;

  String? note;

  DateTime startsAt;

  /// Null for an Event with no set end. For an all-day Event the app sends
  /// local midnights: [startsAt] the first day's, [endsAt] the one after
  /// the last day (null for a single day).
  DateTime? endsAt;

  bool allDay;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FlatEvent copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    String? title,
    String? note,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? allDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'allDay': allDay,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id?.toJson(),
      'flatId': flatId.toJson(),
      'mateId': mateId.toJson(),
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'allDay': allDay,
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

class _FlatEventImpl extends FlatEvent {
  _FlatEventImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue flatId,
    required _isc.UuidValue mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
    bool? allDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         title: title,
         note: note,
         startsAt: startsAt,
         endsAt: endsAt,
         allDay: allDay,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FlatEvent copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? flatId,
    _isc.UuidValue? mateId,
    String? title,
    Object? note = _Undefined,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
    bool? allDay,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FlatEvent(
      id: id is _isc.UuidValue? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      title: title ?? this.title,
      note: note is String? ? note : this.note,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      allDay: allDay ?? this.allDay,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
