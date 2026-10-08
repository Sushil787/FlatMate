import 'package:flutter/widgets.dart';
import 'package:hugeicons/hugeicons.dart';

/// A Hugeicons icon, such as `HugeIcons.strokeRoundedHome01`.
typedef AppIconData = List<List<dynamic>>;

/// [Icon] for Hugeicons. Unlike [HugeIcon], it takes its size from the
/// [IconTheme] when none is given, as [Icon] does.
class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size, this.color});

  final AppIconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => HugeIcon(
    icon: icon,
    size: size ?? IconTheme.of(context).size,
    color: color,
  );
}
