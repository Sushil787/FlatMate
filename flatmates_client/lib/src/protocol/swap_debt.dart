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

/// A Turn owed back under the Swap rule: [debtorMateId] takes [creditorMateId]'s next Turn.
abstract class SwapDebt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SwapDebt._({
    this.id,
    required this.choreId,
    required this.debtorMateId,
    required this.creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SwapDebt({
    _isc.UuidValue? id,
    required _isc.UuidValue choreId,
    required _isc.UuidValue debtorMateId,
    required _isc.UuidValue creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SwapDebtImpl;

  factory SwapDebt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapDebt(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      choreId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['choreId'],
      ),
      debtorMateId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['debtorMateId'],
      ),
      creditorMateId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['creditorMateId'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _isc.UuidValue? id;

  _isc.UuidValue choreId;

  _isc.UuidValue debtorMateId;

  _isc.UuidValue creditorMateId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SwapDebt copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? choreId,
    _isc.UuidValue? debtorMateId,
    _isc.UuidValue? creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id?.toJson(),
      'choreId': choreId.toJson(),
      'debtorMateId': debtorMateId.toJson(),
      'creditorMateId': creditorMateId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id?.toJson(),
      'choreId': choreId.toJson(),
      'debtorMateId': debtorMateId.toJson(),
      'creditorMateId': creditorMateId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapDebtImpl extends SwapDebt {
  _SwapDebtImpl({
    _isc.UuidValue? id,
    required _isc.UuidValue choreId,
    required _isc.UuidValue debtorMateId,
    required _isc.UuidValue creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         choreId: choreId,
         debtorMateId: debtorMateId,
         creditorMateId: creditorMateId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SwapDebt copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? choreId,
    _isc.UuidValue? debtorMateId,
    _isc.UuidValue? creditorMateId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SwapDebt(
      id: id is _isc.UuidValue? ? id : this.id,
      choreId: choreId ?? this.choreId,
      debtorMateId: debtorMateId ?? this.debtorMateId,
      creditorMateId: creditorMateId ?? this.creditorMateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
