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

abstract class TurnCallsReminderModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TurnCallsReminderModel._({required this.turnId});

  factory TurnCallsReminderModel({required int turnId}) =
      _TurnCallsReminderModelImpl;

  factory TurnCallsReminderModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TurnCallsReminderModel(turnId: jsonSerialization['turnId'] as int);
  }

  int turnId;

  /// Returns a shallow copy of this [TurnCallsReminderModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TurnCallsReminderModel copyWith({int? turnId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TurnCallsReminderModel',
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

class _TurnCallsReminderModelImpl extends TurnCallsReminderModel {
  _TurnCallsReminderModelImpl({required int turnId}) : super._(turnId: turnId);

  /// Returns a shallow copy of this [TurnCallsReminderModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TurnCallsReminderModel copyWith({int? turnId}) {
    return TurnCallsReminderModel(turnId: turnId ?? this.turnId);
  }
}
