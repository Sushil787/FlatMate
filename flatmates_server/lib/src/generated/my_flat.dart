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
import 'package:flatmates_server/src/generated/protocol.dart' as _ikjds9rx;
import 'package:serverpod/serverpod.dart' as _is;
import 'flat.dart' as _io7qq7p8;
import 'mate.dart' as _itahn62i;

/// The signed-in user's Flat, their own Mate record and everyone in it.
abstract class MyFlat
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MyFlat._({
    required this.flat,
    required this.me,
    required this.mates,
  });

  factory MyFlat({
    required _io7qq7p8.Flat flat,
    required _itahn62i.Mate me,
    required List<_itahn62i.Mate> mates,
  }) = _MyFlatImpl;

  factory MyFlat.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyFlat(
      flat: _ikjds9rx.Protocol().deserialize<_io7qq7p8.Flat>(
        jsonSerialization['flat'],
      ),
      me: _ikjds9rx.Protocol().deserialize<_itahn62i.Mate>(
        jsonSerialization['me'],
      ),
      mates: _ikjds9rx.Protocol().deserialize<List<_itahn62i.Mate>>(
        jsonSerialization['mates'],
      ),
    );
  }

  _io7qq7p8.Flat flat;

  _itahn62i.Mate me;

  List<_itahn62i.Mate> mates;

  /// Returns a shallow copy of this [MyFlat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MyFlat copyWith({
    _io7qq7p8.Flat? flat,
    _itahn62i.Mate? me,
    List<_itahn62i.Mate>? mates,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyFlat',
      'flat': flat.toJson(),
      'me': me.toJson(),
      'mates': mates.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyFlat',
      'flat': flat.toJsonForProtocol(),
      'me': me.toJsonForProtocol(),
      'mates': mates.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MyFlatImpl extends MyFlat {
  _MyFlatImpl({
    required _io7qq7p8.Flat flat,
    required _itahn62i.Mate me,
    required List<_itahn62i.Mate> mates,
  }) : super._(
         flat: flat,
         me: me,
         mates: mates,
       );

  /// Returns a shallow copy of this [MyFlat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MyFlat copyWith({
    _io7qq7p8.Flat? flat,
    _itahn62i.Mate? me,
    List<_itahn62i.Mate>? mates,
  }) {
    return MyFlat(
      flat: flat ?? this.flat.copyWith(),
      me: me ?? this.me.copyWith(),
      mates: mates ?? this.mates.map((e0) => e0.copyWith()).toList(),
    );
  }
}
