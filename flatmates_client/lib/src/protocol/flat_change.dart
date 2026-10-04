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
import 'flat_change_kind.dart' as _iyrv7gay;

/// Streamed to every open app in a Flat when something changes.
abstract class FlatChange
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FlatChange._({required this.kind});

  factory FlatChange({required _iyrv7gay.FlatChangeKind kind}) =
      _FlatChangeImpl;

  factory FlatChange.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatChange(
      kind: _iyrv7gay.FlatChangeKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
    );
  }

  _iyrv7gay.FlatChangeKind kind;

  /// Returns a shallow copy of this [FlatChange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FlatChange copyWith({_iyrv7gay.FlatChangeKind? kind});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatChange',
      'kind': kind.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlatChange',
      'kind': kind.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FlatChangeImpl extends FlatChange {
  _FlatChangeImpl({required _iyrv7gay.FlatChangeKind kind})
    : super._(kind: kind);

  /// Returns a shallow copy of this [FlatChange]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FlatChange copyWith({_iyrv7gay.FlatChangeKind? kind}) {
    return FlatChange(kind: kind ?? this.kind);
  }
}
