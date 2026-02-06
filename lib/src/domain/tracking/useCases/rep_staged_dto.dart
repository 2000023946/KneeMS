// lib/src/app/dtos/rep_staged_dto.dart

import 'package:mobile/src/domain/tracking/proofs/tracking_persistence_proofs.dart';

class RepStagedDTO {
  final bool isReady;
  final String message;
  final bool isError; // Useful for showing Red vs. Green UI alerts

  const RepStagedDTO({
    required this.isReady,
    required this.message,
    this.isError = false,
  });

  /// 🟢 SUCCESS: Hardware policy (4s hold) has been satisfied.
  factory RepStagedDTO.success(TrackingSavedPersistenceProof proof) {
    return const RepStagedDTO(
      isReady: true,
      message: "Rep completed! Tap to confirm.",
      isError: false,
    );
  }

  /// 🔴 FAILURE: The hold was broken or the session ended.
  factory RepStagedDTO.failure(String reason) {
    return RepStagedDTO(isReady: false, message: reason, isError: true);
  }

  /// 🟡 IDLE: Waiting for the user to start the movement.
  factory RepStagedDTO.idle() {
    return const RepStagedDTO(
      isReady: false,
      message: "Perform extension and hold...",
      isError: false,
    );
  }
}
