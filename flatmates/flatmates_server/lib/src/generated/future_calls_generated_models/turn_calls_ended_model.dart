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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class TurnCallsEndedModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TurnCallsEndedModel._({required this.turnId});

  factory TurnCallsEndedModel({required int turnId}) = _TurnCallsEndedModelImpl;

  factory TurnCallsEndedModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return TurnCallsEndedModel(turnId: jsonSerialization['turnId'] as int);
  }

  int turnId;

  /// Returns a shallow copy of this [TurnCallsEndedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TurnCallsEndedModel copyWith({int? turnId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TurnCallsEndedModel',
      'turnId': turnId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TurnCallsEndedModelImpl extends TurnCallsEndedModel {
  _TurnCallsEndedModelImpl({required int turnId}) : super._(turnId: turnId);

  /// Returns a shallow copy of this [TurnCallsEndedModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TurnCallsEndedModel copyWith({int? turnId}) {
    return TurnCallsEndedModel(turnId: turnId ?? this.turnId);
  }
}
