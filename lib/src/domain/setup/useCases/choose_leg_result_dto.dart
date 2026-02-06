import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';
import 'base_dto.dart';

class ChooseLegResultDTO extends BaseResultDTO {
  final String selectedLeg;
  final String message; // Clear feedback for the UI

  ChooseLegResultDTO._({
    required this.selectedLeg,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY
  factory ChooseLegResultDTO.success(LegPersistedProof proof) {
    return ChooseLegResultDTO._(
      selectedLeg: proof.legValue,
      message: "Leg selection '${proof.legValue}' successfully saved.",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY
  factory ChooseLegResultDTO.failure(String error) {
    return ChooseLegResultDTO._(
      selectedLeg: 'None',
      message: error,
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
