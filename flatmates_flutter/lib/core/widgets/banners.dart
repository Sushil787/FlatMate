import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import 'app_icon.dart';

/// The ink bar across the top while the live connection is down.
class ReconnectingBanner extends StatelessWidget {
  const ReconnectingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    // Always ink with white text, in light and dark.
    return Material(
      color: FlatmatesColors.light.ink,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Semantics(
            liveRegion: true,
            child: Row(
              children: [
                SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: fm.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Offline • Reconnecting',
                    style: context.text.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A thin line under the status bar while saved data is on screen and
/// the server's answer is on its way.
class UpdatingBar extends StatelessWidget {
  const UpdatingBar({super.key});

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Updating',
    child: LinearProgressIndicator(
      minHeight: 2,
      color: context.fm.primary,
      backgroundColor: Colors.transparent,
    ),
  );
}

/// A danger-tint card for an action the server refused.
class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.title,
    required this.message,
    this.onDismiss,
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onDismiss;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(Space.lg),
        decoration: BoxDecoration(
          color: fm.dangerBg,
          borderRadius: BorderRadius.circular(Radii.card),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(HugeIcons.strokeRoundedAlertCircle, color: fm.dangerFg),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.text.titleSmall?.copyWith(
                          color: fm.dangerFg,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        message,
                        style: context.text.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: fm.dangerFg,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (onDismiss != null || onRetry != null) ...[
              const SizedBox(height: Space.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onDismiss != null)
                    TextButton(
                      onPressed: onDismiss,
                      style: TextButton.styleFrom(foregroundColor: fm.dangerFg),
                      child: const Text('Dismiss'),
                    ),
                  if (onRetry != null) ...[
                    const SizedBox(width: Space.sm),
                    FilledButton(
                      onPressed: onRetry,
                      style: FilledButton.styleFrom(
                        backgroundColor: fm.dangerFg,
                        foregroundColor: fm.dangerBg,
                        minimumSize: const Size(0, 44),
                      ),
                      child: const Text('Try again'),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Flashes a lime tint behind [child] that fades out, for a change that
/// just arrived live from another Mate.
class FreshHighlight extends StatefulWidget {
  const FreshHighlight({
    super.key,
    required this.fresh,
    required this.child,
    this.radius = 0,
  });

  final bool fresh;
  final Widget child;
  final double radius;

  @override
  State<FreshHighlight> createState() => _FreshHighlightState();
}

class _FreshHighlightState extends State<FreshHighlight>
    with SingleTickerProviderStateMixin {
  late final _fade = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
    value: widget.fresh ? 0 : 1,
  );

  @override
  void initState() {
    super.initState();
    if (widget.fresh) _fade.forward();
  }

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tint = context.fm.primaryTint;
    return AnimatedBuilder(
      animation: _fade,
      builder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: Color.lerp(
            tint,
            tint.withValues(alpha: 0),
            Curves.easeIn.transform(_fade.value),
          ),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}

/// A notification that arrived while the app was open, as a card that drops
/// in from the top. Tap or swipe it away.
class InAppNotification extends StatelessWidget {
  const InAppNotification({
    super.key,
    required this.title,
    required this.body,
    required this.onDismiss,
  });

  final String title;
  final String body;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Space.screenMargin,
          Space.sm,
          Space.screenMargin,
          0,
        ),
        child: Dismissible(
          key: ValueKey((title, body)),
          direction: DismissDirection.up,
          onDismissed: (_) => onDismiss(),
          child: Semantics(
            liveRegion: true,
            child: Material(
              color: fm.heroCard,
              borderRadius: BorderRadius.circular(Radii.card),
              elevation: 6,
              shadowColor: const Color(0x5216181A),
              child: InkWell(
                onTap: onDismiss,
                borderRadius: BorderRadius.circular(Radii.card),
                child: Padding(
                  padding: const EdgeInsets.all(Space.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppIcon(
                        HugeIcons.strokeRoundedNotification03,
                        color: fm.primary,
                      ),
                      const SizedBox(width: Space.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title.isNotEmpty)
                              Text(
                                title,
                                style: context.text.titleSmall?.copyWith(
                                  color: fm.onHeroCard,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            if (body.isNotEmpty)
                              Text(
                                body,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: context.text.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: fm.onHeroCard,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
