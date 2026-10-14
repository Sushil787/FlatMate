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

abstract class TurnCallsMatesNotDoneModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TurnCallsMatesNotDoneModel._({required this.turnId});

  factory TurnCallsMatesNotDoneModel({required _is.UuidValue turnId}) =
      _TurnCallsMatesNotDoneModelImpl;

  factory TurnCallsMatesNotDoneModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TurnCallsMatesNotDoneModel(
      turnId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['turnId']),
    );
  }

  _is.UuidValue turnId;

  /// Returns a shallow copy of this [TurnCallsMatesNotDoneModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TurnCallsMatesNotDoneModel copyWith({_is.UuidValue? turnId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TurnCallsMatesNotDoneModel',
      'turnId': turnId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TurnCallsMatesNotDoneModelImpl extends TurnCallsMatesNotDoneModel {
  _TurnCallsMatesNotDoneModelImpl({required _is.UuidValue turnId})
    : super._(turnId: turnId);

  /// Returns a shallow copy of this [TurnCallsMatesNotDoneModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TurnCallsMatesNotDoneModel copyWith({_is.UuidValue? turnId}) {
    return TurnCallsMatesNotDoneModel(turnId: turnId ?? this.turnId);
  }
}
