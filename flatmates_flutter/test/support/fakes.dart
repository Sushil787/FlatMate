import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/core/services/push_service.dart';
import 'package:flatmates_flutter/features/auth/application/auth_controller.dart';
import 'package:flatmates_flutter/features/away/data/away_repository.dart';
import 'package:flatmates_flutter/features/board/data/notice_repository.dart';
import 'package:flatmates_flutter/features/calendar/data/event_repository.dart';
import 'package:flatmates_flutter/features/chores/data/chore_repository.dart';
import 'package:flatmates_flutter/features/flat/data/flat_repository.dart';
import 'package:flatmates_flutter/features/groceries/data/grocery_repository.dart';
import 'package:flutter_riverpod/misc.dart';

/// An in-memory Flat with Priya (admin, the signed-in user), Sam and Alex.
class FakeBackend {
  FakeBackend({bool inFlat = true}) {
    if (inFlat) myFlat = _flat();
  }

  MyFlat? myFlat;
  final chores = <Chore>[];
  final turns = <Turn>[];
  final notices = <Notice>[];
  final groceries = <GroceryItem>[];
  final events = <FlatEvent>[];
  final aways = <Away>[];
  final doneTurnIds = <int>[];
  final _changes = StreamController<FlatChange>.broadcast();

  static const priya = 1, sam = 2, alex = 3;

  MyFlat _flat({String name = 'Priya'}) {
    final flat = Flat(
      id: 10,
      name: 'Elm St',
      timezone: 'UTC',
      adminMateId: priya,
      inviteCode: 'ABC234',
      awayRule: AwayRule.swap,
      createdAt: DateTime.now(),
    );
    Mate mate(int id, String n) => Mate(
      id: id,
      flatId: 10,
      authUserId: UuidValue.fromString(
        '00000000-0000-4000-8000-00000000000$id',
      ),
      displayName: n,
      joinedAt: DateTime.now(),
    );
    final me = mate(priya, name);
    return MyFlat(
      flat: flat,
      me: me,
      mates: [me, mate(sam, 'Sam'), mate(alex, 'Alex')],
    );
  }

  /// Adds a weekly Chore whose current Turn belongs to [mateId].
  void addChore(String name, {required int mateId, int id = 1}) {
    final now = DateTime.now().toUtc();
    chores.add(
      Chore(
        id: id,
        flatId: 10,
        name: name,
        period: const Duration(days: 7),
        startsAt: now,
        rotation: [priya, sam, alex],
        rotationIndex: 0,
        archived: false,
      ),
    );
    turns.add(
      Turn(
        id: id * 100,
        flatId: 10,
        choreId: id,
        mateId: mateId,
        startsAt: now.subtract(const Duration(days: 1)),
        endsAt: now.add(const Duration(days: 6)),
        status: TurnStatus.active,
      ),
    );
  }

  List<Override> overrides() => [
    authControllerProvider.overrideWith(_SignedIn.new),
    pushServiceProvider.overrideWithValue(_NoPush()),
    flatRepositoryProvider.overrideWithValue(_FlatRepo(this)),
    choreRepositoryProvider.overrideWithValue(_ChoreRepo(this)),
    awayRepositoryProvider.overrideWithValue(_AwayRepo(this)),
    eventRepositoryProvider.overrideWithValue(_EventRepo(this)),
    noticeRepositoryProvider.overrideWithValue(_NoticeRepo(this)),
    groceryRepositoryProvider.overrideWithValue(_GroceryRepo(this)),
  ];
}

class _SignedIn extends AuthController {
  @override
  bool build() => true;
}

class _NoPush implements PushService {
  @override
  Future<void> register() async {}
}

class _FlatRepo implements FlatRepository {
  _FlatRepo(this.b);
  final FakeBackend b;

  @override
  Future<MyFlat?> mine() async => b.myFlat;
  @override
  Future<MyFlat> create({required String flatName, required String myName}) async =>
      b.myFlat = b._flat(name: myName);
  @override
  Future<MyFlat> join({required String inviteCode, required String myName}) async {
    if (inviteCode.trim().toUpperCase() != 'ABC234') {
      throw FlatmatesException(message: 'That invite code doesn\'t match any flat.');
    }
    return b.myFlat = b._flat(name: myName);
  }

  @override
  Future<String> regenerateInvite() async => 'NEW234';
  @override
  Future<Flat> setAwayRule(AwayRule rule) async =>
      b.myFlat!.flat..awayRule = rule;
  @override
  Future<void> transferAdmin(int mateId) async {}
  @override
  Future<void> removeMate(int mateId) async {}
  @override
  Future<void> leave() async => b.myFlat = null;
  @override
  Stream<FlatChange> changes() => b._changes.stream;
}

