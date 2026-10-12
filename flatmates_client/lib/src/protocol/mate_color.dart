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

/// A Mate's colour, used for their avatar and Turns. Unique among active Mates.
enum MateColor implements _isc.SerializableModel {
  tomato,
  sky,
  plum,
  leaf,
  marigold,
  berry;

  static MateColor fromJson(String name) {
    switch (name) {
      case 'tomato':
        return MateColor.tomato;
      case 'sky':
        return MateColor.sky;
      case 'plum':
        return MateColor.plum;
      case 'leaf':
        return MateColor.leaf;
      case 'marigold':
        return MateColor.marigold;
      case 'berry':
        return MateColor.berry;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "MateColor"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
