/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flatmates_client/src/protocol/away.dart' as _irs4lusq;
import 'package:flatmates_client/src/protocol/away_effect.dart' as _ivmd14y1;
import 'package:flatmates_client/src/protocol/chore.dart' as _ipou5iyr;
import 'package:flatmates_client/src/protocol/event.dart' as _igj22k42;
import 'package:flatmates_client/src/protocol/grocery_item.dart' as _iy9ydfy6;
import 'package:flatmates_client/src/protocol/notice.dart' as _iynhw2wx;
import 'package:flatmates_client/src/protocol/swap_debt.dart' as _icdhy1dj;
import 'package:flatmates_client/src/protocol/turn.dart' as _i4k8bhoi;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'away.dart' as _injc6hlm;
import 'away_effect.dart' as _i3z62lxk;
import 'away_rule.dart' as _isc380kv;
import 'chore.dart' as _imnq0nzy;
import 'device_token.dart' as _ilggw95u;
import 'event.dart' as _iu57571s;
import 'flat.dart' as _io7qq7p8;
import 'flat_change.dart' as _izxtvxcg;
import 'flat_change_kind.dart' as _iyrv7gay;
import 'flatmates_exception.dart' as _id68d40p;
import 'grocery_item.dart' as _idc9is2h;
import 'mate.dart' as _itahn62i;
import 'mate_color.dart' as _ieys87jp;
import 'my_flat.dart' as _i9fqeegk;
import 'notice.dart' as _i8bpb14y;
import 'notice_got_it.dart' as _ia5ed1vr;
import 'swap_debt.dart' as _ijdri2o7;
import 'turn.dart' as _i0nsa51h;
import 'turn_status.dart' as _i5yk6qf9;
export 'away.dart';
export 'away_effect.dart';
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
export 'mate_color.dart';
export 'my_flat.dart';
export 'notice.dart';
export 'notice_got_it.dart';
export 'swap_debt.dart';
export 'turn.dart';
export 'turn_status.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _injc6hlm.Away) {
      return _injc6hlm.Away.fromJson(data) as T;
    }
    if (t == _i3z62lxk.AwayEffect) {
      return _i3z62lxk.AwayEffect.fromJson(data) as T;
    }
    if (t == _isc380kv.AwayRule) {
      return _isc380kv.AwayRule.fromJson(data) as T;
    }
    if (t == _imnq0nzy.Chore) {
      return _imnq0nzy.Chore.fromJson(data) as T;
    }
    if (t == _ilggw95u.DeviceToken) {
      return _ilggw95u.DeviceToken.fromJson(data) as T;
    }
    if (t == _iu57571s.FlatEvent) {
      return _iu57571s.FlatEvent.fromJson(data) as T;
    }
    if (t == _io7qq7p8.Flat) {
      return _io7qq7p8.Flat.fromJson(data) as T;
    }
    if (t == _izxtvxcg.FlatChange) {
      return _izxtvxcg.FlatChange.fromJson(data) as T;
    }
    if (t == _iyrv7gay.FlatChangeKind) {
      return _iyrv7gay.FlatChangeKind.fromJson(data) as T;
    }
    if (t == _id68d40p.FlatmatesException) {
      return _id68d40p.FlatmatesException.fromJson(data) as T;
    }
    if (t == _idc9is2h.GroceryItem) {
      return _idc9is2h.GroceryItem.fromJson(data) as T;
    }
    if (t == _itahn62i.Mate) {
      return _itahn62i.Mate.fromJson(data) as T;
    }
    if (t == _ieys87jp.MateColor) {
      return _ieys87jp.MateColor.fromJson(data) as T;
    }
    if (t == _i9fqeegk.MyFlat) {
      return _i9fqeegk.MyFlat.fromJson(data) as T;
    }
    if (t == _i8bpb14y.Notice) {
      return _i8bpb14y.Notice.fromJson(data) as T;
    }
    if (t == _ia5ed1vr.NoticeGotIt) {
      return _ia5ed1vr.NoticeGotIt.fromJson(data) as T;
    }
    if (t == _ijdri2o7.SwapDebt) {
      return _ijdri2o7.SwapDebt.fromJson(data) as T;
    }
    if (t == _i0nsa51h.Turn) {
      return _i0nsa51h.Turn.fromJson(data) as T;
    }
    if (t == _i5yk6qf9.TurnStatus) {
      return _i5yk6qf9.TurnStatus.fromJson(data) as T;
    }
    if (t == _isc.getType<_injc6hlm.Away?>()) {
      return (data != null ? _injc6hlm.Away.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3z62lxk.AwayEffect?>()) {
      return (data != null ? _i3z62lxk.AwayEffect.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isc380kv.AwayRule?>()) {
      return (data != null ? _isc380kv.AwayRule.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imnq0nzy.Chore?>()) {
      return (data != null ? _imnq0nzy.Chore.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilggw95u.DeviceToken?>()) {
      return (data != null ? _ilggw95u.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu57571s.FlatEvent?>()) {
      return (data != null ? _iu57571s.FlatEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_io7qq7p8.Flat?>()) {
      return (data != null ? _io7qq7p8.Flat.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izxtvxcg.FlatChange?>()) {
      return (data != null ? _izxtvxcg.FlatChange.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyrv7gay.FlatChangeKind?>()) {
      return (data != null ? _iyrv7gay.FlatChangeKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_id68d40p.FlatmatesException?>()) {
      return (data != null ? _id68d40p.FlatmatesException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idc9is2h.GroceryItem?>()) {
      return (data != null ? _idc9is2h.GroceryItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itahn62i.Mate?>()) {
      return (data != null ? _itahn62i.Mate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieys87jp.MateColor?>()) {
      return (data != null ? _ieys87jp.MateColor.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i9fqeegk.MyFlat?>()) {
      return (data != null ? _i9fqeegk.MyFlat.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8bpb14y.Notice?>()) {
      return (data != null ? _i8bpb14y.Notice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia5ed1vr.NoticeGotIt?>()) {
      return (data != null ? _ia5ed1vr.NoticeGotIt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijdri2o7.SwapDebt?>()) {
      return (data != null ? _ijdri2o7.SwapDebt.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0nsa51h.Turn?>()) {
      return (data != null ? _i0nsa51h.Turn.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5yk6qf9.TurnStatus?>()) {
      return (data != null ? _i5yk6qf9.TurnStatus.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_itahn62i.Mate>) {
      return (data as List).map((e) => deserialize<_itahn62i.Mate>(e)).toList()
          as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_irs4lusq.Away>) {
      return (data as List).map((e) => deserialize<_irs4lusq.Away>(e)).toList()
          as T;
    }
    if (t == List<_ivmd14y1.AwayEffect>) {
      return (data as List)
              .map((e) => deserialize<_ivmd14y1.AwayEffect>(e))
              .toList()
          as T;
    }
    if (t == List<_ipou5iyr.Chore>) {
      return (data as List).map((e) => deserialize<_ipou5iyr.Chore>(e)).toList()
          as T;
    }
    if (t == List<_i4k8bhoi.Turn>) {
      return (data as List).map((e) => deserialize<_i4k8bhoi.Turn>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_icdhy1dj.SwapDebt>) {
      return (data as List)
              .map((e) => deserialize<_icdhy1dj.SwapDebt>(e))
              .toList()
          as T;
    }
    if (t == List<_igj22k42.FlatEvent>) {
      return (data as List)
              .map((e) => deserialize<_igj22k42.FlatEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_iy9ydfy6.GroceryItem>) {
      return (data as List)
              .map((e) => deserialize<_iy9ydfy6.GroceryItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iynhw2wx.Notice>) {
      return (data as List)
              .map((e) => deserialize<_iynhw2wx.Notice>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _injc6hlm.Away => 'Away',
      _i3z62lxk.AwayEffect => 'AwayEffect',
      _isc380kv.AwayRule => 'AwayRule',
      _imnq0nzy.Chore => 'Chore',
      _ilggw95u.DeviceToken => 'DeviceToken',
      _iu57571s.FlatEvent => 'FlatEvent',
      _io7qq7p8.Flat => 'Flat',
      _izxtvxcg.FlatChange => 'FlatChange',
      _iyrv7gay.FlatChangeKind => 'FlatChangeKind',
      _id68d40p.FlatmatesException => 'FlatmatesException',
      _idc9is2h.GroceryItem => 'GroceryItem',
      _itahn62i.Mate => 'Mate',
      _ieys87jp.MateColor => 'MateColor',
      _i9fqeegk.MyFlat => 'MyFlat',
      _i8bpb14y.Notice => 'Notice',
      _ia5ed1vr.NoticeGotIt => 'NoticeGotIt',
      _ijdri2o7.SwapDebt => 'SwapDebt',
      _i0nsa51h.Turn => 'Turn',
      _i5yk6qf9.TurnStatus => 'TurnStatus',
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
      case _injc6hlm.Away():
        return 'Away';
      case _i3z62lxk.AwayEffect():
        return 'AwayEffect';
      case _isc380kv.AwayRule():
        return 'AwayRule';
      case _imnq0nzy.Chore():
        return 'Chore';
      case _ilggw95u.DeviceToken():
        return 'DeviceToken';
      case _iu57571s.FlatEvent():
        return 'FlatEvent';
      case _io7qq7p8.Flat():
        return 'Flat';
      case _izxtvxcg.FlatChange():
        return 'FlatChange';
      case _iyrv7gay.FlatChangeKind():
        return 'FlatChangeKind';
      case _id68d40p.FlatmatesException():
        return 'FlatmatesException';
      case _idc9is2h.GroceryItem():
        return 'GroceryItem';
      case _itahn62i.Mate():
        return 'Mate';
      case _ieys87jp.MateColor():
        return 'MateColor';
      case _i9fqeegk.MyFlat():
        return 'MyFlat';
      case _i8bpb14y.Notice():
        return 'Notice';
      case _ia5ed1vr.NoticeGotIt():
        return 'NoticeGotIt';
      case _ijdri2o7.SwapDebt():
        return 'SwapDebt';
      case _i0nsa51h.Turn():
        return 'Turn';
      case _i5yk6qf9.TurnStatus():
        return 'TurnStatus';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
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
      return deserialize<_injc6hlm.Away>(data['data']);
    }
    if (dataClassName == 'AwayEffect') {
      return deserialize<_i3z62lxk.AwayEffect>(data['data']);
    }
    if (dataClassName == 'AwayRule') {
      return deserialize<_isc380kv.AwayRule>(data['data']);
    }
    if (dataClassName == 'Chore') {
      return deserialize<_imnq0nzy.Chore>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_ilggw95u.DeviceToken>(data['data']);
    }
    if (dataClassName == 'FlatEvent') {
      return deserialize<_iu57571s.FlatEvent>(data['data']);
    }
    if (dataClassName == 'Flat') {
      return deserialize<_io7qq7p8.Flat>(data['data']);
    }
    if (dataClassName == 'FlatChange') {
      return deserialize<_izxtvxcg.FlatChange>(data['data']);
    }
    if (dataClassName == 'FlatChangeKind') {
      return deserialize<_iyrv7gay.FlatChangeKind>(data['data']);
    }
    if (dataClassName == 'FlatmatesException') {
      return deserialize<_id68d40p.FlatmatesException>(data['data']);
    }
    if (dataClassName == 'GroceryItem') {
      return deserialize<_idc9is2h.GroceryItem>(data['data']);
    }
    if (dataClassName == 'Mate') {
      return deserialize<_itahn62i.Mate>(data['data']);
    }
    if (dataClassName == 'MateColor') {
      return deserialize<_ieys87jp.MateColor>(data['data']);
    }
    if (dataClassName == 'MyFlat') {
      return deserialize<_i9fqeegk.MyFlat>(data['data']);
    }
    if (dataClassName == 'Notice') {
      return deserialize<_i8bpb14y.Notice>(data['data']);
    }
    if (dataClassName == 'NoticeGotIt') {
      return deserialize<_ia5ed1vr.NoticeGotIt>(data['data']);
    }
    if (dataClassName == 'SwapDebt') {
      return deserialize<_ijdri2o7.SwapDebt>(data['data']);
    }
    if (dataClassName == 'Turn') {
      return deserialize<_i0nsa51h.Turn>(data['data']);
    }
    if (dataClassName == 'TurnStatus') {
      return deserialize<_i5yk6qf9.TurnStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('flatmates', this);
    _iacc.Protocol().registerHostProtocol('flatmates', this);
  }

  @override
  String getModuleName() => 'flatmates';

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
