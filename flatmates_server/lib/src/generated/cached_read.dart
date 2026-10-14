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
import 'package:serverpod/serverpod.dart' as _is;

/// The app's offline cache: one row per read call whose answer is saved
/// in the mirrored tables. Only on the phone; a read without one has
/// nothing saved, even if some of its rows are there from other reads.
abstract class CachedRead
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CachedRead._({
    this.id,
    required this.key,
    required this.savedAt,
  });

  factory CachedRead({
    int? id,
    required String key,
    required DateTime savedAt,
  }) = _CachedReadImpl;

  factory CachedRead.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedRead(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      savedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['savedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The read call and its arguments, e.g. "turn:2026-10-01:2026-11-07".
  String key;

  DateTime savedAt;

  /// Returns a shallow copy of this [CachedRead]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CachedRead copyWith({
    int? id,
    String? key,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedRead',
      if (id != null) 'id': id,
      'key': key,
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachedRead',
      if (id != null) 'id': id,
      'key': key,
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachedReadImpl extends CachedRead {
  _CachedReadImpl({
    int? id,
    required String key,
    required DateTime savedAt,
  }) : super._(
         id: id,
         key: key,
         savedAt: savedAt,
       );

  /// Returns a shallow copy of this [CachedRead]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CachedRead copyWith({
    Object? id = _Undefined,
    String? key,
    DateTime? savedAt,
  }) {
    return CachedRead(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}
