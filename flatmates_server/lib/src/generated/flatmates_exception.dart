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

/// A rule the request broke, with a message fit to show the user.
abstract class FlatmatesException
    implements
        _is.SerializableException,
        _is.SerializableModel,
        _is.ProtocolSerialization {
  FlatmatesException._({required this.message});

  factory FlatmatesException({required String message}) =
      _FlatmatesExceptionImpl;

  factory FlatmatesException.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlatmatesException(message: jsonSerialization['message'] as String);
  }

  String message;

  /// Returns a shallow copy of this [FlatmatesException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FlatmatesException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlatmatesException',
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlatmatesException',
      'message': message,
    };
  }

  @override
  String toString() {
    return 'FlatmatesException(message: $message)';
  }
}

class _FlatmatesExceptionImpl extends FlatmatesException {
  _FlatmatesExceptionImpl({required String message})
    : super._(message: message);

  /// Returns a shallow copy of this [FlatmatesException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FlatmatesException copyWith({String? message}) {
    return FlatmatesException(message: message ?? this.message);
  }
}
