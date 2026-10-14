import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/theme_mode_provider.dart';
import '../core/services/push_service.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';
import 'router.gr.dart';
import 'session.dart';

class FlatmatesApp extends ConsumerStatefulWidget {
  const FlatmatesApp({super.key});

  @override
  ConsumerState<FlatmatesApp> createState() => _FlatmatesAppState();
}

class _FlatmatesAppState extends ConsumerState<FlatmatesApp> {
  late final _router = AppRouter(ref);

  /// Set by a sign-in, so Home opens with the notifications soft ask if
  /// the phone needs it. Onboarding asks itself, so it clears this.
  bool _justSignedIn = false;

  @override
  void initState() {
    super.initState();
    // Swap the whole stack whenever the session moves to a new stage:
    // signed out → sign-in, no Flat → welcome, just in one → setup,
    // in a Flat → home.
    ref.listenManual<SessionStatus>(sessionStatusProvider, (previous, next) {
      if (previous == next) return;
      WidgetsBinding.instance.addPostFrameCallback((_) => _show(next));
    }, fireImmediately: true);
  }

  Future<void> _show(SessionStatus status) async {
    if (status == SessionStatus.signedOut) _justSignedIn = true;
    if (status == SessionStatus.setup) _justSignedIn = false;
    await _router.replaceAll([_routeFor(status)]);
    if (status != SessionStatus.ready || !_justSignedIn) return;
    _justSignedIn = false;
    if (await ref.read(pushAllowedProvider.future)) return;
    if (ref.read(sessionStatusProvider) == SessionStatus.ready) {
      await _router.push(const NotificationsAskRoute());
    }
  }

  static PageRouteInfo _routeFor(SessionStatus status) => switch (status) {
    SessionStatus.loading => const SplashRoute(),
    SessionStatus.signedOut => const SignInRoute(),
    SessionStatus.noFlat => const OnboardingRoute(),
    SessionStatus.setup => const SetupRoute(),
    SessionStatus.ready => const TabsRoute(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flatmates',
      debugShowCheckedModeBanner: false,
      theme: FlatmatesTheme.light(),
      darkTheme: FlatmatesTheme.dark(),
      themeMode: ref.watch(themeModeControllerProvider),
      // Start on the session's screen: the router's own first navigation can
      // land after [_show]'s first replaceAll and would leave Splash on top.
      routerConfig: _router.config(
        deepLinkBuilder: (_) =>
            DeepLink([_routeFor(ref.read(sessionStatusProvider))]),
      ),
      // Follow the phone's text size, up to 200%.
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(maxScaleFactor: 2),
          ),
          child: child!,
        );
      },
    );
  }
}
