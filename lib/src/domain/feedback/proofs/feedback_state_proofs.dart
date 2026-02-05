import 'package:mobile/src/domain/feedback/states/feedback_state.dart';
import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';

abstract class FeedbackProof
    implements ICommentUpdateableProof, IStarsUpdateableProof {}

class FeedbackStartedProof extends DomainProof implements FeedbackProof {
  final PartialFeedbackState state;

  FeedbackStartedProof(this.state) : super();

  @override
  ICommentUpdateable get commentsUpdateableState => state;

  @override
  IStarsUpdateable get starsUpdateableState => state;
}

/// The 'Validation Witness': Confirms that the mandatory
/// StarRating was provided and the summary is now 'Full'.
class FeedbackCompletedProof extends DomainProof
    implements ICommentUpdateableProof, IStarsUpdateableProof {
  final FullFeedbackState state;

  FeedbackCompletedProof(this.state) : super();

  @override
  ICommentUpdateable get commentsUpdateableState => state;

  @override
  IStarsUpdateable get starsUpdateableState => state;
}

class WorkoutFinalizedProof extends DomainProof {
  /// The complete data set (Session, Rating, and Comments).
  final FullFeedbackState finalData;

  /// The official completion timestamp.
  final DateTime completionTime;

  WorkoutFinalizedProof(this.finalData)
    : completionTime = DateTime.now(),
      super();
}

abstract class ICommentUpdateableProof {
  final ICommentUpdateable commentsUpdateableState;

  ICommentUpdateableProof({required this.commentsUpdateableState});
}

abstract class ICommentUpdateable {
  String get comment;

  /// The transition method that evolves the state with new text.
  ICommentUpdateableProof updateComments(String newText);
}

abstract class IStarsUpdateableProof {
  final IStarsUpdateable starsUpdateableState;

  IStarsUpdateableProof({required this.starsUpdateableState});
}

abstract class IStarsUpdateable {
  /// The transition method that evolves the state with new text.
  FeedbackCompletedProof updateRatings(StarRating rating);
}

abstract class FeedbackUpdateable
    implements IStarsUpdateable, ICommentUpdateable {}
