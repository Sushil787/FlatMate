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
    required this.inviteExpiresAt,
    required this.awayRule,
    int? morningSummaryAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : morningSummaryAt = morningSummaryAt ?? 480,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Flat({
    _isc.UuidValue? id,
    required String name,
    required String timezone,
    _isc.UuidValue? adminMateId,
    required String inviteCode,
    required DateTime inviteExpiresAt,
    required _isc380kv.AwayRule awayRule,
    int? morningSummaryAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FlatImpl;

  factory Flat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Flat(
      id: jsonSerialization['id'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      timezone: jsonSerialization['timezone'] as String,
      adminMateId: jsonSerialization['adminMateId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['adminMateId'],
            ),
      inviteCode: jsonSerialization['inviteCode'] as String,
      inviteExpiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['inviteExpiresAt'],
      ),
      awayRule: _isc380kv.AwayRule.fromJson(
        (jsonSerialization['awayRule'] as String),
      ),
      morningSummaryAt: jsonSerialization['morningSummaryAt'] as int?,
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

  String name;

  /// IANA name, e.g. Asia/Kathmandu: when the Flat's days start and end.
  String timezone;

  _isc.UuidValue? adminMateId;

  String inviteCode;

  /// When [inviteCode] stops working; 7 days after it was made.
  DateTime inviteExpiresAt;

  _isc380kv.AwayRule awayRule;

  /// When each Mate gets the push about their Turns starting that day, in
  /// minutes after local midnight; the Admin sets it.
  int morningSummaryAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Flat]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Flat copyWith({
    _isc.UuidValue? id,
    String? name,
    String? timezone,
    _isc.UuidValue? adminMateId,
    String? inviteCode,
    DateTime? inviteExpiresAt,
    _isc380kv.AwayRule? awayRule,
    int? morningSummaryAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId?.toJson(),
      'inviteCode': inviteCode,
      'inviteExpiresAt': inviteExpiresAt.toJson(),
      'awayRule': awayRule.toJson(),
      'morningSummaryAt': morningSummaryAt,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Flat',
      if (id != null) 'id': id?.toJson(),
      'name': name,
      'timezone': timezone,
      if (adminMateId != null) 'adminMateId': adminMateId?.toJson(),
      'inviteCode': inviteCode,
      'inviteExpiresAt': inviteExpiresAt.toJson(),
      'awayRule': awayRule.toJson(),
      'morningSummaryAt': morningSummaryAt,
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
    _isc.UuidValue? id,
    required String name,
    required String timezone,
    _isc.UuidValue? adminMateId,
    required String inviteCode,
    required DateTime inviteExpiresAt,
    required _isc380kv.AwayRule awayRule,
    int? morningSummaryAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         timezone: timezone,
         adminMateId: adminMateId,
         inviteCode: inviteCode,
         inviteExpiresAt: inviteExpiresAt,
         awayRule: awayRule,
         morningSummaryAt: morningSummaryAt,
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
    DateTime? inviteExpiresAt,
    _isc380kv.AwayRule? awayRule,
    int? morningSummaryAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Flat(
      id: id is _isc.UuidValue? ? id : this.id,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      adminMateId: adminMateId is _isc.UuidValue?
          ? adminMateId
          : this.adminMateId,
      inviteCode: inviteCode ?? this.inviteCode,
      inviteExpiresAt: inviteExpiresAt ?? this.inviteExpiresAt,
      awayRule: awayRule ?? this.awayRule,
      morningSummaryAt: morningSummaryAt ?? this.morningSummaryAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
