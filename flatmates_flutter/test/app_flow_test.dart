import 'package:flatmates_flutter/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

Future<void> pumpApp(WidgetTester tester, FakeBackend backend) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: backend.overrides(),
      child: const FlatmatesApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a user without a flat joins one with a code', (tester) async {
    final backend = FakeBackend(inFlat: false);
    await pumpApp(tester, backend);

    expect(find.text('Let\'s set up your home'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Your name'), 'Priya');
    await tester.enterText(find.widgetWithText(TextFormField, 'Invite code'), 'WRONG1');
    await tester.tap(find.text('Join flat'));
    await tester.pumpAndSettle();
    expect(find.text('That invite code doesn\'t match any flat.'), findsOneWidget);
    // Let the error's snackbar go: it covers the button.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Invite code'), 'abc234');
    await tester.tap(find.text('Join flat'));
    await tester.pumpAndSettle();
    // Home is the Flat's fridge.
    expect(find.text('Elm St'), findsOneWidget);
    expect(find.text('All clear!'), findsOneWidget);
  });

  testWidgets('my turn is the hero card and can be marked done', (tester) async {
    final backend = FakeBackend()
      ..addChore('Bins', mateId: FakeBackend.priya)
      ..addChore('Kitchen', mateId: FakeBackend.sam, id: 2);
    await pumpApp(tester, backend);

    // The fridge shows my Turn; its magnet opens Chores.
    expect(find.text('YOUR TURN'), findsOneWidget);
    await tester.tap(find.text('Bins'));
    await tester.pumpAndSettle();

    expect(find.text('YOUR TURN'), findsOneWidget);
    expect(find.text('Bins'), findsOneWidget);
    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('EVERYONE\'S CHORES'), findsOneWidget);

    await tester.tap(find.text('Mark as done'));
    await tester.pumpAndSettle();
    expect(backend.doneTurnIds, [100]);
    expect(find.text('You\'re all clear'), findsOneWidget);
  });

  testWidgets('the admin creates a chore', (tester) async {
    final backend = FakeBackend();
    await pumpApp(tester, backend);

    await tester.tap(find.text('All clear!'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New chore'));
    await tester.pumpAndSettle();
    expect(find.text('ROTATION'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Chore'), 'Bathroom');
    await tester.tap(find.text('Create chore'));
    await tester.pumpAndSettle();

    expect(backend.chores.single.name, 'Bathroom');
    expect(find.text('YOUR TURN'), findsOneWidget);
  });

  testWidgets('every magnet opens its screen, whose main action works', (tester) async {
    final backend = FakeBackend()..addChore('Bins', mateId: FakeBackend.sam);
    await pumpApp(tester, backend);

    await tester.tap(find.text('Groceries'));
    await tester.pumpAndSettle();
    expect(find.text('Nothing needed'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Milk - 2L');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('Milk'), findsOneWidget);
    expect(backend.groceries.single.note, '2L');
    await tester.tap(find.text('Milk'));
    await tester.pumpAndSettle();
    expect(find.text('Bought by You'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nothing posted yet.'));
    await tester.pumpAndSettle();
    expect(find.text('The board is clear'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Party on Saturday!');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Party on Saturday!'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    // Back on the fridge, the notice magnet shows the new notice.
    expect(find.text('Party on Saturday!'), findsOneWidget);

    await tester.tap(find.text('This week'));
    await tester.pumpAndSettle();
    expect(find.text('I\'m away'), findsOneWidget);
    expect(find.text('Turns'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Elm St'));
    await tester.pumpAndSettle();
    expect(find.text('Invite your flatmates'), findsOneWidget);
    expect(find.text('A'), findsWidgets); // invite code tiles
    expect(find.text('Sam'), findsOneWidget);
    await tester.ensureVisible(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Away rule set to Skip'), findsOneWidget);
  });

  testWidgets('leaving the flat returns to onboarding', (tester) async {
    final backend = FakeBackend();
    // A sole admin may leave.
    backend.myFlat!.mates.removeRange(1, 3);
    await pumpApp(tester, backend);

    await tester.tap(find.text('Elm St'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Leave flat'), 200);
    await tester.tap(find.text('Leave flat'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Leave'));
    await tester.pumpAndSettle();

    expect(find.text('Let\'s set up your home'), findsOneWidget);
  });
}