class _ChoreRepo implements ChoreRepository {
  _ChoreRepo(this.b);
  final FakeBackend b;

  @override
  Future<List<Chore>> list() async => [...b.chores];
  @override
  Future<List<Turn>> activeTurns() async =>
      b.turns.where((t) => t.status == TurnStatus.active || t.status == TurnStatus.done).toList();
  @override
  Future<List<Turn>> turnsBetween(DateTime from, DateTime to) async => [...b.turns];
  @override
  Future<Chore> create({
    required String name,
    required Duration period,
    required DateTime startsAt,
    required List<int> rotation,
  }) async {
    b.addChore(name, mateId: rotation.first, id: b.chores.length + 1);
    return b.chores.last;
  }

  @override
  Future<Chore> update({
    required int choreId,
    required String name,
    required Duration period,
    required List<int> rotation,
  }) async => b.chores.firstWhere((c) => c.id == choreId)..name = name;
  @override
  Future<void> archive(int choreId) async =>
      b.chores.removeWhere((c) => c.id == choreId);
  @override
  Future<Turn> markDone(int turnId) async {
    b.doneTurnIds.add(turnId);
    final turn = b.turns.firstWhere((t) => t.id == turnId);
    turn.status = TurnStatus.done;
    return turn;
  }
}

class _AwayRepo implements AwayRepository {
  _AwayRepo(this.b);
  final FakeBackend b;

  @override
  Future<List<Away>> list() async => [...b.aways];
  @override
  Future<Away> create(DateTime startsAt, DateTime endsAt) async {
    final away = Away(
      id: b.aways.length + 1,
      flatId: 10,
      mateId: FakeBackend.priya,
      startsAt: startsAt,
      endsAt: endsAt,
    );
    b.aways.add(away);
    return away;
  }

  @override
  Future<void> cancel(int awayId) async =>
      b.aways.removeWhere((a) => a.id == awayId);
}

class _EventRepo implements EventRepository {
  _EventRepo(this.b);
  final FakeBackend b;

  @override
  Future<List<FlatEvent>> between(DateTime from, DateTime to) async =>
      [...b.events];
  @override
  Future<FlatEvent> create({
    required String title,
    String? note,
    required DateTime startsAt,
  }) async {
    final e = FlatEvent(
      id: b.events.length + 1,
      flatId: 10,
      mateId: FakeBackend.priya,
      title: title,
      note: note,
      startsAt: startsAt,
    );
    b.events.add(e);
    return e;
  }

  @override
  Future<void> delete(int eventId) async =>
      b.events.removeWhere((e) => e.id == eventId);
}

class _NoticeRepo implements NoticeRepository {
  _NoticeRepo(this.b);
  final FakeBackend b;

  @override
  Future<List<Notice>> list() async => [...b.notices.reversed];
  @override
  Future<Notice> post(String text) async {
    final n = Notice(
      id: b.notices.length + 1,
      flatId: 10,
      mateId: FakeBackend.priya,
      text: text.trim(),
      pinned: false,
      createdAt: DateTime.now(),
    );
    b.notices.add(n);
    return n;
  }

  @override
  Future<void> setPinned(int noticeId, bool pinned) async =>
      b.notices.firstWhere((n) => n.id == noticeId).pinned = pinned;
  @override
  Future<void> delete(int noticeId) async =>
      b.notices.removeWhere((n) => n.id == noticeId);
}

class _GroceryRepo implements GroceryRepository {
  _GroceryRepo(this.b);
  final FakeBackend b;

  @override
  Future<List<GroceryItem>> list() async => [...b.groceries];
  @override
  Future<GroceryItem> add(String name, String? note) async {
    final g = GroceryItem(
      id: b.groceries.length + 1,
      flatId: 10,
      name: name,
      note: note,
      addedByMateId: FakeBackend.priya,
      createdAt: DateTime.now(),
    );
    b.groceries.add(g);
    return g;
  }

  @override
  Future<GroceryItem> setBought(int itemId, bool bought) async {
    final g = b.groceries.firstWhere((g) => g.id == itemId);
    g
      ..boughtAt = bought ? DateTime.now() : null
      ..boughtByMateId = bought ? FakeBackend.priya : null;
    return g;
  }

  @override
  Future<void> delete(int itemId) async =>
      b.groceries.removeWhere((g) => g.id == itemId);
}
