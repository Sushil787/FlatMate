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
import 'away.dart' as _i2;
import 'away_rule.dart' as _i3;
import 'chore.dart' as _i4;
import 'device_token.dart' as _i5;
import 'event.dart' as _i6;
import 'flat.dart' as _i7;
import 'flat_change.dart' as _i8;
import 'flat_change_kind.dart' as _i9;
import 'flatmates_exception.dart' as _i10;
import 'grocery_item.dart' as _i11;
import 'mate.dart' as _i12;
import 'my_flat.dart' as _i13;
import 'notice.dart' as _i14;
import 'swap_debt.dart' as _i15;
import 'turn.dart' as _i16;
import 'turn_status.dart' as _i17;
import 'package:flatmates_client/src/protocol/away.dart' as _i18;
import 'package:flatmates_client/src/protocol/chore.dart' as _i19;
import 'package:flatmates_client/src/protocol/turn.dart' as _i20;
import 'package:flatmates_client/src/protocol/event.dart' as _i21;
import 'package:flatmates_client/src/protocol/grocery_item.dart' as _i22;
import 'package:flatmates_client/src/protocol/notice.dart' as _i23;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i24;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i25;
export 'away.dart';
export 'away_rule.dart';
export 'chore.dart';
export 'device_token.dart';
export 'event.dart';
export 'flat.dart';
export 'flat_change.dart';
export 'flat_change_kind.dart';
export 'flatmates_exception.dart';
export 'grocery_item.dart';
export 'mate.dart';
export 'my_flat.dart';
export 'notice.dart';
export 'swap_debt.dart';
export 'turn.dart';
export 'turn_status.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Away) {
      return _i2.Away.fromJson(data) as T;
    }
    if (t == _i3.AwayRule) {
      return _i3.AwayRule.fromJson(data) as T;
    }
    if (t == _i4.Chore) {
      return _i4.Chore.fromJson(data) as T;
    }
    if (t == _i5.DeviceToken) {
      return _i5.DeviceToken.fromJson(data) as T;
    }
    if (t == _i6.FlatEvent) {
      return _i6.FlatEvent.fromJson(data) as T;
    }
    if (t == _i7.Flat) {
      return _i7.Flat.fromJson(data) as T;
    }
    if (t == _i8.FlatChange) {
      return _i8.FlatChange.fromJson(data) as T;
    }
    if (t == _i9.FlatChangeKind) {
      return _i9.FlatChangeKind.fromJson(data) as T;
    }
    if (t == _i10.FlatmatesException) {
      return _i10.FlatmatesException.fromJson(data) as T;
    }
    if (t == _i11.GroceryItem) {
      return _i11.GroceryItem.fromJson(data) as T;
    }
    if (t == _i12.Mate) {
      return _i12.Mate.fromJson(data) as T;
    }
    if (t == _i13.MyFlat) {
      return _i13.MyFlat.fromJson(data) as T;
    }
    if (t == _i14.Notice) {
      return _i14.Notice.fromJson(data) as T;
    }
    if (t == _i15.SwapDebt) {
      return _i15.SwapDebt.fromJson(data) as T;
    }
    if (t == _i16.Turn) {
      return _i16.Turn.fromJson(data) as T;
    }
    if (t == _i17.TurnStatus) {
      return _i17.TurnStatus.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Away?>()) {
      return (data != null ? _i2.Away.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AwayRule?>()) {
      return (data != null ? _i3.AwayRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Chore?>()) {
      return (data != null ? _i4.Chore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.DeviceToken?>()) {
      return (data != null ? _i5.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.FlatEvent?>()) {
      return (data != null ? _i6.FlatEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Flat?>()) {
      return (data != null ? _i7.Flat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FlatChange?>()) {
      return (data != null ? _i8.FlatChange.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.FlatChangeKind?>()) {
      return (data != null ? _i9.FlatChangeKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.FlatmatesException?>()) {
      return (data != null ? _i10.FlatmatesException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.GroceryItem?>()) {
      return (data != null ? _i11.GroceryItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Mate?>()) {
      return (data != null ? _i12.Mate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.MyFlat?>()) {
      return (data != null ? _i13.MyFlat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Notice?>()) {
      return (data != null ? _i14.Notice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SwapDebt?>()) {
      return (data != null ? _i15.SwapDebt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Turn?>()) {
      return (data != null ? _i16.Turn.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.TurnStatus?>()) {
      return (data != null ? _i17.TurnStatus.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i12.Mate>) {
      return (data as List).map((e) => deserialize<_i12.Mate>(e)).toList() as T;
    }
    if (t == List<_i18.Away>) {
      return (data as List).map((e) => deserialize<_i18.Away>(e)).toList() as T;
    }
    if (t == List<_i19.Chore>) {
      return (data as List).map((e) => deserialize<_i19.Chore>(e)).toList()
          as T;
    }
    if (t == List<_i20.Turn>) {
      return (data as List).map((e) => deserialize<_i20.Turn>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i21.FlatEvent>) {
      return (data as List).map((e) => deserialize<_i21.FlatEvent>(e)).toList()
          as T;
    }
    if (t == List<_i22.GroceryItem>) {
      return (data as List)
              .map((e) => deserialize<_i22.GroceryItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.Notice>) {
      return (data as List).map((e) => deserialize<_i23.Notice>(e)).toList()
          as T;
    }
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i25.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Away => 'Away',
      _i3.AwayRule => 'AwayRule',
      _i4.Chore => 'Chore',
      _i5.DeviceToken => 'DeviceToken',
      _i6.FlatEvent => 'FlatEvent',
      _i7.Flat => 'Flat',
      _i8.FlatChange => 'FlatChange',
      _i9.FlatChangeKind => 'FlatChangeKind',
      _i10.FlatmatesException => 'FlatmatesException',
      _i11.GroceryItem => 'GroceryItem',
      _i12.Mate => 'Mate',
      _i13.MyFlat => 'MyFlat',
      _i14.Notice => 'Notice',
      _i15.SwapDebt => 'SwapDebt',
      _i16.Turn => 'Turn',
      _i17.TurnStatus => 'TurnStatus',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('flatmates.', '');
    }

    switch (data) {
      case _i2.Away():
        return 'Away';
      case _i3.AwayRule():
        return 'AwayRule';
      case _i4.Chore():
        return 'Chore';
      case _i5.DeviceToken():
        return 'DeviceToken';
      case _i6.FlatEvent():
        return 'FlatEvent';
      case _i7.Flat():
        return 'Flat';
      case _i8.FlatChange():
        return 'FlatChange';
      case _i9.FlatChangeKind():
        return 'FlatChangeKind';
      case _i10.FlatmatesException():
        return 'FlatmatesException';
      case _i11.GroceryItem():
        return 'GroceryItem';
      case _i12.Mate():
        return 'Mate';
      case _i13.MyFlat():
        return 'MyFlat';
      case _i14.Notice():
        return 'Notice';
      case _i15.SwapDebt():
        return 'SwapDebt';
      case _i16.Turn():
        return 'Turn';
      case _i17.TurnStatus():
        return 'TurnStatus';
    }
    className = _i24.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i25.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Away') {
      return deserialize<_i2.Away>(data['data']);
    }
    if (dataClassName == 'AwayRule') {
      return deserialize<_i3.AwayRule>(data['data']);
    }
    if (dataClassName == 'Chore') {
      return deserialize<_i4.Chore>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_i5.DeviceToken>(data['data']);
    }
    if (dataClassName == 'FlatEvent') {
      return deserialize<_i6.FlatEvent>(data['data']);
    }
    if (dataClassName == 'Flat') {
      return deserialize<_i7.Flat>(data['data']);
    }
    if (dataClassName == 'FlatChange') {
      return deserialize<_i8.FlatChange>(data['data']);
    }
    if (dataClassName == 'FlatChangeKind') {
      return deserialize<_i9.FlatChangeKind>(data['data']);
    }
    if (dataClassName == 'FlatmatesException') {
      return deserialize<_i10.FlatmatesException>(data['data']);
    }
    if (dataClassName == 'GroceryItem') {
      return deserialize<_i11.GroceryItem>(data['data']);
    }
    if (dataClassName == 'Mate') {
      return deserialize<_i12.Mate>(data['data']);
    }
    if (dataClassName == 'MyFlat') {
      return deserialize<_i13.MyFlat>(data['data']);
    }
    if (dataClassName == 'Notice') {
      return deserialize<_i14.Notice>(data['data']);
    }
    if (dataClassName == 'SwapDebt') {
      return deserialize<_i15.SwapDebt>(data['data']);
    }
    if (dataClassName == 'Turn') {
      return deserialize<_i16.Turn>(data['data']);
    }
    if (dataClassName == 'TurnStatus') {
      return deserialize<_i17.TurnStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i24.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i25.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i24.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i25.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
