import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';

// --- 1. THE PARTIAL STATE (DRAFT) ---

class PartialFeedbackState implements FeedbackUpdateable {
  final ExerciseInProgressState sessionData;
  final String? comments;

  PartialFeedbackState._({required this.sessionData, this.comments});

  /// The only way to transition from an active Exercise to Feedback.
  static FeedbackStartedProof create(
    ExerciseInProgressState session,
    PartialFeedbackStateCertificate cert,
  ) {
    return FeedbackStartedProof(PartialFeedbackState._(sessionData: session));
  }

  /// Authorized Rehydration for the Persistence Adapter.
  static PartialFeedbackState fromPersistence(
    ExerciseInProgressState session,
    String? comments,
    PartialFeedbackStateCertificate cert,
  ) {
    return PartialFeedbackState._(sessionData: session, comments: comments);
  }

  @override
  ICommentUpdateableProof updateComments(String newText) {
    return FeedbackStartedProof(
      PartialFeedbackState._(sessionData: sessionData, comments: newText),
    );
  }

  @override
  String get comment => comments ?? '';

  @override
  FeedbackCompletedProof updateRatings(StarRating rating) {
    // We issue a promotion certificate to transition to the Full state.
    final cert = FeedbackCertificateManager.issueForPartialFeedback(this);
    return FullFeedbackState.fromComponents(
      sessionData,
      rating,
      comments,
      cert,
    );
  }
}

// --- 3. THE SECURITY LAYER (CERTIFICATES) ---

/// The 'Token' required to instantiate protected Feedback states.
final class PartialFeedbackStateCertificate {
  PartialFeedbackStateCertificate._();
}

/// The AUTHORIZED 'Token Issuer'
abstract class PartialFeedbackStateCertificateManager {
  /// Promotion from Active Session to Feedback.
  static PartialFeedbackStateCertificate issueForSessionEnd(
    ExerciseInProgressState state,
  ) => PartialFeedbackStateCertificate._();

  /// For use strictly by the IFeedbackPersistencePolicy implementations.
  static PartialFeedbackStateCertificate issueForPersistence(
    IFeedbackPersistencePolicy adapter,
  ) => PartialFeedbackStateCertificate._();
}
