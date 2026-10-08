import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../away/application/aways_controller.dart';
import '../../board/application/notices_controller.dart';
import '../../calendar/application/calendar_providers.dart';
import '../../chores/application/chores_controller.dart';
import '../../flat/application/flat_changes.dart';
import '../../flat/application/my_flat_controller.dart';
import '../../groceries/application/groceries_controller.dart';

/// Keeps every feature's data in step with the server: when a Mate changes
/// something, the affected providers refetch. Watched by the home shell.
void _flatSync(Ref ref) {
  ref.listen(flatChangesProvider, (_, next) {
    final change = next.value;
    if (change == null) return;
    switch (change.kind) {
      case FlatChangeKind.flat:
        // Mates joined/left, or a reconnect: refresh everything.
        ref.read(myFlatControllerProvider.notifier).refresh();
        ref.invalidate(choresControllerProvider);
        ref.invalidate(awaysControllerProvider);
        ref.invalidate(noticesControllerProvider);
        ref.invalidate(groceriesControllerProvider);
        ref.invalidate(calendarMonthProvider);
      case FlatChangeKind.chores:
        ref.read(choresControllerProvider.notifier).refresh();
        ref.invalidate(calendarMonthProvider);
      case FlatChangeKind.away:
        ref.read(awaysControllerProvider.notifier).refresh();
        ref.invalidate(calendarMonthProvider);
      case FlatChangeKind.events:
        ref.invalidate(calendarMonthProvider);
      case FlatChangeKind.notices:
        ref.read(noticesControllerProvider.notifier).refresh();
      case FlatChangeKind.groceries:
        ref.read(groceriesControllerProvider.notifier).refresh();
    }
  });
}

final flatSyncProvider = Provider.autoDispose<void>(_flatSync);
