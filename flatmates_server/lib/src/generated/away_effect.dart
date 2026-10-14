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
import 'package:flatmates_shared/flatmates_shared.dart' as _ij0lpv6z;
import 'package:serverpod/serverpod.dart' as _is;

/// What a planned Away would do to one of the Mate's Turns (Away preview).
/// The app works it out; no endpoint sends it.
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
    required _is.UuidValue choreId,
    required DateTime day,
    required _ij0lpv6z.AwayRule awayRule,
    _is.UuidValue? coverMateId,
    DateTime? newDay,
    DateTime? newLastDay,
  }) = _AwayEffectImpl;

  factory AwayEffect.fromJson(Map<String, dynamic> jsonSerialization) {
    return AwayEffect(
      choreId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['choreId'],
      ),
      day: _is.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      awayRule: _ij0lpv6z.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
      ),
      coverMateId: jsonSerialization['coverMateId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['coverMateId'],
            ),
      newDay: jsonSerialization['newDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['newDay']),
      newLastDay: jsonSerialization['newLastDay'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['newLastDay']),
    );
  }

  _is.UuidValue choreId;

  /// The Turn's day as planned now.
  DateTime day;

  _ij0lpv6z.AwayRule awayRule;

  /// Swap/Skip: the Mate who takes the Turn.
  _is.UuidValue? coverMateId;

  /// Pause, or nobody free to cover: the Turn's new days.
  DateTime? newDay;

  DateTime? newLastDay;

  /// Returns a shallow copy of this [AwayEffect]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AwayEffect copyWith({
    _is.UuidValue? choreId,
    DateTime? day,
    _ij0lpv6z.AwayRule? awayRule,
    _is.UuidValue? coverMateId,
    DateTime? newDay,
    DateTime? newLastDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AwayEffect',
      'choreId': choreId.toJson(),
      'day': day.toJson(),
      'awayRule': awayRule.toJson(),
      if (coverMateId != null) 'coverMateId': coverMateId?.toJson(),
      if (newDay != null) 'newDay': newDay?.toJson(),
      if (newLastDay != null) 'newLastDay': newLastDay?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AwayEffect',
      'choreId': choreId.toJson(),
      'day': day.toJson(),
      'awayRule': awayRule.toJson(),
      if (coverMateId != null) 'coverMateId': coverMateId?.toJson(),
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
    required _is.UuidValue choreId,
    required DateTime day,
    required _ij0lpv6z.AwayRule awayRule,
    _is.UuidValue? coverMateId,
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
    _is.UuidValue? choreId,
    DateTime? day,
    _ij0lpv6z.AwayRule? awayRule,
    Object? coverMateId = _Undefined,
    Object? newDay = _Undefined,
    Object? newLastDay = _Undefined,
  }) {
    return AwayEffect(
      choreId: choreId ?? this.choreId,
      day: day ?? this.day,
      awayRule: awayRule ?? this.awayRule,
      coverMateId: coverMateId is _is.UuidValue?
          ? coverMateId
          : this.coverMateId,
      newDay: newDay is DateTime? ? newDay : this.newDay,
      newLastDay: newLastDay is DateTime? ? newLastDay : this.newLastDay,
    );
  }
}
