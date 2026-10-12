import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/mate_avatar.dart';
import '../../../chores/presentation/chore_editor_sheet.dart';
import '../../../../core/widgets/app_icon.dart';

/// For an Admin who is alone in a new Flat: the Invite to share.
class InviteCard extends StatelessWidget {
  const InviteCard({
    super.key,
    required this.meId,
    required this.flatName,
    required this.inviteCode,
  });

  final int meId;
  final String flatName;
  final String inviteCode;

  Future<void> _share(BuildContext context) async {
    // ponytail: copies to the clipboard; add share_plus for the system sheet.
    await Clipboard.setData(
      ClipboardData(
        text: 'Join $flatName on Flatmates with the Invite code $inviteCode',
      ),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invite copied. Send it to your Mates.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    Widget placeholder([Widget? child]) => Container(
      width: Sizes.avatarLg,
      height: Sizes.avatarLg,
      margin: const EdgeInsets.only(left: Space.sm),
      child: CustomPaint(
        painter: _Dashed(const CircleBorder(), fm.inkSoft),
        child: Center(child: child),
      ),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        color: fm.surface,
        borderRadius: BorderRadius.circular(Radii.hero),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Row(
              children: [
                MateAvatar(meId, size: Sizes.avatarLg),
                placeholder(
                  AppIcon(
                    HugeIcons.strokeRoundedAdd01,
                    size: 20,
                    color: fm.inkSoft,
                  ),
                ),
                placeholder(),
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          Text(
            'A Flat is better with Mates',
            style: context.text.headlineSmall?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: Space.md),
          Text(
            'Share your Invite so everyone can join $flatName.',
            style: context.text.bodyMedium?.copyWith(color: fm.inkSoft),
          ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 52),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Space.sm),
                  decoration: BoxDecoration(
                    color: fm.ground,
                    borderRadius: BorderRadius.circular(Radii.input),
                  ),
                  child: SelectableText(
                    inviteCode,
                    textAlign: TextAlign.center,
                    style: context.text.titleLarge?.copyWith(
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Space.sm),
              FilledButton(
                onPressed: () => _share(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 52),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  textStyle: context.text.labelLarge?.copyWith(fontSize: 16),
                ),
                child: const Text('Share Invite'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// No Chores in the Flat yet; the Admin gets one-tap suggestions.
class NoChoresCard extends StatelessWidget {
  const NoChoresCard({super.key, required this.amAdmin});

  final bool amAdmin;

  static const _suggestions = ['Take out bins', 'Clean bathroom', 'Hoover'];

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return CustomPaint(
      painter: _Dashed(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.hero)),
        fm.switchOff,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NO CHORES YET',
              style: context.text.labelMedium?.copyWith(
                fontSize: 13,
                letterSpacing: 0.5,
                color: fm.inkSoft,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Nobody\'s Turn. Enjoy it while it lasts.',
              style: context.text.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              amAdmin
                  ? 'Add your first Chore and Flatmates will set up a fair Rotation.'
                  : 'When your Admin adds a Chore, Flatmates will set up a fair Rotation.',
              style: context.text.bodyMedium?.copyWith(color: fm.inkSoft),
            ),
            if (amAdmin) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: Space.sm,
                runSpacing: Space.sm,
                children: [
                  for (final name in _suggestions)
                    TextButton(
                      onPressed: () => showChoreEditor(context, name: name),
                      style: TextButton.styleFrom(
                        backgroundColor: fm.surface,
                        foregroundColor: fm.ink,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        textStyle: context.text.titleSmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      child: Text('+ $name'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A 2px dashed outline of [shape].
class _Dashed extends CustomPainter {
  _Dashed(this.shape, this.color);

  final ShapeBorder shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = shape.getOuterPath((Offset.zero & size).deflate(1));
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 10) {
        canvas.drawPath(metric.extractPath(d, d + 6), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_Dashed old) => old.color != color || old.shape != shape;
}
