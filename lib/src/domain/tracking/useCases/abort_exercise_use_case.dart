import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'abort_exercise_result_dto.dart';

class AbortExerciseUseCase {
  final ITrackingPersistencePolicy _trackingPersistence;
  final IInitialStatePersistencePolicy _setupPersistence;

  AbortExerciseUseCase(this._trackingPersistence, this._setupPersistence);

  /// Orchestrates the regression from 'Tracking' back to 'Setup'.
  Future<AbortExerciseResultDTO> execute() async {
    try {
      final deleteProof = await _performAbort();
      return AbortExerciseResultDTO.success(deleteProof);
    } catch (e) {
      return AbortExerciseResultDTO.failure(e.toString());
    }
  }

  /// The Atomic Logic: Wipes tracking and resets the starting state.
  Future<TrackingDeletedPersistenceProof> _performAbort() async {
    // 1. Hydrate the active session from the Tracking DB
    final hydration = await _trackingPersistence.getSavedProgress();
    final currentState = hydration.state;

    // 2. State Termination: Issue the "Death Certificate"
    // No cert needed here as we are moving from "More Specific" to "Less Specific"
    final abortProof = currentState.abort();

    // 3. Persistence Cleanup: Physical purge of tracking data
    final clearedProof = await _trackingPersistence.clearActiveTracking(
      abortProof,
    );

    // 4. Setup Restoration: Reset the Setup Table to 'StartingState'
    // This ensures that when the user is sent back to the UI, the DB matches.
    await _setupPersistence.clearSetup();

    return clearedProof;
  }
}
