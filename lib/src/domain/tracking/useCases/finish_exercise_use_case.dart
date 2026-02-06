import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';

import 'package:mobile/src/domain/tracking/policies/i_tracking_persistence_policy.dart';
import 'package:mobile/src/domain/tracking/useCases/finish_exercise_result_dto.dart';

class FinishExerciseUseCase {
  final ITrackingPersistencePolicy _trackingPersistence;
  final IFeedbackPersistencePolicy _feedbackPersistence;

  FinishExerciseUseCase(this._trackingPersistence, this._feedbackPersistence);

  Future<ExerciseToFeedbackResultDTO> execute() async {
    try {
      // 1. Hydrate: Get the active session (The 'Witness' of the current progress)
      final sessionProof = await _trackingPersistence.getSavedProgress();
      final session = sessionProof.state;

      // 3. Evolve: The session itself produces the initial feedback proof
      final feedbackProof = session.transitionToFeedback();

      // 4. Persist: Commit the new feedback draft to the store
      await _feedbackPersistence.initializeFeedback(feedbackProof);

      // 5. Success: Return the DTO with the session receipt and new state
      return ExerciseToFeedbackResultDTO.success(
        feedbackProof.state,
        session.reps.value,
      );
    } catch (e) {
      return ExerciseToFeedbackResultDTO.failure(e.toString());
    }
  }
}
