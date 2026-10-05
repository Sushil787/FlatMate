import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroine/heroine.dart';

import '../core/providers/theme_mode_provider.dart';
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

  @override
  void initState() {
    super.initState();
    // Swap the whole stack whenever the session moves to a new stage:
    // signed out → sign-in, no Flat → welcome, in a Flat → home.
    ref.listenManual<SessionStatus>(sessionStatusProvider, (previous, next) {
      if (previous == next) return;
      WidgetsBinding.instance.addPostFrameCallback((_) => _show(next));
    }, fireImmediately: true);
  }

  void _show(SessionStatus status) {
    final PageRouteInfo route = switch (status) {
      SessionStatus.loading => const SplashRoute(),
      SessionStatus.signedOut => const SignInRoute(),
      SessionStatus.noFlat => const OnboardingRoute(),
      SessionStatus.ready => const HomeRoute(),
    };
    _router.replaceAll([route]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flatmates',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeModeControllerProvider),
      routerConfig: _router.config(
        navigatorObservers: () => [HeroineController()],
      ),
      // Respect the phone's text size, but only up to 1.1x: bigger breaks
      // the layouts.
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(maxScaleFactor: 1.1),
          ),
          child: child!,
        );
      },
    );
  }
}
