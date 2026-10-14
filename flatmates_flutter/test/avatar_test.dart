import 'package:flatmates_flutter/core/theme/app_theme.dart';
import 'package:flatmates_flutter/core/widgets/mate_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('an avatar stays round when its parent stretches it', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: FlatmatesTheme.light(),
        home: const Center(
          // A dialog's icon gets the dialog's whole width.
          child: SizedBox(
            width: 280,
            height: 48,
            child: Avatar(name: 'Kiran', colorIndex: 4, size: 48),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(ClipOval)), const Size(48, 48));
  });
}
