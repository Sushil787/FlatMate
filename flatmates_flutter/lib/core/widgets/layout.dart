import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../theme/app_theme.dart';
import 'app_icon.dart';

/// A 48px round icon button: surface fill by default, lime for the
/// screen's main action.
class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.primary = false,
    this.size = Sizes.touchMin,
  });

  /// Pops the current route.
  const CircleButton.back({super.key, this.tooltip = 'Back'})
    : icon = HugeIcons.strokeRoundedArrowLeft01,
      onPressed = null,
      primary = false,
      size = Sizes.touchMin;

  final AppIconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool primary;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed ?? () => context.router.maybePop(),
      icon: AppIcon(icon, size: primary ? 24 : 22),
      style: IconButton.styleFrom(
        backgroundColor: primary ? fm.primary : fm.surface,
        foregroundColor: primary ? fm.onPrimary : fm.ink,
        fixedSize: Size.square(size),
      ),
    );
  }
}

/// A quiet pill button on the ground, e.g. "Edit" next to a back button.
class PillButton extends StatelessWidget {
  const PillButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: fm.surface,
        foregroundColor: fm.ink,
        minimumSize: const Size(0, Sizes.touchMin),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        textStyle: context.text.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
    );
  }
}

/// A screen's title row: optional back button, the 30px title, and an
/// optional action on the right.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader(
    this.title, {
    super.key,
    this.back = false,
    this.trailing,
    this.subtitle,
  });

  final String title;
  final bool back;
  final Widget? trailing;

  /// Small text under (or beside) the title, e.g. "8 open".
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.sm),
      child: Row(
        children: [
          if (back) ...[
            const CircleButton.back(),
            const SizedBox(width: Space.md),
          ],
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: context.text.headlineMedium),
            ),
          ),
          ?subtitle,
          ?trailing,
        ],
      ),
    );
  }
}

/// A heading above a card, with an optional link on the right.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Space.sm),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(title, style: context.text.titleMedium),
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              // Plain text in the app's lime-family link colour (dark olive
              // on light, lime on dark).
              style: TextButton.styleFrom(
                foregroundColor: context.fm.link,
                padding: const EdgeInsets.symmetric(horizontal: Space.sm),
                textStyle: context.text.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(action!),
            ),
        ],
      ),
    );
  }
}

/// A card of [AppRow]s with 1px dividers between them.
class RowCard extends StatelessWidget {
  const RowCard({super.key, required this.children, this.color});

  final List<Widget> children;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: 4),
        child: Column(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) const Divider(),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

/// A list row: leading avatar or checkbox, title + meta, trailing chip or
/// chevron. Grows with the text size.
class AppRow extends StatelessWidget {
  const AppRow({
    super.key,
    required this.title,
    this.meta,
    this.leading,
    this.trailing,
    this.onTap,
    this.minHeight = 56,
  });

  final Widget title;
  final Widget? meta;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Space.sm),
        child: LayoutBuilder(
          builder: (context, box) => Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: Space.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle.merge(
                      style: context.text.titleSmall,
                      child: title,
                    ),
                    if (meta != null)
                      DefaultTextStyle.merge(
                        style: context.text.bodySmall,
                        child: meta!,
                      ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: Space.md),
                // Capped so a wide tag (large text, small phone) wraps
                // instead of pushing the title out of the row.
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: box.maxWidth * 0.4),
                  child: trailing,
                ),
              ],
            ],
          ),
        ),
      ),
    );
    if (onTap == null) return row;
    return InkWell(onTap: onTap, child: row);
  }
}

/// Scrolling screen body with the standard margins and top inset, leaving
/// room for the floating nav when [underNav].
class ScreenList extends StatelessWidget {
  const ScreenList({
    super.key,
    required this.children,
    this.underNav = true,
    this.underAdd = false,
    this.gap = Space.md,
  });

  final List<Widget> children;
  final bool underNav;

  /// Leaves room for an [AddButton] too, so the last row can scroll clear.
  final bool underAdd;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(
          Space.screenMargin,
          Space.lg,
          Space.screenMargin,
          (underNav ? Space.navClearance : Space.xxl) +
              (underAdd ? Sizes.buttonPrimary + Space.md : 0),
        ),
        itemCount: children.length,
        separatorBuilder: (_, _) => SizedBox(height: gap),
        itemBuilder: (_, i) => children[i],
      ),
    );
  }
}

