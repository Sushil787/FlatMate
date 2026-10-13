import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:motor/motor.dart';

import '../core/services/push_service.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/banners.dart';
import '../features/flat/application/my_flat_controller.dart';
import '../features/flat/presentation/widgets/new_mate_dialog.dart';
import '../features/groceries/application/groceries_controller.dart';
import '../features/home/application/flat_sync.dart';
import 'router.gr.dart';
import 'session.dart';
import '../core/widgets/app_icon.dart';
import '../core/providers/online_provider.dart';
import '../core/providers/read_cache.dart';

/// The five tabs (Home, Chores, Calendar, Groceries, Flat) under a floating
/// nav. Keeps the Flat's data live while mounted.
@RoutePage()
class TabsShell extends ConsumerStatefulWidget {
  const TabsShell({super.key});

  @override
  ConsumerState<TabsShell> createState() => _TabsShellState();
}

class _TabsShellState extends ConsumerState<TabsShell> {
  /// When back was last pressed on Home; a second press soon after exits.
  DateTime? _backAt;

  /// Android back: other tabs go to Home; on Home, press twice to exit.
  Future<bool> _onBack(TabsRouter tabs) async {
    // A detail screen or sheet on top handles its own back.
    if (ModalRoute.of(context)?.isCurrent == false) return false;
    if (tabs.activeIndex != 0) {
      tabs.setActiveIndex(0);
      return true;
    }
    final now = DateTime.now();
    if (_backAt != null && now.difference(_backAt!) < _exitWindow) {
      return false;
    }
    _backAt = now;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: _exitWindow,
        ),
      );
    return true;
  }

  static const _exitWindow = Duration(seconds: 2);

  /// The notification showing in-app, while the app is open.
  RemoteNotification? _incoming;
  Timer? _incomingTimer;
  StreamSubscription<RemoteNotification>? _incomingSub;

  void _showIncoming(RemoteNotification n) {
    _incomingTimer?.cancel();
    setState(() => _incoming = n);
    _incomingTimer = Timer(const Duration(seconds: 5), _hideIncoming);
  }

  void _hideIncoming() {
    _incomingTimer?.cancel();
    if (mounted) setState(() => _incoming = null);
  }

  /// New Mates the Admin was already asked about while the app is open.
  final _askedAbout = <UuidValue>{};
  bool _asking = false;

  /// Admin only: asks about each Mate who joined and hasn't been welcomed,
  /// one at a time.
  Future<void> _askAboutNewMates() async {
    final flat = ref.read(myFlatControllerProvider).value;
    if (_asking || flat == null || flat.flat.adminMateId != flat.me.id) return;
    final mate = flat.mates
        .where((m) => !m.welcomed && !_askedAbout.contains(m.id))
        .firstOrNull;
    if (mate == null) return;
    _asking = true;
    _askedAbout.add(mate.id!);
    await showNewMateDialog(context, mate);
    _asking = false;
    if (mounted) _askAboutNewMates();
  }

  @override
  void initState() {
    super.initState();
    final push = ref.read(pushServiceProvider);
    _incomingSub = push.foreground.listen(_showIncoming);
    push.register();
    ref.listenManual(
      myFlatControllerProvider,
      // After the frame: a dialog can't open mid-build.
      (_, _) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => mounted ? _askAboutNewMates() : null,
      ),
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _incomingSub?.cancel();
    _incomingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The tabs read the Flat unconditionally. When the user leaves it (or
    // signs out) this shell lingers for a frame until navigation moves on.
    if (ref.watch(sessionStatusProvider) != SessionStatus.ready) {
      return const Scaffold();
    }
    ref.watch(flatSyncProvider);
    final online = ref.watch(onlineProvider);
    final showingSaved = ref.watch(readCacheProvider);
    final openGroceries = ref
        .watch(groceriesControllerProvider)
        .value
        ?.where((g) => g.boughtAt == null)
        .length;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ChoresRoute(),
        CalendarRoute(),
        GroceriesRoute(),
        FlatRoute(),
      ],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      duration: Timing.delayed,
      builder: (context, child) {
        final tabs = AutoTabsRouter.of(context);
        return BackButtonListener(
          onBackButtonPressed: () => _onBack(tabs),
          child: Scaffold(
            extendBody: true,
            body: Stack(
              children: [
                Column(
                  children: [
                    if (!online) ReconnectingBanner(showingSaved: showingSaved),
                    Expanded(
                      // The banner already sits in the status bar's space.
                      // Read the padding inside the Scaffold, which
                      // includes the nav.
                      child: Builder(
                        builder: (context) => MediaQuery.removePadding(
                          context: context,
                          removeTop: !online,
                          child: child,
                        ),
                      ),
                    ),
                  ],
                ),
                // Saved data on screen while the server's answer comes in.
                // Drawn over the content, so nothing moves when it goes.
                if (online && showingSaved)
                  Positioned(
                    top: MediaQuery.paddingOf(context).top,
                    left: 0,
                    right: 0,
                    child: const UpdatingBar(),
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedSwitcher(
                    duration: Timing.delayed,
                    transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween(
                        begin: const Offset(0, -1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: _incoming == null
                        ? const SizedBox.shrink()
                        : InAppNotification(
                            key: ObjectKey(_incoming),
                            title: _incoming!.title ?? '',
                            body: _incoming!.body ?? '',
                            onDismiss: _hideIncoming,
                          ),
                  ),
                ),
              ],
            ),
            // The nav has one row to fit five tabs in; let its label grow
            // only so far with the phone's text size.
            bottomNavigationBar: MediaQuery.withClampedTextScaling(
              maxScaleFactor: 1.3,
              child: _FloatingNav(
                index: tabs.activeIndex,
                onTap: tabs.setActiveIndex,
                groceriesBadge: openGroceries,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The floating capsule nav. The lime indicator springs to the tapped tab
/// and pops as it lands; the tabs make room for its label as it goes.
class _FloatingNav extends StatelessWidget {
  const _FloatingNav({
    required this.index,
    required this.onTap,
    this.groceriesBadge,
  });

  final int index;
  final ValueChanged<int> onTap;
  final int? groceriesBadge;

  static const _tabs = [
    (icon: HugeIcons.strokeRoundedHome01, label: 'Home'),
    (icon: HugeIcons.strokeRoundedRefresh, label: 'Chores'),
    (icon: HugeIcons.strokeRoundedCalendar03, label: 'Calendar'),
    (icon: HugeIcons.strokeRoundedShoppingBasket01, label: 'Groceries'),
    (icon: HugeIcons.strokeRoundedUserGroup, label: 'Flat'),
  ];

  static const _iconSize = 22.0, _gap = 8.0, _pad = 18.0, _height = 48.0;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final still = MediaQuery.disableAnimationsOf(context);
    final slide = still ? const Motion.none() : const CupertinoMotion.snappy();
    final pop = still ? const Motion.none() : const CupertinoMotion.bouncy();
    final labelStyle = context.text.labelLarge?.copyWith(
      fontSize: 14,
      color: fm.onPrimaryTint,
    );
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 22),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: fm.surface,
          borderRadius: BorderRadius.circular(Radii.nav),
          border: Border.all(color: fm.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2416181A),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, box) {
            // The active tab fits its icon and label; the rest share what's
            // left. Every tab's width springs with the same motion, so they
            // always add up to the bar's width.
            final label = TextPainter(
              text: TextSpan(text: _tabs[index].label, style: labelStyle),
              textScaler: MediaQuery.textScalerOf(context),
              textDirection: TextDirection.ltr,
              maxLines: 1,
            )..layout();
            final active = (_pad * 2 + _iconSize + _gap + label.width).clamp(
              0.0,
              box.maxWidth * 0.6,
            );
            final idle = (box.maxWidth - active) / (_tabs.length - 1);
            final left = idle * index;

            return SizedBox(
              height: _height,
              child: Stack(
                children: [
                  MotionBuilder<Rect>(
                    value: Rect.fromLTWH(left, 0, active, _height),
                    motion: slide,
                    converter: MotionConverter.rect,
                    builder: (context, rect, child) => Positioned.fromRect(
                      rect: rect,
                      child: child!,
                    ),
                    // A new key per tab replays the pop on every landing.
                    child: SingleMotionBuilder(
                      key: ValueKey(index),
                      value: 1,
                      from: 0.86,
                      motion: pop,
                      builder: (context, scale, child) =>
                          Transform.scale(scale: scale, child: child),
                      child: DecoratedBox(
                        // The Invite card's soft lime, not the loud one.
                        decoration: BoxDecoration(
                          color: fm.primaryTint,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  // Mid-spring the widths can sum a hair over the bar's.
                  OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: double.infinity,
                    child: Row(
                      children: [
                        for (var i = 0; i < _tabs.length; i++)
                          SingleMotionBuilder(
                            value: i == index ? active : idle,
                            motion: slide,
                            builder: (context, width, _) => SingleMotionBuilder(
                              // How far the tab has turned into the active
                              // one: its label and icon colour follow this.
                              value: i == index ? 1 : 0,
                              motion: slide,
                              builder: (context, open, _) => _Tab(
                                icon: _tabs[i].icon,
                                label: _tabs[i].label,
                                labelStyle: labelStyle,
                                width: width,
                                open: open.clamp(0.0, 1.0),
                                selected: i == index,
                                badge: i == 3 && (groceriesBadge ?? 0) > 0
                                    ? groceriesBadge
                                    : null,
                                onTap: () => onTap(i),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.icon,
    required this.label,
    required this.labelStyle,
    required this.width,
    required this.open,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final AppIconData icon;
  final String label;
  final TextStyle? labelStyle;
  final double width;

  /// 0 for an icon-only tab, 1 for the active tab with its label showing.
  final double open;
  final bool selected;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      button: true,
      selected: selected,
      label: badge == null ? label : '$label, $badge to buy',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: selected ? null : onTap,
        child: SizedBox(
          width: width,
          height: _FloatingNav._height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Badge(
                isLabelVisible: badge != null && open < 0.5,
                label: Text('${badge ?? ''}'),
                backgroundColor: fm.ink,
                textColor: fm.ground,
                offset: const Offset(10, -6),
                child: AppIcon(
                  icon,
                  size: _FloatingNav._iconSize,
                  color: Color.lerp(fm.inkSoft, fm.onPrimaryTint, open),
                ),
              ),
              // The label's room grows and shrinks with [open] itself, so the
              // icon slides to centre smoothly instead of jumping when the
              // label goes.
              Flexible(
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: open,
                    child: Padding(
                      padding: const EdgeInsets.only(left: _FloatingNav._gap),
                      // Only shows as the pill lands, never outside it.
                      child: Opacity(
                        opacity: ((open - 0.5) * 2).clamp(0.0, 1.0),
                        child: Text(
                          label,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                          style: labelStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
