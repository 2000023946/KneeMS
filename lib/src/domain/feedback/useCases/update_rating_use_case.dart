import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/useCases/update_rating_dto.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';

class UpdateRatingUseCase {
  final IFeedbackPersistencePolicy _persistence;

  UpdateRatingUseCase(this._persistence);

  /// Orchestrates the transition from Partial to Full feedback via star rating.
  Future<UpdateRatingResultDTO> execute(int stars) async {
    try {
      // 1. Hydrate: Recover the updateable interface (likely PartialFeedbackState)
      final hydration = await _persistence.getUpdateableFeedback();

      // 2. Evolve: Use the StarRating Value Object to validate input (1-5).
      // provideRating returns the FeedbackCompletedProof containing FullFeedbackState.
      final evolutionProof = hydration.state.updateRatings(StarRating(stars));

      // 3. Persist: Commit the validated rating to the SessionDataStore.
      final dbReceipt = await _persistence.saveRating(evolutionProof);

      // 4. Finalize: Return the DTO with the now 'Full' state.
      return UpdateRatingResultDTO.success(
        evolutionProof.state, // This is now strictly FullFeedbackState
        dbReceipt,
      );
    } catch (e) {
      // Catching StarRating validation errors or persistence failures
      return UpdateRatingResultDTO.failure(e.toString());
    }
  }
}