/// A tab's add action: a lime + in the bottom-right corner just above the
/// floating nav, in the same spot on every tab. Goes in a [Stack] over the
/// screen's [ScreenList] (with `underAdd`).
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.tooltip,
    required this.onPressed,
    this.label,
  });

  final String tooltip;
  final VoidCallback onPressed;

  /// Shown beside the +, making it a pill ("Add Event").
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: Space.screenMargin,
      bottom: MediaQuery.paddingOf(context).bottom + 10,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.buttonPrimary / 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2E16181A),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: label == null
            ? CircleButton(
                icon: HugeIcons.strokeRoundedAdd01,
                tooltip: tooltip,
                primary: true,
                size: Sizes.buttonPrimary,
                onPressed: onPressed,
              )
            : FilledButton.icon(
                onPressed: onPressed,
                icon: const AppIcon(HugeIcons.strokeRoundedAdd01, size: 22),
                label: Text(label!),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, Sizes.buttonPrimary),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  textStyle: context.text.labelLarge?.copyWith(fontSize: 16),
                ),
              ),
      ),
    );
  }
}

/// A tab's pinned, collapsing header: a small [eyebrow] over a big [title]
/// on the left, [trailing] on the right. Scrolling up folds it into a slim
/// bar that shows just [collapsed]. [trailing] gets how far it has folded,
/// 0 to 1, to shrink with it. Goes first in a [CustomScrollView].
class CollapsingHeader extends StatelessWidget {
  const CollapsingHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.collapsed,
    this.trailing,
  });

  final String eyebrow;
  final String title;

  /// What the slim bar shows; [eyebrow] by default.
  final String? collapsed;
  final Widget Function(double shrink)? trailing;

  static const _bar = 60.0;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    final scaler = MediaQuery.textScalerOf(context);
    final top = MediaQuery.paddingOf(context).top;
    final meta = context.text.bodySmall!.copyWith(fontWeight: FontWeight.w600);
    final big = context.text.headlineMedium!;
    double lineOf(TextStyle s) => scaler.scale(s.fontSize!) * s.height!;
    // Room for both lines at the phone's text size.
    final open = math.max(_bar, lineOf(meta) + 2 + lineOf(big) + Space.lg);

    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: fm.ground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: _bar,
      collapsedHeight: _bar,
      expandedHeight: open,
      flexibleSpace: LayoutBuilder(
        builder: (context, box) {
          // 0 fully open, 1 folded into the slim bar.
          final t = open == _bar
              ? 1.0
              : (1 - (box.maxHeight - top - _bar) / (open - _bar)).clamp(
                  0.0,
                  1.0,
                );
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: fm.line.withValues(alpha: t == 1 ? 1 : 0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(Space.screenMargin, top, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Opacity(
                          opacity: (1 - t * 1.6).clamp(0.0, 1.0),
                          child: ClipRect(
                            child: OverflowBox(
                              alignment: Alignment.centerLeft,
                              maxHeight: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    eyebrow,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: meta,
                                  ),
                                  const SizedBox(height: 2),
                                  Semantics(
                                    header: true,
                                    child: Text(
                                      title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: big,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (t > 0.4)
                          Opacity(
                            opacity: ((t - 0.4) / 0.6).clamp(0.0, 1.0),
                            child: Text(
                              collapsed ?? eyebrow,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.text.titleMedium,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!(t),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A tab under a [CollapsingHeader]: [header] then [children], spaced
/// out above the floating nav.
class HeaderScroll extends StatelessWidget {
  const HeaderScroll({
    super.key,
    required this.header,
    required this.children,
    this.gap = Space.lg,
  });

  final Widget header;
  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        header,
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            Space.screenMargin,
            Space.sm,
            Space.screenMargin,
            Space.navClearance,
          ),
          sliver: SliverList.separated(
            itemCount: children.length,
            separatorBuilder: (_, _) => SizedBox(height: gap),
            itemBuilder: (_, i) => children[i],
          ),
        ),
      ],
    );
  }
}
