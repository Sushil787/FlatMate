import 'package:serverpod/serverpod.dart';

import '../rotation/turn_service.dart';

/// Scheduled jobs that drive a Turn through its life: start, reminder, end.
class TurnCalls extends FutureCall {
  Future<void> started(Session session, int turnId) =>
      TurnService.onTurnStarted(session, turnId);

  Future<void> reminder(Session session, int turnId) =>
      TurnService.onTurnReminder(session, turnId);

  Future<void> ended(Session session, int turnId) =>
      TurnService.onTurnEnded(session, turnId);
}
