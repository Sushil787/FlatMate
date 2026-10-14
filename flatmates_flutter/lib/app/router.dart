import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.gr.dart';
import 'session.dart';

/// The app's routes. Top-level screens follow [SessionStatus] (see
/// `FlatmatesApp`); [_StatusGuard] keeps the Flat's screens unreachable
/// until the user is in one.
@AutoRouterConfig(replaceInRouteName: 'Screen|Shell,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._ref);

  final WidgetRef _ref;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes {
    final ready = [_StatusGuard(_ref, SessionStatus.ready)];
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: SignInRoute.page),
      AutoRoute(page: OnboardingRoute.page),
      AutoRoute(
        page: SetupRoute.page,
        guards: [_StatusGuard(_ref, SessionStatus.setup)],
      ),
      // The five tabs of the bottom nav.
      AutoRoute(
        page: TabsRoute.page,
        guards: ready,
        children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: ChoresRoute.page),
          AutoRoute(page: CalendarRoute.page),
          AutoRoute(page: GroceriesRoute.page),
          AutoRoute(page: FlatRoute.page),
        ],
      ),
      // Detail screens: no bottom nav.
      AutoRoute(page: ChoreDetailRoute.page, guards: ready),
      AutoRoute(page: BoardRoute.page, guards: ready),
      AutoRoute(page: SettingsRoute.page, guards: ready),
    ];
  }
}

/// Lets a route open only at [status].
class _StatusGuard extends AutoRouteGuard {
  _StatusGuard(this._ref, this.status);

  final WidgetRef _ref;
  final SessionStatus status;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_ref.read(sessionStatusProvider) == status) {
      resolver.next();
    } else {
      resolver.redirectUntil(const SplashRoute());
    }
  }
}
