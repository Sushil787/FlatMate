import 'package:flutter/material.dart';
import 'package:stupid_simple_sheet/stupid_simple_sheet.dart';

import '../theme/app_theme.dart';
import 'app_icon.dart';

/// Opens [sheet] (usually an [AppSheet]) as a spring-driven bottom sheet:
/// drag it down or tap outside to close. It covers the floating nav.
Future<T?> showAppSheet<T>(BuildContext context, Widget sheet) {
  final fm = context.fm;
  return Navigator.of(context, rootNavigator: true).push(
    StupidSimpleSheetRoute<T>(
      // Reduced motion still needs a (quick, flat) slide: the route only
      // settles open by animating there.
      motion: MediaQuery.disableAnimationsOf(context)
          ? const Motion.linear(Duration(milliseconds: 120))
          : const CupertinoMotion.smooth(snapToEnd: true),
      barrierColor: fm.ink.withValues(alpha: 0.4),
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: SheetBackground(
          backgroundColor: fm.surface,
          shape: const RoundedSuperellipseBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Radii.sheet),
            ),
          ),
          // Text fields and ink splashes need a Material to sit on.
          child: Material(type: MaterialType.transparency, child: sheet),
        ),
      ),
    ),
  );
}

/// A bottom sheet: grabber, title + Cancel, scrolling [children], and the
/// primary [action] pinned at the bottom in thumb reach.
class AppSheet extends StatelessWidget {
  const AppSheet({
    super.key,
    required this.title,
    required this.children,
    this.action,
  });

  final String title;
  final List<Widget> children;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: Space.sm),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: fm.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.lg, 0, Space.sm, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(title, style: context.text.headlineSmall),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.maybePop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: fm.ink,
                      textStyle: context.text.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  Space.lg,
                  Space.md,
                  Space.lg,
                  Space.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < children.length; i++) ...[
                      if (i > 0) const SizedBox(height: 14),
                      children[i],
                    ],
                  ],
                ),
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Space.lg,
                  0,
                  Space.lg,
                  Space.xl,
                ),
                child: action,
              ),
          ],
        ),
      ),
    );
  }
}

/// A sheet's or card's main button: lime, 60 high, optional icon.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.busy = false,
    this.background,
    this.foreground,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppIconData? icon;

  /// Shows a spinner and ignores taps while an action runs.
  final bool busy;

  /// Overrides for the Turn card, whose button flips colour in dark mode.
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final fg = foreground ?? context.fm.onPrimary;
    return FilledButton(
      onPressed: busy ? null : onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(Sizes.buttonHero),
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        backgroundColor: background,
        foregroundColor: foreground,
        disabledBackgroundColor: busy
            ? (background ?? context.fm.primary)
            : null,
        textStyle: context.text.labelLarge?.copyWith(fontSize: 18),
      ),
      child: busy
          ? SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: fg),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon case final icon?) ...[
                  AppIcon(icon, size: 22),
                  const SizedBox(width: 10),
                ],
                Flexible(child: Text(label, textAlign: TextAlign.center)),
              ],
            ),
    );
  }
}
