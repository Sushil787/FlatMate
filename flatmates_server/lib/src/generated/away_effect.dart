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
import 'away_rule.dart' as _isc380kv;

/// What a planned Away would do to one of the Mate's Turns (Away preview).
abstract class AwayEffect
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AwayEffect._({
    required this.choreId,
    required this.day,
    required this.awayRule,
    this.coverMateId,
    this.newDay,
    this.newLastDay,
  });

  factory AwayEffect({
    required int choreId,
    required DateTime day,
    required _isc380kv.AwayRule awayRule,
    int? coverMateId,
    DateTime? newDay,
    DateTime? newLastDay,
  }) = _AwayEffectImpl;

  factory AwayEffect.fromJson(Map<String, dynamic> jsonSerialization) {
    return AwayEffect(
      choreId: jsonSerialization['choreId'] as int,
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      awayRule: _isc380kv.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
      ),
      coverMateId: jsonSerialization['coverMateId'] as int?,
      newDay: jsonSerialization['newDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['newDay']),
      newLastDay: jsonSerialization['newLastDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['newLastDay']),
    );
  }

  int choreId;

  /// The Turn's day as planned now.
  DateTime day;

  _isc380kv.AwayRule awayRule;

  /// Swap/Skip: the Mate who takes the Turn.
  int? coverMateId;

  /// Pause, or nobody free to cover: the Turn's new days.
  DateTime? newDay;

  DateTime? newLastDay;

  /// Returns a shallow copy of this [AwayEffect]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AwayEffect copyWith({
    int? choreId,
    DateTime? day,
    _isc380kv.AwayRule? awayRule,
    int? coverMateId,
    DateTime? newDay,
    DateTime? newLastDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AwayEffect',
      'choreId': choreId,
      'day': day.toJson(),
      'awayRule': awayRule.toJson(),
      if (coverMateId != null) 'coverMateId': coverMateId,
      if (newDay != null) 'newDay': newDay?.toJson(),
      if (newLastDay != null) 'newLastDay': newLastDay?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AwayEffect',
      'choreId': choreId,
      'day': day.toJson(),
      'awayRule': awayRule.toJson(),
      if (coverMateId != null) 'coverMateId': coverMateId,
      if (newDay != null) 'newDay': newDay?.toJson(),
      if (newLastDay != null) 'newLastDay': newLastDay?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AwayEffectImpl extends AwayEffect {
  _AwayEffectImpl({
    required int choreId,
    required DateTime day,
    required _isc380kv.AwayRule awayRule,
    int? coverMateId,
    DateTime? newDay,
    DateTime? newLastDay,
  }) : super._(
         choreId: choreId,
         day: day,
         awayRule: awayRule,
         coverMateId: coverMateId,
         newDay: newDay,
         newLastDay: newLastDay,
       );

  /// Returns a shallow copy of this [AwayEffect]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AwayEffect copyWith({
    int? choreId,
    DateTime? day,
    _isc380kv.AwayRule? awayRule,
    Object? coverMateId = _Undefined,
    Object? newDay = _Undefined,
    Object? newLastDay = _Undefined,
  }) {
    return AwayEffect(
      choreId: choreId ?? this.choreId,
      day: day ?? this.day,
      awayRule: awayRule ?? this.awayRule,
      coverMateId: coverMateId is int? ? coverMateId : this.coverMateId,
      newDay: newDay is DateTime? ? newDay : this.newDay,
      newLastDay: newLastDay is DateTime? ? newLastDay : this.newLastDay,
    );
  }
}
