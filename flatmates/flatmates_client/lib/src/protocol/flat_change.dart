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
import 'flat_change_kind.dart' as _i2;

/// Streamed to every open app in a Flat when something changes.
abstract class FlatChange implements _i1.SerializableModel {
  FlatChange._({required this.kind});

  factory FlatChange({required _i2.FlatChangeKind kind}) = _FlatChangeImpl;

  factory FlatChange.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatChange(
      kind: _i2.FlatChangeKind.fromJson((jsonSerialization['kind'] as String)),
    );
  }

  _i2.FlatChangeKind kind;

  /// Returns a shallow copy of this [FlatChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlatChange copyWith({_i2.FlatChangeKind? kind});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatChange',
      'kind': kind.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FlatChangeImpl extends FlatChange {
  _FlatChangeImpl({required _i2.FlatChangeKind kind}) : super._(kind: kind);

  /// Returns a shallow copy of this [FlatChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlatChange copyWith({_i2.FlatChangeKind? kind}) {
    return FlatChange(kind: kind ?? this.kind);
  }
}
