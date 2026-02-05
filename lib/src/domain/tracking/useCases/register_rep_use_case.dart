import 'package:mobile/src/domain/tracking/policies/i_ble_rep_tracking_policy.dart';
import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'register_rep_result_dto.dart';

class RegisterRepUseCase {
  final IBLERepTrackingPolicy _trackingPolicy;
  final ITrackingPersistencePolicy _persistence;

  RegisterRepUseCase(this._trackingPolicy, this._persistence);

  /// The Gatekeeper: Handles error boundaries and DTO mapping.
  Future<RegisterRepResultDTO> execute() async {
    try {
      // We return both the new count and the persistence witness
      final (newCount, saveProof) = await _performRepRegistration();
      return RegisterRepResultDTO.success(newCount, saveProof);
    } catch (e) {
      return RegisterRepResultDTO.failure(e.toString());
    }
  }

  /// The Logic: Orchestrates Sensor Verification and State Persistence.
  Future<(int, TrackingSavedPersistenceProof)> _performRepRegistration() async {
    // 1. Hydrate: Get the active session (State + History)
    final hydration = await _persistence.getSavedProgress();

    // 2. Sensor Policy: Await the specific 'Rep' event from the BLE hardware.
    // The policy ensures the 4-second hold or specific motion was met.
    final sensorWitness = await _trackingPolicy.trackReps().first;

    // 3. State Evolution: Evolve the state and issue a Domain Proof.
    // We use the incrementRep() method we built in ExerciseInProgressState.
    final domainProof = hydration.state.incrementRep(sensorWitness);

    // 4. Persistence: Commit the new state (with the +1 rep) to disk.
    final persistenceProof = await _persistence.saveActiveTracking(domainProof);

    // Return the new raw count and the persistence receipt
    return (domainProof.state.reps.value, persistenceProof);
  }
}
