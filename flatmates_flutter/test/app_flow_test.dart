import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flatmates_flutter/app/app.dart';
import 'package:flatmates_flutter/features/auth/application/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

Future<void> pumpApp(WidgetTester tester, FakeBackend backend) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  // The live dot pulses forever unless motion is reduced.
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
  await tester.pumpWidget(
    ProviderScope(
      overrides: backend.overrides(),
      child: const FlatmatesApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapTab(WidgetTester tester, String label) async {
  await tester.tap(find.bySemanticsLabel(RegExp('^$label')));
  await tester.pumpAndSettle();
}

/// Scrolls the screen's list until [finder] is clear of the floating nav.
Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.drag(find.byType(Scrollable).first, const Offset(0, -150));
  await tester.pumpAndSettle();
}

/// The practice Mark Done and Away steps; [cover] covers the Away Turn.
Future<void> practiseDoneAndAway(
  WidgetTester tester, {
  required String cover,
}) async {
  await tester.ensureVisible(find.text('Mark Done'));
  await tester.tap(find.text('Mark Done'));
  await tester.pumpAndSettle();
  expect(find.textContaining('Done ·'), findsOneWidget);
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();

  await tester.ensureVisible(find.text('Mark myself Away'));
  await tester.tap(find.text('Mark myself Away'));
  await tester.pumpAndSettle();
  expect(find.textContaining('$cover covers'), findsOneWidget);
  await tester.ensureVisible(find.text('Mark me Away'));
  await tester.tap(find.text('Mark me Away'));
  await tester.pumpAndSettle();
  expect(find.textContaining('$cover covers'), findsOneWidget);
  await tester.tap(
    find.text('Next').evaluate().isEmpty
        ? find.text('Start using Flatmates')
        : find.text('Next'),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a user without a Flat joins one with an Invite code', (
    tester,
  ) async {
    final backend = FakeBackend(inFlat: false);
    await pumpApp(tester, backend);

    expect(find.textContaining('Welcome, Priya'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, 'MAPLE-42'),
      'WRONG1',
    );
    await tester.tap(find.text('Join'));
    await tester.pumpAndSettle();
    expect(
      find.text('That invite code doesn\'t match any flat.'),
      findsOneWidget,
    );
    // Let the error's snackbar go: it covers the button.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'abc234');
    await tester.tap(find.text('Join'));
    await tester.pumpAndSettle();
    // Onboarding: who's here, and that the Admin adds them to Chores.
    expect(find.text('You\'re in Elm St.'), findsOneWidget);
    expect(find.textContaining('Sam will add you'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await practiseDoneAndAway(tester, cover: 'Sam');

    expect(find.text('Hi Priya'), findsOneWidget);
    expect(find.textContaining('Elm St'), findsOneWidget);
    expect(backend.onboardingFinished, 1);
    expect(backend.pushAsked, 0);
  });

  testWidgets('a new Admin practises a Chore, the Invite, Mark Done and '
      'Away, and nothing but onboardedAt is saved', (tester) async {
    final backend = FakeBackend(inFlat: false)..pushAllowed = false;
    await pumpApp(tester, backend);

    await tester.enterText(
      find.widgetWithText(TextField, 'Maple Street 12'),
      'Elm St',
    );
    await tester.tap(find.text('Create Flat'));
    await tester.pumpAndSettle();

    // A Chore in the real editor; Maya and Sam from the story fill the Flat.
    expect(find.textContaining('then Maya and Sam'), findsOneWidget);
    await tester.tap(find.text('+ Do the dishes'));
    await tester.pumpAndSettle();
    expect(find.text('3 Mates'), findsOneWidget);
    await tester.tap(find.text('Save Chore'));
    await tester.pumpAndSettle();
    expect(
      find.text('Every week · Evening · You, Maya and Sam'),
      findsOneWidget,
    );
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // The real Invite.
    expect(find.text('Share Invite'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await practiseDoneAndAway(tester, cover: 'Maya');

    // The soft ask, then the phone's prompt.
    expect(backend.pushAsked, 0);
    await tester.tap(find.text('Turn on notifications'));
    await tester.pumpAndSettle();
    expect(backend.pushAsked, 1);

    expect(find.text('Hi Priya'), findsOneWidget);
    expect(find.text('NO CHORES YET'), findsOneWidget);
    expect(backend.onboardingFinished, 1);
    expect(backend.chores, isEmpty);
    expect(backend.turns, isEmpty);
    expect(backend.doneTurnIds, isEmpty);
    expect(backend.aways, isEmpty);
  });

  testWidgets('onboarding fits at 360dp with 200% text', (tester) async {
    final backend = FakeBackend(inFlat: false)..pushAllowed = false;
    await pumpApp(tester, backend);
    tester.view.physicalSize = const Size(360 * 3, 2400);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'abc234');
    // Sent from the keyboard: the Join button's spot is crowded at 200%.
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await practiseDoneAndAway(tester, cover: 'Sam');
    expect(find.text('Turn on notifications'), findsOneWidget);
  });

  testWidgets('Settings shows notifications are off on this phone and asks '
      'again', (tester) async {
    final backend = FakeBackend()..pushAllowed = false;
    await pumpApp(tester, backend);
    await tester.tap(find.byTooltip('Profile and settings'));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Off on this phone'));

    expect(find.text('My Turn starts'), findsOneWidget);
    expect(find.text('Night summary'), findsOneWidget);
    await tester.ensureVisible(find.text('Turn on'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Turn on'));
    await tester.pumpAndSettle();
    expect(backend.pushAsked, 1);
    expect(find.text('Off on this phone'), findsNothing);
  });

  testWidgets('signing in on a phone without notifications asks once', (
    tester,
  ) async {
    final backend = FakeBackend(signedIn: false)..pushAllowed = false;
    await pumpApp(tester, backend);
    expect(find.text('There\'s a better way'), findsOneWidget);

    final app = ProviderScope.containerOf(
      tester.element(find.byType(FlatmatesApp)),
    );
    (app.read(authControllerProvider.notifier) as FakeAuth).signIn();
    await tester.pumpAndSettle();
    expect(find.text('Know when it\'s your Turn'), findsOneWidget);
    await tester.tap(find.text('Not now'));
    await tester.pumpAndSettle();
    expect(find.text('Hi Priya'), findsOneWidget);
    expect(backend.pushAsked, 0);
  });

  testWidgets('opening the app signed in doesn\'t ask', (tester) async {
    final backend = FakeBackend()..pushAllowed = false;
    await pumpApp(tester, backend);
    expect(find.text('Hi Priya'), findsOneWidget);
    expect(find.text('Know when it\'s your Turn'), findsNothing);
  });

  testWidgets('a Mate past onboarding goes straight to Home', (tester) async {
    final backend = FakeBackend();
    await pumpApp(tester, backend);
    expect(find.text('Hi Priya'), findsOneWidget);
    expect(backend.onboardingFinished, 0);
  });

  testWidgets('my Turn is the hero card; Mark Done and Undo', (tester) async {
    final backend = FakeBackend()
      ..addChore('Bins', mateId: FakeBackend.priya)
      ..addChore('Kitchen', mateId: FakeBackend.sam, id: 2);
    await pumpApp(tester, backend);

    expect(find.text('YOUR TURN TODAY'), findsOneWidget);
    expect(find.text('Bins'), findsOneWidget);
    expect(find.text('Up next in the Flat'), findsOneWidget);
    expect(find.text('Kitchen'), findsOneWidget);

    await tester.tap(find.text('Mark Done'));
    await tester.pumpAndSettle();
    expect(backend.doneTurnIds, [uid(100)]);
    expect(find.text('Undo'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(backend.doneTurnIds, isEmpty);
    expect(find.text('Mark Done'), findsOneWidget);
  });

  testWidgets(
    'Mark Done and Undo move the screen once, before the server answers',
    (
      tester,
    ) async {
      final backend = FakeBackend()
        ..addChore('Bins', mateId: FakeBackend.priya)
        ..latency = const Duration(milliseconds: 500);
      await pumpApp(tester, backend);

      await tester.tap(find.text('Mark Done'));
      await tester.pump(const Duration(milliseconds: 16));
      // Done at once; never a moment with neither the Turn nor the Done row.
      expect(find.text('Mark Done'), findsNothing);
      expect(find.text('Done today'), findsOneWidget);
      expect(find.text('No Turn for you today'), findsNothing);
      // The server answers; the reloads bring the same state.
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(backend.doneTurnIds, [uid(100)]);
      expect(find.text('Done today'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      await tester.pump(const Duration(milliseconds: 16));
      expect(find.text('Mark Done'), findsOneWidget);
      expect(find.text('Done today'), findsNothing);
      // The server answers; the reloads bring the same state.
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(backend.doneTurnIds, isEmpty);
      expect(find.text('Mark Done'), findsOneWidget);
    },
  );

  testWidgets('the Admin creates a Chore from the Chores tab', (tester) async {
    final backend = FakeBackend();
    await pumpApp(tester, backend);

    await tapTab(tester, 'Chores');
    await tester.tap(find.text('Add Chore'));
    await tester.pumpAndSettle();
    expect(find.text('New Chore'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, 'Take out bins'),
      'Bathroom',
    );
    await tester.ensureVisible(find.text('Morning'));
    await tester.tap(find.text('Morning'));
    await tester.pump();
    expect(find.textContaining('Starts 7:00 AM'), findsOneWidget);
    await tester.tap(find.text('Save Chore'));
    await tester.pumpAndSettle();

    expect(backend.chores.single.name, 'Bathroom');
    expect(backend.chores.single.turnTime, TurnTime.morning);
    expect(find.text('Bathroom'), findsOneWidget);
  });

  testWidgets('a double tap saves one Chore and marks a Turn Done once', (
    tester,
  ) async {
    final backend = FakeBackend()
      ..addChore('Bins', mateId: FakeBackend.priya)
      ..latency = const Duration(milliseconds: 50);
    await pumpApp(tester, backend);

    await tester.tap(find.text('Mark Done'));
    await tester.tap(find.text('Mark Done'));
    await tester.pumpAndSettle();
    expect(backend.doneTurnIds, [uid(100)]);
    expect(find.text('Done today'), findsOneWidget);

    await tapTab(tester, 'Chores');
    await tester.tap(find.text('Add Chore'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Take out bins'),
      'Bathroom',
    );
    await tester.tap(find.text('Save Chore'));
    await tester.tap(find.text('Save Chore'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(backend.chores.where((c) => c.name == 'Bathroom'), hasLength(1));
  });

  testWidgets('Groceries: add and tick a Grocery item', (tester) async {
    final backend = FakeBackend();
    await pumpApp(tester, backend);

    await tapTab(tester, 'Groceries');
    expect(
      find.text('The list is empty. The fridge is not our problem yet.'),
      findsOneWidget,
    );
    await tester.enterText(find.byType(TextField), 'Milk');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(backend.groceries.single.name, 'Milk');
    expect(find.text('Milk'), findsOneWidget);

    await tester.tap(find.text('Milk'));
    await tester.pumpAndSettle();
    expect(backend.groceries.single.boughtAt, isNotNull);
    expect(find.text('Ticked off today'), findsOneWidget);
  });

  testWidgets('Notice board: post a Notice and say Got it', (tester) async {
    final backend = FakeBackend();
    backend.notices.add(
      Notice(
        id: uid(1),
        flatId: uid(10),
        mateId: FakeBackend.sam,
        text: 'Landlord comes Friday',
        pinned: false,
        createdAt: DateTime.now(),
      ),
    );
    await pumpApp(tester, backend);

    await tapTab(tester, 'Flat');
    await scrollTo(tester, find.text('Notice board'));
    await tester.tap(find.text('Notice board'));
    await tester.pumpAndSettle();
    expect(find.text('New'), findsOneWidget);
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(backend.notices.single.gotItMateIds, [FakeBackend.priya]);
    expect(find.text('You got it'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Party on Saturday!');
    await tester.tap(find.byTooltip('Post Notice'));
    await tester.pumpAndSettle();
    expect(find.text('Party on Saturday!'), findsOneWidget);
  });

  testWidgets('the Admin is asked to add a new Mate to Chores', (
    tester,
  ) async {
    final backend = FakeBackend()
      ..addChore('Bins', mateId: FakeBackend.priya)
      ..addChore('Dishes', mateId: FakeBackend.sam, id: 2);
    backend.chores[0].rotation = [FakeBackend.priya, FakeBackend.sam];
    backend.chores[1].rotation = [FakeBackend.priya, FakeBackend.sam];
    backend.myFlat!.mates.last.welcomed = false; // Alex just joined
    await pumpApp(tester, backend);

    expect(find.text('Alex joined Elm St'), findsOneWidget);
    await tester.tap(find.widgetWithText(CheckboxListTile, 'Dishes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to 1 Chore'));
    await tester.pumpAndSettle();

    expect(find.text('Alex joined Elm St'), findsNothing);
    expect(backend.chores[0].rotation.last, FakeBackend.alex);
    expect(backend.chores[1].rotation, isNot(contains(FakeBackend.alex)));
  });

  testWidgets('the Admin sets the Away rule on the Flat tab', (tester) async {
    final backend = FakeBackend();
    await pumpApp(tester, backend);

    await tapTab(tester, 'Flat');
    expect(find.text('Invite a Mate'), findsOneWidget);
    await scrollTo(tester, find.text('Skip'));
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(backend.myFlat!.flat.awayRule, AwayRule.skip);
  });

  testWidgets('back goes to Home, then needs a second press to exit', (
    tester,
  ) async {
    await pumpApp(tester, FakeBackend());

    await tapTab(tester, 'Groceries');
    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pumpAndSettle();
    expect(find.text('Hi Priya'), findsOneWidget);

    expect(await tester.binding.handlePopRoute(), isTrue);
    await tester.pump();
    expect(find.text('Press back again to exit'), findsOneWidget);
  });

  testWidgets('leaving the Flat returns to onboarding', (tester) async {
    final backend = FakeBackend();
    // A sole Admin may leave.
    backend.myFlat!.mates.removeRange(1, 3);
    await pumpApp(tester, backend);

    await tapTab(tester, 'Flat');
    await scrollTo(tester, find.text('Leave the Flat'));
    await tester.tap(find.text('Leave the Flat'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Leave'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Welcome, Priya'), findsOneWidget);
  });
}
