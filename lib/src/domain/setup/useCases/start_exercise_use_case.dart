import 'package:mobile/src/domain/setup/policy/i_ble_connection_policy.dart';
import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/useCases/start_exercise_result_dto.dart';
import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';

class StartExerciseUseCase {
  final IInitialStatePersistencePolicy _setupPersistence;
  final IBLEConnectionPolicy _bleHardware;
  final ITrackingPersistencePolicy _trackingPersistence;

  StartExerciseUseCase(
    this._setupPersistence,
    this._bleHardware,
    this._trackingPersistence,
  );

  /// The Gatekeeper: Wraps the atomic launch in a result DTO.
  Future<StartExerciseResultDTO> execute() async {
    try {
      final sessionProof = await _performLaunch();
      return StartExerciseResultDTO.success(sessionProof);
    } catch (e) {
      return StartExerciseResultDTO.failure(e.toString());
    }
  }

  /// The Launch Sequence: An atomic transformation of Setup -> Tracking.
  Future<ExerciseStartedProof> _performLaunch() async {
    // 1. Fetch Strict Initial State
    // This will THROW if the setup is incomplete, removing the need for 'is!' guards.
    final fetchProof = await _setupPersistence.getInitialState();
    final fullSetupState = fetchProof.state;

    // 2. Final Hardware Verification
    // Witness that the hardware is responsive before we kill the setup data.
    final connectionProof = await _bleHardware.verifyConnection(
      fullSetupState.connectedDevice,
    );

    // 3. Domain Evolution (Setup -> Tracking)
    // The state itself handles the creation of the ExerciseInProgressState.
    final exerciseState = fullSetupState.transitionToExercise(connectionProof);

    // 4. Persistence Handover (The "Atomic Swap")
    // We birth the tracking session first.
    final startProof = await _trackingPersistence.startNewSession(
      exerciseState.state,
    );

    // Once tracking is confirmed live, we issue the "Death Certificate" for setup.
    await _setupPersistence.clearSetup();

    return startProof;
  }
}
