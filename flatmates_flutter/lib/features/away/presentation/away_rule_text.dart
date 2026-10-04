import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/material.dart';

/// How each Away rule is presented to people.
extension AwayRuleText on AwayRule {
  String get label => switch (this) {
    AwayRule.swap => 'Swap',
    AwayRule.skip => 'Skip',
    AwayRule.pause => 'Pause',
  };

  String get explanation => switch (this) {
    AwayRule.swap =>
      'The next mate covers your turn, and you do their next one in return.',
    AwayRule.skip => 'The next mate takes your turn. Nothing is owed.',
    AwayRule.pause =>
      'Your chores wait until you\'re back; away days during a turn extend it.',
  };

  IconData get icon => switch (this) {
    AwayRule.swap => Icons.swap_horiz_rounded,
    AwayRule.skip => Icons.skip_next_rounded,
    AwayRule.pause => Icons.pause_circle_outline_rounded,
  };
}
