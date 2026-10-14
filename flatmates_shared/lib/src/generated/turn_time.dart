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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _iss;

/// The part of the day a Chore's Turns are meant to be done in. Its
/// notifications follow it (see turn_time.dart for the times).
enum TurnTime implements _iss.SerializableModel {
  morning,
  afternoon,
  evening,
  night;

  static TurnTime fromJson(String name) {
    switch (name) {
      case 'morning':
        return TurnTime.morning;
      case 'afternoon':
        return TurnTime.afternoon;
      case 'evening':
        return TurnTime.evening;
      case 'night':
        return TurnTime.night;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "TurnTime"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
