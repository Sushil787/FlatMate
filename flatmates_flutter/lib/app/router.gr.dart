// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flatmates_client/flatmates_client.dart' as _i17;
import 'package:flatmates_flutter/app/splash_screen.dart' as _i13;
import 'package:flatmates_flutter/app/tabs_shell.dart' as _i14;
import 'package:flatmates_flutter/features/auth/presentation/sign_in_screen.dart'
    as _i12;
import 'package:flatmates_flutter/features/board/presentation/board_screen.dart'
    as _i1;
import 'package:flatmates_flutter/features/calendar/presentation/calendar_screen.dart'
    as _i2;
import 'package:flatmates_flutter/features/chores/presentation/chore_detail_screen.dart'
    as _i3;
import 'package:flatmates_flutter/features/chores/presentation/chores_screen.dart'
    as _i4;
import 'package:flatmates_flutter/features/flat/presentation/flat_screen.dart'
    as _i5;
import 'package:flatmates_flutter/features/flat/presentation/onboarding_screen.dart'
    as _i9;
import 'package:flatmates_flutter/features/groceries/presentation/groceries_screen.dart'
    as _i6;
import 'package:flatmates_flutter/features/home/presentation/home_screen.dart'
    as _i7;
import 'package:flatmates_flutter/features/onboarding/presentation/notifications_ask_screen.dart'
    as _i8;
import 'package:flatmates_flutter/features/onboarding/presentation/setup_screen.dart'
    as _i11;
import 'package:flatmates_flutter/features/settings/presentation/settings_screen.dart'
    as _i10;
import 'package:flutter/material.dart' as _i16;

/// generated route for
/// [_i1.BoardScreen]
class BoardRoute extends _i15.PageRouteInfo<void> {
  const BoardRoute({List<_i15.PageRouteInfo>? children})
    : super(BoardRoute.name, initialChildren: children);

  static const String name = 'BoardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.BoardScreen();
    },
  );
}

/// generated route for
/// [_i2.CalendarScreen]
class CalendarRoute extends _i15.PageRouteInfo<void> {
  const CalendarRoute({List<_i15.PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.CalendarScreen();
    },
  );
}

/// generated route for
/// [_i3.ChoreDetailScreen]
class ChoreDetailRoute extends _i15.PageRouteInfo<ChoreDetailRouteArgs> {
  ChoreDetailRoute({
    _i16.Key? key,
    required _i17.UuidValue choreId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ChoreDetailRoute.name,
         args: ChoreDetailRouteArgs(key: key, choreId: choreId),
         initialChildren: children,
       );

  static const String name = 'ChoreDetailRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChoreDetailRouteArgs>();
      return _i3.ChoreDetailScreen(key: args.key, choreId: args.choreId);
    },
  );
}

class ChoreDetailRouteArgs {
  const ChoreDetailRouteArgs({this.key, required this.choreId});

  final _i16.Key? key;

  final _i17.UuidValue choreId;

  @override
  String toString() {
    return 'ChoreDetailRouteArgs{key: $key, choreId: $choreId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChoreDetailRouteArgs) return false;
    return key == other.key && choreId == other.choreId;
  }

  @override
  int get hashCode => key.hashCode ^ choreId.hashCode;
}

/// generated route for
/// [_i4.ChoresScreen]
class ChoresRoute extends _i15.PageRouteInfo<void> {
  const ChoresRoute({List<_i15.PageRouteInfo>? children})
    : super(ChoresRoute.name, initialChildren: children);

  static const String name = 'ChoresRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.ChoresScreen();
    },
  );
}

/// generated route for
/// [_i5.FlatScreen]
class FlatRoute extends _i15.PageRouteInfo<void> {
  const FlatRoute({List<_i15.PageRouteInfo>? children})
    : super(FlatRoute.name, initialChildren: children);

  static const String name = 'FlatRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.FlatScreen();
    },
  );
}

/// generated route for
/// [_i6.GroceriesScreen]
class GroceriesRoute extends _i15.PageRouteInfo<void> {
  const GroceriesRoute({List<_i15.PageRouteInfo>? children})
    : super(GroceriesRoute.name, initialChildren: children);

  static const String name = 'GroceriesRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.GroceriesScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.NotificationsAskScreen]
class NotificationsAskRoute extends _i15.PageRouteInfo<void> {
  const NotificationsAskRoute({List<_i15.PageRouteInfo>? children})
    : super(NotificationsAskRoute.name, initialChildren: children);

  static const String name = 'NotificationsAskRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.NotificationsAskScreen();
    },
  );
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i15.PageRouteInfo<void> {
  const OnboardingRoute({List<_i15.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i10.SettingsScreen]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i11.SetupScreen]
class SetupRoute extends _i15.PageRouteInfo<void> {
  const SetupRoute({List<_i15.PageRouteInfo>? children})
    : super(SetupRoute.name, initialChildren: children);

  static const String name = 'SetupRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SetupScreen();
    },
  );
}

/// generated route for
/// [_i12.SignInScreen]
class SignInRoute extends _i15.PageRouteInfo<void> {
  const SignInRoute({List<_i15.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignInScreen();
    },
  );
}

/// generated route for
/// [_i13.SplashScreen]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashScreen();
    },
  );
}

/// generated route for
/// [_i14.TabsShell]
class TabsRoute extends _i15.PageRouteInfo<void> {
  const TabsRoute({List<_i15.PageRouteInfo>? children})
    : super(TabsRoute.name, initialChildren: children);

  static const String name = 'TabsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.TabsShell();
    },
  );
}
