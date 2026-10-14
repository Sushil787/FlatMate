import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/push_service.dart';
import '../../../core/theme/app_theme.dart';
import 'notifications_ask.dart';

/// The soft ask on its own, over Home: after a sign-in by a Mate who is
/// past onboarding (which asks itself) on a phone that doesn't show the
/// app's notifications yet. "Not now" or back just closes it.
@RoutePage()
class NotificationsAskScreen extends ConsumerStatefulWidget {
  const NotificationsAskScreen({super.key});

  @override
  ConsumerState<NotificationsAskScreen> createState() =>
      _NotificationsAskScreenState();
}

class _NotificationsAskScreenState
    extends ConsumerState<NotificationsAskScreen> {
  bool _asking = false;

  Future<void> _turnOn() async {
    setState(() => _asking = true);
    await ref.read(pushServiceProvider).ask();
    ref.invalidate(pushAllowedProvider);
    if (mounted) context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Space.screenMargin,
            Space.lg,
            Space.screenMargin,
            Space.lg,
          ),
          child: NotificationsAsk(
            asking: _asking,
            onYes: _turnOn,
            onNo: () => context.router.maybePop(),
          ),
        ),
      ),
    );
  }
}
