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
import 'away_rule.dart' as _isc380kv;

/// The shared home; the boundary for everything else.
abstract class Flat
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Flat._({
    this.id,
    required this.name,
    required this.timezone,
    this.adminMateId,
    required this.inviteCode,
    required this.awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Flat({
    int? id,
    required String name,
    required String timezone,
    int? adminMateId,
    required String inviteCode,
    required _isc380kv.AwayRule awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FlatImpl;

  factory Flat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Flat(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      timezone: jsonSerialization['timezone'] as String,
      adminMateId: jsonSerialization['adminMateId'] as int?,
      inviteCode: jsonSerialization['inviteCode'] as String,
      awayRule: _isc380kv.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
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
  int? id;

  String name;

  /// IANA name, e.g. Asia/Kathmandu: when the Flat's days start and end.
  String timezone;

  int? adminMateId;

  String inviteCode;

  _isc380kv.AwayRule awayRule;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Flat copyWith({
    int? id,
    String? name,
    String? timezone,
    int? adminMateId,
    String? inviteCode,
    _isc380kv.AwayRule? awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId,
      'inviteCode': inviteCode,
      'awayRule': awayRule.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id,
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId,
      'inviteCode': inviteCode,
      'awayRule': awayRule.toJson(),
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

class _FlatImpl extends Flat {
  _FlatImpl({
    int? id,
    required String name,
    required String timezone,
    int? adminMateId,
    required String inviteCode,
    required _isc380kv.AwayRule awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         timezone: timezone,
         adminMateId: adminMateId,
         inviteCode: inviteCode,
         awayRule: awayRule,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Flat copyWith({
    Object? id = _Undefined,
    String? name,
    String? timezone,
    Object? adminMateId = _Undefined,
    String? inviteCode,
    _isc380kv.AwayRule? awayRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Flat(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      adminMateId: adminMateId is int? ? adminMateId : this.adminMateId,
      inviteCode: inviteCode ?? this.inviteCode,
      awayRule: awayRule ?? this.awayRule,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
