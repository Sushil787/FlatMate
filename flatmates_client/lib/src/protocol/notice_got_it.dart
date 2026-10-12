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

/// A Mate saying "Got it" on a Notice: they've read it.
abstract class NoticeGotIt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  NoticeGotIt._({
    this.id,
    required this.noticeId,
    required this.mateId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory NoticeGotIt({
    int? id,
    required int noticeId,
    required int mateId,
    DateTime? createdAt,
  }) = _NoticeGotItImpl;

  factory NoticeGotIt.fromJson(Map<String, dynamic> jsonSerialization) {
    return NoticeGotIt(
      id: jsonSerialization['id'] as int?,
      noticeId: jsonSerialization['noticeId'] as int,
      mateId: jsonSerialization['mateId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int noticeId;

  int mateId;

  DateTime createdAt;

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  NoticeGotIt copyWith({
    int? id,
    int? noticeId,
    int? mateId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NoticeGotIt',
      if (id != null) 'id': id,
      'noticeId': noticeId,
      'mateId': mateId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NoticeGotIt',
      if (id != null) 'id': id,
      'noticeId': noticeId,
      'mateId': mateId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NoticeGotItImpl extends NoticeGotIt {
  _NoticeGotItImpl({
    int? id,
    required int noticeId,
    required int mateId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         noticeId: noticeId,
         mateId: mateId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [NoticeGotIt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  NoticeGotIt copyWith({
    Object? id = _Undefined,
    int? noticeId,
    int? mateId,
    DateTime? createdAt,
  }) {
    return NoticeGotIt(
      id: id is int? ? id : this.id,
      noticeId: noticeId ?? this.noticeId,
      mateId: mateId ?? this.mateId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
