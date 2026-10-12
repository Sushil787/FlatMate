/// The texts of the twice-daily Turn pushes: one push per Mate, however
/// many Chores it covers.
typedef Push = ({String title, String body});

/// A single Turn's push: at the morning summary, or when a Turn lands on a
/// Mate partway through the day.
Push turnPush(String chore, {String? coveringFor, required String due}) =>
    coveringFor == null
    ? (title: 'Your Turn: $chore', body: 'It\'s yours, due $due.')
    : (
        title: 'You\'re covering: $chore',
        body: 'Doing $coveringFor\'s turn, due $due.',
      );

/// The morning push for a Mate whose Turns start today. [chores] holds one
/// entry per Turn, with whom they cover for if anyone.
Push morningPush(
  List<({String chore, String? coveringFor})> chores, {
  required String due,
}) {
  if (chores.length == 1) {
    final (:chore, :coveringFor) = chores.single;
    return turnPush(chore, coveringFor: coveringFor, due: due);
  }
  return (
    title: 'Your Turns today',
    body: chores
        .map(
          (c) => c.coveringFor == null
              ? c.chore
              : '${c.chore} (covering ${c.coveringFor})',
        )
        .join(', '),
  );
}

/// The evening push for one Mate: [mine] are the Chores of their own Turns
/// not Done yet, [others] each other Mate's. Null when there's nothing to
/// tell them.
Push? eveningPush(
  List<String> mine,
  Map<String, List<String>> others, {
  required int hoursLeft,
}) {
  final open = [
    for (final MapEntry(key: mate, value: chores) in others.entries)
      '$mate (${chores.join(', ')})',
  ].join(', ');
  if (mine.isNotEmpty) {
    return (
      title: '$hoursLeft hours left for ${mine.join(', ')}',
      body: others.isEmpty
          ? 'Done already? Tap to tell your Mates.'
          : 'Also not Done yet: $open',
    );
  }
  if (others.isEmpty) return null;
  return (title: 'Not Done yet', body: '$open. $hoursLeft hours left.');
}
