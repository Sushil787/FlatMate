import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      themeMode: ThemeMode.system,
      routerConfig: _router.config(),
    );
  }
}
