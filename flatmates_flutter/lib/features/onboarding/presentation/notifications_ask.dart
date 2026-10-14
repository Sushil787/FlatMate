import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_icon.dart';
import '../../../core/widgets/app_sheet.dart';
import 'step_layout.dart';

/// The soft ask: what notifications are for, before the phone's prompt.
/// "Not now" leaves the prompt unused for later. The last step of
/// onboarding, and its own screen after a sign-in.
class NotificationsAsk extends StatelessWidget {
  const NotificationsAsk({
    super.key,
    required this.asking,
    required this.onYes,
    required this.onNo,
  });

  final bool asking;
  final VoidCallback onYes;
  final VoidCallback onNo;

  @override
  Widget build(BuildContext context) {
    final fm = context.fm;
    return StepLayout(
      art: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: fm.primaryTint,
            shape: BoxShape.circle,
          ),
          child: AppIcon(
            HugeIcons.strokeRoundedNotification02,
            size: 32,
            color: fm.onPrimaryTint,
          ),
        ),
      ),
      title: 'Know when it\'s your Turn',
      body:
          'A summary each morning, a nudge 3 hours before a Turn ends, and '
          'news from your Flat. Pick what you get in Settings.',
      action: PrimaryButton(
        label: 'Turn on notifications',
        busy: asking,
        onPressed: onYes,
      ),
      secondary: TextButton(
        onPressed: asking ? null : onNo,
        child: const Text('Not now'),
      ),
    );
  }
}
