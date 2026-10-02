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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// A Turn owed back under the Swap rule: [debtorMateId] takes [creditorMateId]'s next Turn.
abstract class SwapDebt implements _i1.SerializableModel {
  SwapDebt._({
    this.id,
    required this.choreId,
    required this.debtorMateId,
    required this.creditorMateId,
    required this.createdAt,
  });

  factory SwapDebt({
    int? id,
    required int choreId,
    required int debtorMateId,
    required int creditorMateId,
    required DateTime createdAt,
  }) = _SwapDebtImpl;

  factory SwapDebt.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapDebt(
      id: jsonSerialization['id'] as int?,
      choreId: jsonSerialization['choreId'] as int,
      debtorMateId: jsonSerialization['debtorMateId'] as int,
      creditorMateId: jsonSerialization['creditorMateId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int choreId;

  int debtorMateId;

  int creditorMateId;

  DateTime createdAt;

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SwapDebt copyWith({
    int? id,
    int? choreId,
    int? debtorMateId,
    int? creditorMateId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapDebt',
      if (id != null) 'id': id,
      'choreId': choreId,
      'debtorMateId': debtorMateId,
      'creditorMateId': creditorMateId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapDebtImpl extends SwapDebt {
  _SwapDebtImpl({
    int? id,
    required int choreId,
    required int debtorMateId,
    required int creditorMateId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         choreId: choreId,
         debtorMateId: debtorMateId,
         creditorMateId: creditorMateId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SwapDebt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SwapDebt copyWith({
    Object? id = _Undefined,
    int? choreId,
    int? debtorMateId,
    int? creditorMateId,
    DateTime? createdAt,
  }) {
    return SwapDebt(
      id: id is int? ? id : this.id,
      choreId: choreId ?? this.choreId,
      debtorMateId: debtorMateId ?? this.debtorMateId,
      creditorMateId: creditorMateId ?? this.creditorMateId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
