import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/app/app.dart';
import 'package:flatmates_flutter/core/providers/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

/// Every tab on a small phone and a tablet, light and dark, at the phone's
/// largest text size. Any overflow fails these.
void main() {
  for (final width in [360.0, 800.0]) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('every tab fits at ${width}dp, ${mode.name}, 200% text', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width * 3, 2400);
        tester.view.devicePixelRatio = 3;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        tester.platformDispatcher.accessibilityFeaturesTestValue =
            const FakeAccessibilityFeatures(disableAnimations: true);
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearAllTestValues);

        final backend = FakeBackend()
          ..addChore('Take out the bins', mateId: FakeBackend.priya)
          ..addChore('Clean the bathroom', mateId: FakeBackend.sam, id: 2);
        backend.groceries.add(
          GroceryItem(
            id: 1,
            flatId: 10,
            name: 'Oat milk',
            addedByMateId: FakeBackend.sam,
            createdAt: DateTime.now(),
          ),
        );
        final container = ProviderContainer(overrides: backend.overrides());
        addTearDown(container.dispose);
        container.read(themeModeControllerProvider.notifier).set(mode);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const FlatmatesApp(),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Take out the bins'), findsWidgets);
        expect(
          Theme.of(
            tester.element(find.text('Take out the bins').first),
          ).brightness,
          mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
        );

        for (final tab in ['Chores', 'Calendar', 'Groceries', 'Flat']) {
          await tester.tap(find.bySemanticsLabel(RegExp('^$tab')));
          await tester.pumpAndSettle();
        }
        expect(find.textContaining('Your Flat'), findsOneWidget);
      });
    }
  }

  testWidgets('a notification while the app is open shows in-app', (
    tester,
  ) async {
    final backend = FakeBackend();
    await tester.pumpWidget(
      ProviderScope(
        overrides: backend.overrides(),
        child: const FlatmatesApp(),
      ),
    );
    await tester.pumpAndSettle();

    backend.pushes.add(
      const RemoteNotification(
        title: 'Sam added an Event',
        body: 'Saturday party',
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Sam added an Event'), findsOneWidget);
    expect(find.text('Saturday party'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Sam added an Event'), findsNothing);
  });
}
