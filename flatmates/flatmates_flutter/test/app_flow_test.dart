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

    await tester.enterText(find.widgetWithText(TextFormField, 'Invite code'), 'abc234');
    await tester.tap(find.text('Join flat'));
    await tester.pumpAndSettle();
    expect(find.text('Priya'), findsWidgets);
    expect(find.text('No chores yet'), findsOneWidget);
  });

  testWidgets('my turn is the hero card and can be marked done', (tester) async {
    final backend = FakeBackend()
      ..addChore('Bins', mateId: FakeBackend.priya)
      ..addChore('Kitchen', mateId: FakeBackend.sam, id: 2);
    await pumpApp(tester, backend);

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

    await tester.tap(find.text('New chore'));
    await tester.pumpAndSettle();
    expect(find.text('ROTATION'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Chore'), 'Bathroom');
    await tester.tap(find.text('Create chore'));
    await tester.pumpAndSettle();

    expect(backend.chores.single.name, 'Bathroom');
    expect(find.text('YOUR TURN'), findsOneWidget);
  });

  testWidgets('every tab renders and its main action works', (tester) async {
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

    await tester.tap(find.text('Board'));
    await tester.pumpAndSettle();
    expect(find.text('The board is clear'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Party on Saturday!');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Party on Saturday!'), findsOneWidget);

    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();
    expect(find.text('I\'m away'), findsOneWidget);
    expect(find.text('Turns'), findsOneWidget);

    await tester.tap(find.text('Flat'));
    await tester.pumpAndSettle();
    expect(find.text('Invite your flatmates'), findsOneWidget);
    expect(find.text('A'), findsWidgets); // invite code tiles
    expect(find.text('Sam'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Away rule set to Skip'), findsOneWidget);
  });

  testWidgets('leaving the flat returns to onboarding', (tester) async {
    final backend = FakeBackend();
    // A sole admin may leave.
    backend.myFlat!.mates.removeRange(1, 3);
    await pumpApp(tester, backend);

    await tester.tap(find.text('Flat'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Leave flat'), 200);
    await tester.tap(find.text('Leave flat'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Leave'));
    await tester.pumpAndSettle();

    expect(find.text('Let\'s set up your home'), findsOneWidget);
  });
}
