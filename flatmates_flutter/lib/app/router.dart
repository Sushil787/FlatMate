import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.gr.dart';
import 'session.dart';

/// The app's routes. Top-level screens follow [SessionStatus] (see
/// `FlatmatesApp`); [_ReadyGuard] keeps the Flat's screens unreachable
/// until the user is in one.
@AutoRouterConfig(replaceInRouteName: 'Screen|Shell,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._ref);

  final WidgetRef _ref;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes {
    final ready = [_ReadyGuard(_ref)];
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: SignInRoute.page),
      AutoRoute(page: OnboardingRoute.page),
      AutoRoute(page: HomeRoute.page, guards: ready),
      // Each section opens from its note on the fridge; the note's Heroine
      // flight is the whole transition. The fridge stays painted while the
      // route animates, so that runs as long as the flight's spring.
      for (final page in [
        ChoresRoute.page,
        CalendarRoute.page,
        BoardRoute.page,
        GroceriesRoute.page,
        FlatRoute.page,
      ])
        CustomRoute<void>(
          page: page,
          guards: ready,
          transitionsBuilder: TransitionsBuilders.noTransition,
          duration: const Duration(milliseconds: 600),
          reverseDuration: const Duration(milliseconds: 600),
        ),
      AutoRoute(page: ChoreEditorRoute.page, guards: ready),
    ];
  }
}

class _ReadyGuard extends AutoRouteGuard {
  _ReadyGuard(this._ref);

  final WidgetRef _ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_ref.read(sessionStatusProvider) == SessionStatus.ready) {
      resolver.next();
    } else {
      resolver.redirectUntil(const SplashRoute());
    }
  }
}
