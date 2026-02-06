import 'package:mobile/src/domain/tracking/useCases/register_rep_result_dto.dart';

import '../policies/i_tracking_persistence_policy.dart';
import '../proofs/tracking_state_proofs.dart';

class RegisterRepUseCase {
  final ITrackingPersistencePolicy _persistence;

  RegisterRepUseCase(this._persistence);

  /// The final 'Commit' step: Increments the count and resets the staging flag.
  Future<RegisterRepResultDTO> execute() async {
    try {
      // 1. FETCH: Pull the current session from the persistence layer
      final hydration = await _persistence.getSavedProgress();
      final currentState = hydration.state;

      // 2. DOMAIN LOGIC: Call the logic guard we built in ExerciseInProgressState
      // This will either increment/reset-flag OR return the state unchanged if !isRepStaged
      final ExerciseStartedProof nextProof = currentState.incrementRep();

      // 3. VALIDATE: If the state didn't change, the increment was blocked by the guard
      if (nextProof.state == currentState) {
        return RegisterRepResultDTO.failure(
          "No rep was staged by the hardware hold.",
        );
      }

      // 4. PERSIST: Save the updated count and the 'false' staging flag to disk
      final saveReceipt = await _persistence.saveActiveTracking(nextProof);

      // 5. DTO: Return the success result for the UI/API
      return RegisterRepResultDTO.success(
        nextProof.state.reps.value, // The actual integer count
        saveReceipt,
      );
    } catch (e) {
      // Handle database errors or null state errors
      return RegisterRepResultDTO.failure(e.toString());
    }
  }
}
