import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';

import '../states/exercise_state.dart';

abstract class ITrackingPersistencePolicy {
  /// PUSH / SAVE: Returns a receipt that the state is now on disk.
  Future<TrackingSavedPersistenceProof> saveActiveTracking(
    ExerciseStartedProof domainProof,
  );

  /// DELETE: Returns a receipt confirming the session is gone.
  Future<TrackingDeletedPersistenceProof> clearActiveTracking(
    TrackingAbortedProof abortProof,
  );

  /// The entry point from Setup (Atomic Launch).
  Future<dynamic> startNewSession(
    ExerciseInProgressState exerciseState,
  ) async {}

  /// The Hydrator: Pulls current progress from the database.
  /// Returns a 'TrackingHydrationProof' containing the live state.
  Future<TrackingHydrationProof> getSavedProgress();

  TrackingStateCertificate getTrackingStateCertificate() {
    return TrackingCertificateManager.issueForHydration(this);
  }
}
