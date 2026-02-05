import '../states/feedback_state.dart';
import '../proofs/feedback_persistence_proofs.dart';
import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class UpdateRatingResultDTO extends BaseResultDTO {
  final FullFeedbackState? nextState;
  final int? rating;
  final String message;

  UpdateRatingResultDTO._({
    required this.nextState,
    required this.rating,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY:
  /// Built when the rating is validated and the persistence receipt is issued.
  factory UpdateRatingResultDTO.success(
    FullFeedbackState state,
    RatingPersistedProof proof,
  ) {
    return UpdateRatingResultDTO._(
      nextState: state,
      rating: proof.savedRating,
      message: "Rating of ${proof.savedRating} stars successfully recorded.",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY:
  /// Used if the rating value is out of bounds (Value Object error) or DB fails.
  factory UpdateRatingResultDTO.failure(String error) {
    return UpdateRatingResultDTO._(
      nextState: null,
      rating: null,
      message: "Failed to update rating: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
