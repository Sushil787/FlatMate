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

abstract class TurnCallsStartedModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TurnCallsStartedModel._({required this.turnId});

  factory TurnCallsStartedModel({required int turnId}) =
      _TurnCallsStartedModelImpl;

  factory TurnCallsStartedModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TurnCallsStartedModel(turnId: jsonSerialization['turnId'] as int);
  }

  int turnId;

  /// Returns a shallow copy of this [TurnCallsStartedModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TurnCallsStartedModel copyWith({int? turnId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TurnCallsStartedModel',
      'turnId': turnId,
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

class _TurnCallsStartedModelImpl extends TurnCallsStartedModel {
  _TurnCallsStartedModelImpl({required int turnId}) : super._(turnId: turnId);

  /// Returns a shallow copy of this [TurnCallsStartedModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TurnCallsStartedModel copyWith({int? turnId}) {
    return TurnCallsStartedModel(turnId: turnId ?? this.turnId);
  }
}
