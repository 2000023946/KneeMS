import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class AbortExerciseResultDTO extends BaseResultDTO {
  final String message;

  AbortExerciseResultDTO._({
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY:
  /// Triggered once the Persistence Layer confirms the session is wiped.
  factory AbortExerciseResultDTO.success(
    TrackingDeletedPersistenceProof proof,
  ) {
    return AbortExerciseResultDTO._(
      message: "Session successfully aborted and cleared from storage.",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY:
  /// Triggered if the database fails to clear or the state is locked.
  factory AbortExerciseResultDTO.failure(String error) {
    return AbortExerciseResultDTO._(
      message: "Abort Failed: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
