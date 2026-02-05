import 'package:mobile/src/domain/feedback/policies/i_feedback_persistence_policy.dart';
import 'package:mobile/src/domain/feedback/proofs/feedback_persistence_proofs.dart';
import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/domain/valueObjects/rep_count.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/setup_table.dart';

class InMemoryFeedbackAdapter extends IFeedbackPersistencePolicy {
  final SessionDataStore _store = SessionDataStore();

  @override
  Future<FeedbackInitializedProof> initializeFeedback(
    FeedbackStartedProof proof,
  ) async {
    // Save the initial state attributes (Comments might be null/empty initially)
    _store.putFeedbackComments(proof.state.comments ?? "");
    return FeedbackInitializedProof();
  }

  @override
  Future<RatingPersistedProof> saveRating(FeedbackCompletedProof proof) async {
    final int stars = proof.state.rating.value;
    _store.putFeedbackStars(stars);
    return RatingPersistedProof(stars);
  }

  @override
  Future<CommentsPersistenceProof> saveComments(
    ICommentUpdateableProof proof,
  ) async {
    final String text = proof.commentsUpdateableState.comment;
    _store.putFeedbackComments(text);
    final returnProof = CommentsPersistenceProof(persistedText: text);

    return returnProof;
  }

  ExerciseInProgressState _hydrateSession() {
    final legRaw = _store.getSetupLeg() ?? "Right"; // Fallback to safe default
    final deviceRaw = _store.getSetupDevice() ?? "00:00:00:00:00:00";
    final repsRaw = _store.getActiveRepCount() ?? 0;

    // Use the internal certificate to rebuild the state from persistence

    return ExerciseInProgressState.fromPersistence(
      LegChoice(legRaw),
      BLEDeviceAddress(deviceRaw),
      DateTime.now(),
      RepCount(repsRaw),
      getExerciseCertificate(),
    );
  }

  @override
  Future<FeedbackUpdateableFetchedProof> getUpdateableFeedback() async {
    final stars = _store.getFeedbackStars();
    final comments = _store.getFeedbackComments();

    // Note: In a real app, you'd also hydrate the exercise session data here.
    // For now, we assume the UI provides/maintains the session context.
    final exerciseSession = _hydrateSession();
    if (stars != null) {
      final stateProof = FullFeedbackState.fromComponents(
        exerciseSession,
        StarRating(stars),
        comments,
        getFeedbackCertificate(),
      );
      return FeedbackUpdateableFetchedProof(stateProof.state);
    } else {
      final state = PartialFeedbackState.fromPersistence(
        exerciseSession,
        comments,
        getPartialFeedbackCertificate(),
      );
      return FeedbackUpdateableFetchedProof(state);
    }
  }

  @override
  Future<FullFeedbackFetchedProof> getFinalizableFeedback() async {
    final stars = _store.getFeedbackStars();
    final comments = _store.getFeedbackComments();

    if (stars == null) {
      throw Exception(
        "Cannot fetch finalizable feedback: Rating missing in storage.",
      );
    }
    final exerciseSession = _hydrateSession();
    final stateProof = FullFeedbackState.fromComponents(
      exerciseSession,
      StarRating(stars),
      comments,
      getFeedbackCertificate(),
    );

    return FullFeedbackFetchedProof(stateProof.state);
  }

  @override
  Future<FeedbackClearedProof> clearFeedback() async {
    _store.clearFeedback();
    return FeedbackClearedProof();
  }
}
