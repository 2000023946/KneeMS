import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'base_dto.dart';

class StartExerciseResultDTO extends BaseResultDTO {
  final ExerciseInProgressState? activeState;
  final String startTimeFormatted;
  final String message;

  StartExerciseResultDTO._({
    this.activeState,
    required this.startTimeFormatted,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY:
  /// Built strictly from the ExerciseStartedProof (the witness of the launch).
  factory StartExerciseResultDTO.success(ExerciseStartedProof proof) {
    return StartExerciseResultDTO._(
      activeState: proof.state,
      startTimeFormatted: proof.state.startTime.toIso8601String(),
      message: "Session successfully promoted to Live Tracking.",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY:
  /// Handles incomplete setup, hardware disconnects, or persistence errors.
  factory StartExerciseResultDTO.failure(String error) {
    return StartExerciseResultDTO._(
      activeState: null,
      startTimeFormatted: 'N/A',
      message: "Launch Failed: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
