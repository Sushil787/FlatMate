import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.gr.dart';
import '../../../app/session.dart';
import '../../../core/providers/theme_mode_provider.dart';
import '../../../core/services/push_service.dart';
import '../../../core/utils/day.dart';
import '../../../core/widgets/fridge/calendar_magnet.dart';
import '../../../core/widgets/fridge/chores_magnet.dart';
import '../../../core/widgets/fridge/flat_magnet.dart';
import '../../../core/widgets/fridge/fridge_door.dart';
import '../../../core/widgets/fridge/grocery_magnet.dart';
import '../../../core/widgets/fridge/kitchen.dart';
import '../../../core/widgets/fridge/magnet_screen.dart';
import '../../../core/widgets/fridge/notice_magnet.dart';
import '../../calendar/application/calendar_providers.dart';
import '../../calendar/domain/calendar_entry.dart';
import '../../chores/application/chores_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../../board/application/notices_controller.dart';
import '../../groceries/application/groceries_controller.dart';
import '../application/flat_sync.dart';

/// The Flat's fridge: a magnet per section, each opening into its screen.
/// Keeps the Flat's data live while mounted.
@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(pushServiceProvider).register();
  }

  @override
  Widget build(BuildContext context) {
    // The magnets read the Flat unconditionally. When the user leaves it (or
    // signs out) this screen lingers for a frame until navigation moves on.
    if (ref.watch(sessionStatusProvider) != SessionStatus.ready) {
      return const Scaffold();
    }
    ref.watch(flatSyncProvider);
    final directory = ref.watch(mateDirectoryProvider);
    final me = directory.me.id!;
    final now = DateTime.now();
    ({int id, String name}) mate(int id) =>
        (id: id, name: directory.realNameOf(id));
    void open(PageRouteInfo route) => context.router.push(route);

    final myTurn = ref
        .watch(choresControllerProvider)
        .value
        ?.openTurnsOf(me)
        .firstOrNull;
    final notices = ref.watch(noticesControllerProvider).value ?? const [];
    final topNotice =
        notices.where((n) => n.pinned).firstOrNull ?? notices.firstOrNull;
    final groceries = ref.watch(groceriesControllerProvider).value ?? const [];
    final calendar =
        ref.watch(calendarMonthProvider(DateTime(now.year, now.month))).value ??
        const [];

    return Scaffold(
      body: Kitchen(
        lightOn: Theme.of(context).brightness == Brightness.dark,
        onLightTap: () => ref
            .read(themeModeControllerProvider.notifier)
            .toggle(Theme.of(context).brightness),
        child: FridgeHome(
          notices: NoticeMagnet(
            text: topNotice?.text,
            author: topNotice == null
                ? null
                : directory.nameOf(topNotice.mateId),
            pinned: topNotice?.pinned ?? false,
            tilt: -3,
            heroTag: FridgeSection.notices,
            onTap: () => open(const BoardRoute()),
          ),
          chores: ChoresMagnet(
            choreName: myTurn?.$1.name,
            dueAt: myTurn?.$2.endsAt,
            rotation: [...?myTurn?.$1.rotation.map(mate)],
            tilt: 2,
            heroTag: FridgeSection.chores,
            onTap: () => open(const ChoresRoute()),
          ),
          calendar: CalendarMagnet(
            today: now,
            marks: _weekMarks(calendar, today: now, me: me),
            tilt: -1,
            heroTag: FridgeSection.calendar,
            onTap: () => open(const CalendarRoute()),
          ),
          flat: FlatMagnet(
            flatName: directory.flat.name,
            mates: [for (final m in directory.mates) mate(m.id!)],
            tilt: 4,
            heroTag: FridgeSection.flat,
            onTap: () => open(const FlatRoute()),
          ),
          groceries: GroceryMagnet(
            items: [
              for (final g in groceries)
                if (g.boughtAt == null) (name: g.name, note: g.note),
            ],
            tilt: -1.5,
            heroTag: FridgeSection.groceries,
            onTap: () => open(const GroceriesRoute()),
          ),
        ),
      ),
    );
  }

  /// The dots under each day of this week: Events, Mates away, and the
  /// signed-in Mate's own Turns.
  static Map<DateTime, Set<CalendarMark>> _weekMarks(
    List<CalendarEntry> entries, {
    required DateTime today,
    required int me,
  }) {
    final monday = CalendarMagnet.mondayOf(today);
    return {
      for (var i = 0; i < 7; i++)
        DateUtils.addDaysToDate(monday, i): {
          for (final e in entries)
            if (e.isOn(DateUtils.addDaysToDate(monday, i)))
              ?switch (e) {
                EventEntry() => CalendarMark.event,
                AwayEntry() => CalendarMark.away,
                TurnEntry(:final turn) when turn.mateId == me =>
                  CalendarMark.turn,
                TurnEntry() => null,
              },
        },
    };
  }
}
