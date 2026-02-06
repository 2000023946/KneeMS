import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/useCases/finish_feedback_dto.dart';
import 'package:mobile/src/domain/models/exercise_model.dart';
import 'package:mobile/src/domain/models/i_exercise_history_policy.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/setup_table.dart';

class FinalizeWorkoutUseCase {
  final IFeedbackPersistencePolicy _feedbackPersistence;
  final IHistoryPersistencePolicy _historyPersistence;

  FinalizeWorkoutUseCase(this._feedbackPersistence, this._historyPersistence);

  /// The terminal action of the application lifecycle.
  /// Converts feedback into a permanent history record and wipes the session.
  Future<SaveFeedbackResultDTO> execute() async {
    try {
      // 1. HYDRATE: Recover the FullFeedbackState from the adapter.
      // This will throw if the state is still 'Partial' (missing stars).
      final hydration = await _feedbackPersistence.getFinalizableFeedback();
      final fullState = hydration.state;
      // 2. AUTHORIZE: Issue the certificate required to birth a permanent record.
      final cert = ExerciseModelCertificateManager.issueForArchival(fullState);

      // 3. EVOLVE: Witness the creation of the ExerciseModel.
      // This calculates the duration and finalizes the data.
      final modelProof = ExerciseModel.create(fullState, cert);

      // 4. PERSIST: Save the model to the long-term History Store.
      await _historyPersistence.saveExercise(modelProof);
      SessionDataStore().wipeAll();
      // 6. REPORT: Return the flattened DTO back to the UI.
      return SaveFeedbackResultDTO.success(modelProof.model);
    } catch (e) {
      // Handle missing data or persistence failures.
      return SaveFeedbackResultDTO.failure(e.toString());
    }
  }
}
