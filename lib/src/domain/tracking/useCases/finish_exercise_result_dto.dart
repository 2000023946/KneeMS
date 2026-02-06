import 'package:mobile/src/domain/feedback/states/partial_feedback_state.dart';
import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class ExerciseToFeedbackResultDTO extends BaseResultDTO {
  final PartialFeedbackState? feedbackState;
  final int? finalRepCount;
  final String message;

  ExerciseToFeedbackResultDTO._({
    required this.feedbackState,
    required this.finalRepCount,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS: When the exercise is officially closed and feedback is birthed.
  factory ExerciseToFeedbackResultDTO.success(
    PartialFeedbackState state,
    int reps,
  ) {
    return ExerciseToFeedbackResultDTO._(
      feedbackState: state,
      finalRepCount: reps,
      message: "Exercise completed with $reps reps. Ready for feedback.",
      success: true,
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  /// FAILURE: Used if the session cannot be found or the transition is blocked.
  factory ExerciseToFeedbackResultDTO.failure(String error) {
    return ExerciseToFeedbackResultDTO._(
      feedbackState: null,
      finalRepCount: null,
      message: "Transition failed: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
