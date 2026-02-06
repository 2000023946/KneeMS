import 'package:mobile/src/domain/tracking/states/exercise_state.dart';

abstract class PersistenceProof {
  final DateTime timestamp;

  PersistenceProof() : timestamp = DateTime.now();
}

/// Issued when saveActiveTracking succeeds.
class TrackingSavedPersistenceProof extends PersistenceProof {
  final int currentCount; // e.g., "REPS_UPDATED" or "SESSION_INITIALIZED"

  TrackingSavedPersistenceProof(this.currentCount);
}

/// Issued when clearActiveTracking succeeds.
/// This is the "Confirmation of Destruction" you requested.
class TrackingDeletedPersistenceProof extends PersistenceProof {
  final String sessionSummary; // Optional: last rep count before deletion

  TrackingDeletedPersistenceProof({required this.sessionSummary});
}

class TrackingHydrationProof extends PersistenceProof {
  final ExerciseInProgressState state;

  TrackingHydrationProof(this.state);
}
