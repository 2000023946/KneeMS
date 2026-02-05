import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'update_comments_result_dto.dart';

class UpdateCommentsUseCase {
  final IFeedbackPersistencePolicy _persistence;

  UpdateCommentsUseCase(this._persistence);

  /// Orchestrates the incremental update of session comments.
  Future<UpdateCommentsResultDTO> execute(String? newText) async {
    try {
      // 1. Hydrate: Recover the interface-bound state (Partial or Full)
      // This ensures we have access to the updateComments() method.
      final hydration = await _persistence.getUpdateableFeedback();
      // 2. Evolve: Perform the domain mutation.
      // Returns the ICommentUpdateableProof (the witness of the change).
      final evolutionProof = hydration.state.updateComments(newText ?? "");
      // 3. Persist: Commit the new text to the SessionDataStore.
      // Receives the CommentsPersistenceProof (the receipt of the write).
      final dbReceipt = await _persistence.saveComments(evolutionProof);
      // 4. Return: Map the successful evolution to the DTO.
      return UpdateCommentsResultDTO.success(hydration.state, dbReceipt);
    } catch (e) {
      // Handle potential hydration errors (e.g., if the session was purged)
      return UpdateCommentsResultDTO.failure(e.toString());
    }
  }
}
