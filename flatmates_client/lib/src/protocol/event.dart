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
  });

  factory FlatEvent({
    int? id,
    required int flatId,
    required int mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
  }) = _FlatEventImpl;

  factory FlatEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatEvent(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      title: jsonSerialization['title'] as String,
      note: jsonSerialization['note'] as String?,
      startsAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int flatId;

  int mateId;

  String title;

  String? note;

  DateTime startsAt;

  DateTime? endsAt;

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FlatEvent copyWith({
    int? id,
    int? flatId,
    int? mateId,
    String? title,
    String? note,
    DateTime? startsAt,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlatEvent',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'title': title,
      if (note != null) 'note': note,
      'startsAt': startsAt.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
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
    int? id,
    required int flatId,
    required int mateId,
    required String title,
    String? note,
    required DateTime startsAt,
    DateTime? endsAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         title: title,
         note: note,
         startsAt: startsAt,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [FlatEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FlatEvent copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    String? title,
    Object? note = _Undefined,
    DateTime? startsAt,
    Object? endsAt = _Undefined,
  }) {
    return FlatEvent(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      title: title ?? this.title,
      note: note is String? ? note : this.note,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
    );
  }
}
