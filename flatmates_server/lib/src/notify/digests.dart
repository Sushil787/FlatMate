import 'package:flatmates_shared/flatmates_shared.dart';

/// The texts of the Turn pushes: one push per Mate per Turn time, however
/// many Chores it covers.
typedef Push = ({String title, String body});

/// The push at the start of a Turn time, or when a Turn lands on a Mate
/// later. [chores] holds one entry per Turn, with whom they cover for if
/// anyone; [when] is "this morning", or "today" once its Turn time is over.
Push startPush(
  List<({String chore, String? coveringFor})> chores, {
  required String when,
}) {
  if (chores.length == 1) {
    final (:chore, :coveringFor) = chores.single;
    return coveringFor == null
        ? (title: 'Your Turn: $chore', body: 'It\'s yours $when.')
        : (
            title: 'You\'re covering: $chore',
            body: 'Doing $coveringFor\'s Turn $when.',
          );
  }
  return (
    title: 'Your Turns $when',
    body: chores
        .map(
          (c) => c.coveringFor == null
              ? c.chore
              : '${c.chore} (covering ${c.coveringFor})',
        )
        .join(', '),
  );
}

/// An hour before [time] ends, for the Mate's [chores] of that Turn time
/// not Done yet.
Push reminderPush(List<String> chores, TurnTime time) => (
  title: '${chores.join(', ')}: 1 hour left ${time.thisPart}',
  body: 'Done already? Tap to tell your Mates.',
);

/// 18:00: each other Mate's Turns from earlier Turn times not Done yet, by
/// name. Null when there are none.
Push? matesNotDonePush(Map<String, List<String>> byMate) {
  if (byMate.isEmpty) return null;
  return (
    title: 'Not Done yet',
    body: [
      for (final MapEntry(key: mate, value: chores) in byMate.entries)
        '$mate: ${chores.join(', ')}.',
    ].join(' '),
  );
}

typedef Who = ({String chore, String who});

/// 22:00: the day in [flat]. [notDone] are Turns whose Turn time is over;
/// [tonight] are Night ones still to come. Not "Missed": the day isn't
/// over yet. Null when the Flat had no Turns today.
Push? nightSummaryPush(
  String flat, {
  required List<Who> done,
  required List<Who> notDone,
  required List<Who> tonight,
}) {
  String list(List<Who> turns) =>
      turns.map((t) => '${t.chore} (${t.who})').join(', ');
  final parts = [
    if (done.isNotEmpty) 'Done: ${list(done)}.',
    if (notDone.isNotEmpty) 'Not Done: ${list(notDone)}.',
    if (tonight.isNotEmpty) 'Still tonight: ${list(tonight)}.',
  ];
  if (parts.isEmpty) return null;
  return (title: 'Today in $flat', body: parts.join(' '));
}

/// To the Flat when a Mate joins.
Push joinedPush(String mate, String flat) => (
  title: '$mate joined $flat',
  body: 'Say hi! The admin can add them to chores.',
);

/// To the Flat when a Mate posts a Notice.
Push noticePush(String mate, String text) =>
    (title: '$mate posted a Notice', body: text);

/// To the Flat when a Mate adds an Event and tells everyone.
Push eventPush(String mate, String title) =>
    (title: '$mate added an Event', body: title);

/// To a Mate the Admin put into a Chore's Rotation.
Push addedPush(String admin, String chore) => (
  title: 'You\'ve been added to a Rotation',
  body: '$admin added you to $chore.',
);
