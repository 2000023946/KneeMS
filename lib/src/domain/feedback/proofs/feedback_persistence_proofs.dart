import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';
import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';

/// 1. Witness of Initialization
/// Confirms the active exercise data was successfully mapped into a feedback draft.
class FeedbackInitializedProof extends PersistenceProof {
  FeedbackInitializedProof();
}

/// 2. Witness of Rating Save
/// Confirms the StarRating is locked into the local database.
class RatingPersistedProof extends PersistenceProof {
  final int savedRating;
  RatingPersistedProof(this.savedRating);
}

/// 5. Witness of Destruction (The Death Certificate)
/// Confirms the feedback data has been purged after successful archival.
class FeedbackClearedProof extends PersistenceProof {
  final DateTime purgedAt;
  FeedbackClearedProof() : purgedAt = DateTime.now();
}

/// WITNESS 1: The Comment Update Proof
/// Carries any object that implements ICommentUpdateable.
class CommentsPersistenceProof extends PersistenceProof {
  /// The actual text that was saved (useful for verification).
  final String persistedText;

  /// The character count (useful for UI metadata/analytics).
  final int length;

  CommentsPersistenceProof({required this.persistedText})
    : length = persistedText.length,
      super();

  /// Helper to check if the persistence resulted in an empty string.
  bool get isCleared => persistedText.isEmpty;
}

class FeedbackUpdateableFetchedProof extends PersistenceProof {
  final FeedbackUpdateable state;
  FeedbackUpdateableFetchedProof(this.state);
}

/// Witness of a complete feedback fetch.
/// Guaranteed to contain stars and session data.
class FullFeedbackFetchedProof extends PersistenceProof {
  final FullFeedbackState state;
  FullFeedbackFetchedProof(this.state);
}
