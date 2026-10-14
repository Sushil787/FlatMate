import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

/// The phone's share sheet with the Flat's Invite code. [context] is the
/// widget the sheet points at on iPads.
Future<void> shareInvite(
  BuildContext context, {
  required String flatName,
  required String code,
}) {
  final box = context.findRenderObject() as RenderBox?;
  return SharePlus.instance.share(
    ShareParams(
      text: 'Join $flatName on Flatmates with the Invite code $code',
      sharePositionOrigin: box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size,
    ),
  );
}
