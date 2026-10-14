import 'generated/protocol.dart';

/// When each [TurnTime] runs, in minutes after the Flat's local midnight,
/// and when its pushes go out. The Turn itself still lasts the whole day.
extension TurnTimeWindow on TurnTime {
  int get startsAt => switch (this) {
    TurnTime.morning => 7 * 60,
    TurnTime.afternoon => 12 * 60,
    TurnTime.evening => 17 * 60,
    TurnTime.night => 21 * 60,
  };

  int get endsAt => switch (this) {
    TurnTime.morning => 12 * 60,
    TurnTime.afternoon => 17 * 60,
    TurnTime.evening => 21 * 60,
    TurnTime.night => 24 * 60,
  };

  /// The reminder for a Turn not Done yet: an hour before its Turn time
  /// ends, so there's still time to do it.
  int get remindAt => endsAt - 60;

  /// "Morning".
  String get label => switch (this) {
    TurnTime.morning => 'Morning',
    TurnTime.afternoon => 'Afternoon',
    TurnTime.evening => 'Evening',
    TurnTime.night => 'Night',
  };

  /// "this morning", for push texts.
  String get thisPart => switch (this) {
    TurnTime.morning => 'this morning',
    TurnTime.afternoon => 'this afternoon',
    TurnTime.evening => 'this evening',
    TurnTime.night => 'tonight',
  };
}

/// The Flat-wide pushes, in minutes after local midnight: Mates' Turns not
/// Done (Morning and Afternoon ones, once their Turn time is over), and the
/// night summary of the day. Fixed, and clear of every Turn time's pushes.
const matesNotDoneAt = 18 * 60;
const nightSummaryAt = 22 * 60;
