// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flatmates_flutter/app/splash_screen.dart' as _i10;
import 'package:flatmates_flutter/features/auth/presentation/sign_in_screen.dart'
    as _i9;
import 'package:flatmates_flutter/features/board/presentation/board_screen.dart'
    as _i1;
import 'package:flatmates_flutter/features/calendar/presentation/calendar_screen.dart'
    as _i2;
import 'package:flatmates_flutter/features/chores/presentation/chore_editor_screen.dart'
    as _i3;
import 'package:flatmates_flutter/features/chores/presentation/chores_screen.dart'
    as _i4;
import 'package:flatmates_flutter/features/flat/presentation/flat_screen.dart'
    as _i5;
import 'package:flatmates_flutter/features/flat/presentation/onboarding_screen.dart'
    as _i8;
import 'package:flatmates_flutter/features/groceries/presentation/groceries_screen.dart'
    as _i6;
import 'package:flatmates_flutter/features/home/presentation/home_screen.dart'
    as _i7;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.BoardScreen]
class BoardRoute extends _i11.PageRouteInfo<void> {
  const BoardRoute({List<_i11.PageRouteInfo>? children})
    : super(BoardRoute.name, initialChildren: children);

  static const String name = 'BoardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i1.BoardScreen());
    },
  );
}

/// generated route for
/// [_i2.CalendarScreen]
class CalendarRoute extends _i11.PageRouteInfo<void> {
  const CalendarRoute({List<_i11.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i2.CalendarScreen());
    },
  );
}

/// generated route for
/// [_i3.ChoreEditorScreen]
class ChoreEditorRoute extends _i11.PageRouteInfo<ChoreEditorRouteArgs> {
  ChoreEditorRoute({
    _i12.Key? key,
    int? choreId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ChoreEditorRoute.name,
         args: ChoreEditorRouteArgs(key: key, choreId: choreId),
         initialChildren: children,
       );

  static const String name = 'ChoreEditorRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChoreEditorRouteArgs>(
        orElse: () => const ChoreEditorRouteArgs(),
      );
      return _i3.ChoreEditorScreen(key: args.key, choreId: args.choreId);
    },
  );
}

class ChoreEditorRouteArgs {
  const ChoreEditorRouteArgs({this.key, this.choreId});

  final _i12.Key? key;

  final int? choreId;

  @override
  String toString() {
    return 'ChoreEditorRouteArgs{key: $key, choreId: $choreId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChoreEditorRouteArgs) return false;
    return key == other.key && choreId == other.choreId;
  }

  @override
  int get hashCode => key.hashCode ^ choreId.hashCode;
}

/// generated route for
/// [_i4.ChoresScreen]
class ChoresRoute extends _i11.PageRouteInfo<void> {
  const ChoresRoute({List<_i11.PageRouteInfo>? children})
    : super(ChoresRoute.name, initialChildren: children);

  static const String name = 'ChoresRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i4.ChoresScreen());
    },
  );
}

/// generated route for
/// [_i5.FlatScreen]
class FlatRoute extends _i11.PageRouteInfo<void> {
  const FlatRoute({List<_i11.PageRouteInfo>? children})
    : super(FlatRoute.name, initialChildren: children);

  static const String name = 'FlatRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i5.FlatScreen());
    },
  );
}

/// generated route for
/// [_i6.GroceriesScreen]
class GroceriesRoute extends _i11.PageRouteInfo<void> {
  const GroceriesRoute({List<_i11.PageRouteInfo>? children})
    : super(GroceriesRoute.name, initialChildren: children);

  static const String name = 'GroceriesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i6.GroceriesScreen());
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.OnboardingScreen]
class OnboardingRoute extends _i11.PageRouteInfo<void> {
  const OnboardingRoute({List<_i11.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i9.SignInScreen]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute({List<_i11.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignInScreen();
    },
  );
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashScreen();
    },
  );
}
