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

abstract class TurnCallsNightSummaryModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TurnCallsNightSummaryModel._({required this.turnId});

  factory TurnCallsNightSummaryModel({required _is.UuidValue turnId}) =
      _TurnCallsNightSummaryModelImpl;

  factory TurnCallsNightSummaryModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TurnCallsNightSummaryModel(
      turnId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['turnId']),
    );
  }

  _is.UuidValue turnId;

  /// Returns a shallow copy of this [TurnCallsNightSummaryModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TurnCallsNightSummaryModel copyWith({_is.UuidValue? turnId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TurnCallsNightSummaryModel',
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

class _TurnCallsNightSummaryModelImpl extends TurnCallsNightSummaryModel {
  _TurnCallsNightSummaryModelImpl({required _is.UuidValue turnId})
    : super._(turnId: turnId);

  /// Returns a shallow copy of this [TurnCallsNightSummaryModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TurnCallsNightSummaryModel copyWith({_is.UuidValue? turnId}) {
    return TurnCallsNightSummaryModel(turnId: turnId ?? this.turnId);
  }
}
