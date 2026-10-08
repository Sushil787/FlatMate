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

/// A text post on the Flat's notice board.
abstract class Notice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Notice._({
    this.id,
    required this.flatId,
    required this.mateId,
    required this.text,
    required this.pinned,
    this.gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Notice({
    int? id,
    required int flatId,
    required int mateId,
    required String text,
    required bool pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoticeImpl;

  factory Notice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notice(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      text: jsonSerialization['text'] as String,
      pinned: _isc.BoolJsonExtension.fromJson(jsonSerialization['pinned']),
      gotItMateIds: jsonSerialization['gotItMateIds'] == null
          ? null
          : _iyp1dgna.Protocol().deserialize<List<int>>(
              jsonSerialization['gotItMateIds'],
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

  String text;

  bool pinned;

  /// Mates who said "Got it"; filled in by list().
  List<int>? gotItMateIds;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Notice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Notice copyWith({
    int? id,
    int? flatId,
    int? mateId,
    String? text,
    bool? pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null) 'gotItMateIds': gotItMateIds?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Notice',
      if (id != null) 'id': id,
      'flatId': flatId,
      'mateId': mateId,
      'text': text,
      'pinned': pinned,
      if (gotItMateIds != null) 'gotItMateIds': gotItMateIds?.toJson(),
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

class _NoticeImpl extends Notice {
  _NoticeImpl({
    int? id,
    required int flatId,
    required int mateId,
    required String text,
    required bool pinned,
    List<int>? gotItMateIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         mateId: mateId,
         text: text,
         pinned: pinned,
         gotItMateIds: gotItMateIds,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Notice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Notice copyWith({
    Object? id = _Undefined,
    int? flatId,
    int? mateId,
    String? text,
    bool? pinned,
    Object? gotItMateIds = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notice(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      mateId: mateId ?? this.mateId,
      text: text ?? this.text,
      pinned: pinned ?? this.pinned,
      gotItMateIds: gotItMateIds is List<int>?
          ? gotItMateIds
          : this.gotItMateIds?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
