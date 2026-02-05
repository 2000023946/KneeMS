import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';

class FullFeedbackState implements FeedbackUpdateable {
  final ExerciseInProgressState sessionData; // Keep the lineage!
  final StarRating rating;
  final String? comments;

  // Constructor with named parameters
  FullFeedbackState._({
    required this.sessionData,
    required this.rating,
    this.comments,
  });

  /// Authorized static factory for rehydration or promotion
  static FeedbackCompletedProof fromComponents(
    ExerciseInProgressState session,
    StarRating rating,
    String? comments,
    FeedbackStateCertificate cert, // Requires authorization
  ) {
    final state = FullFeedbackState._(
      sessionData: session,
      rating: rating,
      comments: comments,
    );

    return FeedbackCompletedProof(state);
  }

  @override
  ICommentUpdateableProof updateComments(String newText) {
    // FIX: Use named parameter 'rating: rating'
    final state = FullFeedbackState._(
      sessionData: sessionData,
      rating: rating,
      comments: newText,
    );
    return FeedbackCompletedProof(state);
  }

  WorkoutFinalizedProof finalize() => WorkoutFinalizedProof(this);

  @override
  String get comment => comments ?? '';

  @override
  FeedbackCompletedProof updateRatings(StarRating rating) {
    final state = FullFeedbackState._(
      sessionData: sessionData,
      rating: rating,
      comments: comments,
    );
    return FeedbackCompletedProof(state);
  }
}

/// The 'Token' required to instantiate Feedback states.
final class FeedbackStateCertificate {
  FeedbackStateCertificate._();
}

/// The AUTHORIZED 'Token Issuer'
abstract class FeedbackCertificateManager {
  /// Allows the Tracking domain to transition to Feedback.
  static FeedbackStateCertificate issueForPartialFeedback(
    PartialFeedbackState state,
  ) => FeedbackStateCertificate._();

  static FeedbackStateCertificate issueForPersistence(
    IFeedbackPersistencePolicy state,
  ) => FeedbackStateCertificate._();
}
