import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A soft spot illustration built from a gradient blob, an icon and a few
/// floating accents. Used for empty states and onboarding.
class Illustration extends StatelessWidget {
  const Illustration({
    super.key,
    required this.icon,
    this.size = 160,
    this.color,
  });

  final IconData icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = color ?? scheme.primary;
    final accents = context.colors;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.86,
            height: size * 0.86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  base.withValues(alpha: 0.22),
                  base.withValues(alpha: 0.04),
                ],
              ),
            ),
          ),
          Container(
            width: size * 0.5,
            height: size * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [base, Color.lerp(base, Colors.black, 0.2)!],
              ),
              boxShadow: [
                BoxShadow(
                  color: base.withValues(alpha: 0.35),
                  blurRadius: size * 0.14,
                  offset: Offset(0, size * 0.06),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: size * 0.26),
          ),
          _Dot(
            alignment: const Alignment(0.78, -0.72),
            size: size * 0.09,
            color: accents.away,
          ),
          _Dot(
            alignment: const Alignment(-0.82, 0.5),
            size: size * 0.07,
            color: accents.event,
          ),
          _Dot(
            alignment: const Alignment(0.7, 0.78),
            size: size * 0.05,
            color: accents.matePalette.first,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.alignment,
    required this.size,
    required this.color,
  });

  final Alignment alignment;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => Align(
    alignment: alignment,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    ),
  );
}
