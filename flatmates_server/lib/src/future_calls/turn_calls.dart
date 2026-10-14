import 'package:serverpod/serverpod.dart';

import '../rotation/turn_service.dart';

/// Scheduled jobs that drive a Turn through its life: start, reminder, the
/// Flat's evening pushes on its last day, and end.
class TurnCalls extends FutureCall {
  Future<void> started(Session session, UuidValue turnId) =>
      TurnService.onTurnStarted(session, turnId);

  Future<void> reminder(Session session, UuidValue turnId) =>
      TurnService.onTurnReminder(session, turnId);

  Future<void> matesNotDone(Session session, UuidValue turnId) =>
      TurnService.onMatesNotDone(session, turnId);

  Future<void> nightSummary(Session session, UuidValue turnId) =>
      TurnService.onNightSummary(session, turnId);

  Future<void> ended(Session session, UuidValue turnId) =>
      TurnService.onTurnEnded(session, turnId);
}
