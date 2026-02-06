import 'package:mobile/src/domain/feedback/proofs/feedback_persistence_proofs.dart';
import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';

abstract class IFeedbackPersistencePolicy {
  // --- SAVERS ---
  Future<FeedbackInitializedProof> initializeFeedback(
    FeedbackStartedProof proof,
  );
  Future<RatingPersistedProof> saveRating(FeedbackCompletedProof proof);
  Future<CommentsPersistenceProof> saveComments(ICommentUpdateableProof proof);

  // Future<FeedbackArchivedProof> archiveFeedback(
  //   FullFeedbackFinalizedProof domainProof,
  // );

  // --- FETCHERS (The "Get" Methods) ---

  /// Recover any feedback state that allows comment updates.
  /// Used to populate the text field upon screen re-entry.
  Future<FeedbackUpdateableFetchedProof> getUpdateableFeedback();

  /// Recover a strictly FULL feedback state.
  /// Throws or returns an error proof if the rating is missing.
  Future<FullFeedbackFetchedProof> getFinalizableFeedback();

  // --- MAINTENANCE ---
  Future<FeedbackClearedProof> clearFeedback();

  FeedbackStateCertificate getFeedbackCertificate() {
    return FeedbackCertificateManager.issueForPersistence(this);
  }

  PartialFeedbackStateCertificate getPartialFeedbackCertificate() {
    return PartialFeedbackStateCertificateManager.issueForPersistence(this);
  }

  TrackingStateCertificate getExerciseCertificate() {
    return TrackingCertificateManager.issueForHydrationToFeedback(this);
  }
}
