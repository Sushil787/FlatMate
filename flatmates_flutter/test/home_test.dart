import 'package:flatmates_flutter/app/app.dart';
import 'package:flatmates_flutter/core/widgets/fridge/light_bulb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

/// The fridge home on a phone, a tablet and a desktop, in both themes.
/// Any overflow in the fridge or its magnets fails these.
void main() {
  for (final width in [360.0, 800.0, 1280.0]) {
    testWidgets('the fridge fits at ${width}dp, light and dark', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width * 3, 2400);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final backend = FakeBackend()
        ..addChore('Take out the bins', mateId: FakeBackend.priya);
      await tester.pumpWidget(
        ProviderScope(
          overrides: backend.overrides(),
          child: const FlatmatesApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Take out the bins'), findsOneWidget);
      expect(
        Theme.of(tester.element(find.byType(LightBulb))).brightness,
        Brightness.light,
      );

      // The bulb switches the app to dark mode.
      await tester.tap(find.byType(LightBulb));
      await tester.pumpAndSettle();
      expect(
        Theme.of(tester.element(find.byType(LightBulb))).brightness,
        Brightness.dark,
      );

      // A magnet opens its screen, and back leads to the fridge.
      await tester.tap(find.text('Take out the bins'));
      await tester.pumpAndSettle();
      expect(find.text('Mark as done'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(LightBulb), findsOneWidget);
    });
  }
}
