import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';
import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class RegisterRepResultDTO extends BaseResultDTO {
  final int count;
  final String message;

  RegisterRepResultDTO._({
    required this.count,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY:
  /// Created after the Persistence Layer confirms the rep was saved.
  factory RegisterRepResultDTO.success(
    int count,
    TrackingSavedPersistenceProof persistenceProof,
  ) {
    return RegisterRepResultDTO._(
      count: count,
      message: "Rep successfully recorded. Current total: $count",
      success: true,
      timestamp: persistenceProof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY:
  /// Used if the sensor data is invalid or database write fails.
  factory RegisterRepResultDTO.failure(String error) {
    return RegisterRepResultDTO._(
      count: 0, // Or return the last known count if available
      message: "Failed to record rep: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
