import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.gr.dart';
import '../../../app/session.dart';
import '../../../core/services/push_service.dart';
import '../application/flat_sync.dart';

/// The five tabs of a Flat. Keeps data live while mounted.
@RoutePage()
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  @override
  void initState() {
    super.initState();
    ref.read(pushServiceProvider).register();
  }

  @override
  Widget build(BuildContext context) {
    // The tabs read the Flat unconditionally. When the user leaves it (or
    // signs out) this shell lingers for a frame until navigation moves on.
    if (ref.watch(sessionStatusProvider) != SessionStatus.ready) {
      return const Scaffold();
    }
    ref.watch(flatSyncProvider);
    return AutoTabsRouter(
      routes: const [
        ChoresRoute(),
        CalendarRoute(),
        BoardRoute(),
        GroceriesRoute(),
        FlatRoute(),
      ],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabs = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabs.activeIndex,
            onDestinationSelected: tabs.setActiveIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.cleaning_services_outlined),
                selectedIcon: Icon(Icons.cleaning_services_rounded),
                label: 'Chores',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month_rounded),
                label: 'Calendar',
              ),
              NavigationDestination(
                icon: Icon(Icons.sticky_note_2_outlined),
                selectedIcon: Icon(Icons.sticky_note_2_rounded),
                label: 'Board',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_basket_outlined),
                selectedIcon: Icon(Icons.shopping_basket_rounded),
                label: 'Groceries',
              ),
              NavigationDestination(
                icon: Icon(Icons.cottage_outlined),
                selectedIcon: Icon(Icons.cottage_rounded),
                label: 'Flat',
              ),
            ],
          ),
        );
      },
    );
  }
}
