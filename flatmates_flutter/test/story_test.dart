import 'package:flatmates_flutter/core/theme/app_theme.dart';
import 'package:flatmates_flutter/features/onboarding/presentation/story_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The dishes story on a small phone at the largest text size. Any
/// overflow fails this.
void main() {
  testWidgets('the story fits at 360dp, 200% text, and moves on', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360 * 3, 2400);
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearAllTestValues);

    var next = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: FlatmatesTheme.light(),
        // Laid out the way the sign-in screen lays it out.
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, box) => SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: box.maxHeight - 48),
                child: IntrinsicHeight(
                  child: StoryPage(onNext: () => next++),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('No, yours.'), findsOneWidget);
    await tester.ensureVisible(find.text('There\'s a better way'));
    await tester.tap(find.text('There\'s a better way'));
    expect(next, 1);
  });
}
