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
import 'mate_color.dart' as _ieys87jp;

/// A member of a Flat. A Mate with [leftAt] set has left the Flat.
abstract class Mate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Mate._({
    this.id,
    required this.flatId,
    required this.authUserId,
    required this.displayName,
    required this.joinedAt,
    this.leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMissed,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : color = color ?? _ieys87jp.MateColor.tomato,
       notifyTurnStarts = notifyTurnStarts ?? true,
       notifyReminder = notifyReminder ?? true,
       notifyMissed = notifyMissed ?? true,
       notifyNotice = notifyNotice ?? true,
       notifyAddedToRotation = notifyAddedToRotation ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Mate({
    int? id,
    required int flatId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMissed,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _MateImpl;

  factory Mate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mate(
      id: jsonSerialization['id'] as int?,
      flatId: jsonSerialization['flatId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      leftAt: jsonSerialization['leftAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['leftAt']),
      color: jsonSerialization['color'] == null
          ? null
          : _ieys87jp.MateColor.fromJson(
              (jsonSerialization['color'] as String),
            ),
      notifyTurnStarts: jsonSerialization['notifyTurnStarts'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyTurnStarts'],
            ),
      notifyReminder: jsonSerialization['notifyReminder'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyReminder'],
            ),
      notifyMissed: jsonSerialization['notifyMissed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['notifyMissed']),
      notifyNotice: jsonSerialization['notifyNotice'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['notifyNotice']),
      notifyAddedToRotation: jsonSerialization['notifyAddedToRotation'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['notifyAddedToRotation'],
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

  int flatId;

  _isc.UuidValue authUserId;

  String displayName;

  DateTime joinedAt;

  DateTime? leftAt;

  _ieys87jp.MateColor color;

  /// Which push notifications the Mate wants.
  bool notifyTurnStarts;

  bool notifyReminder;

  bool notifyMissed;

  bool notifyNotice;

  bool notifyAddedToRotation;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Mate copyWith({
    int? id,
    int? flatId,
    _isc.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMissed,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id,
      'flatId': flatId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMissed': notifyMissed,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mate',
      if (id != null) 'id': id,
      'flatId': flatId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'joinedAt': joinedAt.toJson(),
      if (leftAt != null) 'leftAt': leftAt?.toJson(),
      'color': color.toJson(),
      'notifyTurnStarts': notifyTurnStarts,
      'notifyReminder': notifyReminder,
      'notifyMissed': notifyMissed,
      'notifyNotice': notifyNotice,
      'notifyAddedToRotation': notifyAddedToRotation,
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

class _MateImpl extends Mate {
  _MateImpl({
    int? id,
    required int flatId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required DateTime joinedAt,
    DateTime? leftAt,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMissed,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         flatId: flatId,
         authUserId: authUserId,
         displayName: displayName,
         joinedAt: joinedAt,
         leftAt: leftAt,
         color: color,
         notifyTurnStarts: notifyTurnStarts,
         notifyReminder: notifyReminder,
         notifyMissed: notifyMissed,
         notifyNotice: notifyNotice,
         notifyAddedToRotation: notifyAddedToRotation,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Mate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Mate copyWith({
    Object? id = _Undefined,
    int? flatId,
    _isc.UuidValue? authUserId,
    String? displayName,
    DateTime? joinedAt,
    Object? leftAt = _Undefined,
    _ieys87jp.MateColor? color,
    bool? notifyTurnStarts,
    bool? notifyReminder,
    bool? notifyMissed,
    bool? notifyNotice,
    bool? notifyAddedToRotation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mate(
      id: id is int? ? id : this.id,
      flatId: flatId ?? this.flatId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      joinedAt: joinedAt ?? this.joinedAt,
      leftAt: leftAt is DateTime? ? leftAt : this.leftAt,
      color: color ?? this.color,
      notifyTurnStarts: notifyTurnStarts ?? this.notifyTurnStarts,
      notifyReminder: notifyReminder ?? this.notifyReminder,
      notifyMissed: notifyMissed ?? this.notifyMissed,
      notifyNotice: notifyNotice ?? this.notifyNotice,
      notifyAddedToRotation:
          notifyAddedToRotation ?? this.notifyAddedToRotation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
