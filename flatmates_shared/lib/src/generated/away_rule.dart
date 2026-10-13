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

/// What happens to an Away Mate's Turns. One rule per Flat, set by the Admin.
enum AwayRule implements _iss.SerializableModel {
  swap,
  skip,
  pause;

  static AwayRule fromJson(String name) {
    switch (name) {
      case 'swap':
        return AwayRule.swap;
      case 'skip':
        return AwayRule.skip;
      case 'pause':
        return AwayRule.pause;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "AwayRule"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
