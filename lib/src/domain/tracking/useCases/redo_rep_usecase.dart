import 'package:mobile/src/domain/tracking/useCases/register_rep_result_dto.dart';
import '../policies/i_tracking_persistence_policy.dart';
import '../proofs/tracking_state_proofs.dart';

class RedoRepUseCase {
  final ITrackingPersistencePolicy _persistence;

  RedoRepUseCase(this._persistence);

  /// The 'Reset' step: Flips the staging flag to false without incrementing count.
  Future<RegisterRepResultDTO> execute() async {
    try {
      // 1. FETCH: Pull current session from persistence
      final hydration = await _persistence.getSavedProgress();
      final currentState = hydration.state;

      // 2. DOMAIN LOGIC: Call the redo guard we just added to the state
      // This resets isRepStaged to false but leaves reps.value as is
      final ExerciseStartedProof nextProof = currentState.redoRep();

      // 3. VALIDATE: If state didn't change, nothing was staged to redo
      if (nextProof.state == currentState) {
        return RegisterRepResultDTO.failure(
          "No rep was currently staged to redo.",
        );
      }

      // 4. PERSIST: Save the state (count stays same, flag becomes false)
      final saveReceipt = await _persistence.saveActiveTracking(nextProof);

      // 5. DTO: Return success. The UI will see 'is_rep_staged' flip to false
      return RegisterRepResultDTO.success(
        nextProof.state.reps.value, // Count remains unchanged
        saveReceipt,
      );
    } catch (e) {
      return RegisterRepResultDTO.failure(e.toString());
    }
  }
}
