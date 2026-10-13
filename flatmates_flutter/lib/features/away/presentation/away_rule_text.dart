import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/widgets/app_icon.dart';

/// How each Away rule is presented to people.
extension AwayRuleText on AwayRule {
  String get label => switch (this) {
    AwayRule.swap => 'Swap',
    AwayRule.skip => 'Skip',
    AwayRule.pause => 'Pause',
  };

  String get explanation => switch (this) {
    AwayRule.swap => 'Another Mate covers the Turn and is owed one back.',
    AwayRule.skip => 'The Turn passes to the next Mate.',
    AwayRule.pause => 'The Chore waits until the Mate is back.',
  };

  AppIconData get icon => switch (this) {
    AwayRule.swap => HugeIcons.strokeRoundedArrowDataTransferHorizontal,
    AwayRule.skip => HugeIcons.strokeRoundedNext,
    AwayRule.pause => HugeIcons.strokeRoundedPause,
  };
}
