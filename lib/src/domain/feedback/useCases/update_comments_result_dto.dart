import 'package:mobile/src/domain/feedback/proofs/feedback_state_proofs.dart';

import '../proofs/feedback_persistence_proofs.dart';
import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class UpdateCommentsResultDTO extends BaseResultDTO {
  final String? comments;
  final String message;

  UpdateCommentsResultDTO._({
    required this.comments,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY:
  /// Built when the Domain evolves AND the Persistence layer issues a receipt.
  factory UpdateCommentsResultDTO.success(
    ICommentUpdateable state,
    CommentsPersistenceProof proof,
  ) {
    return UpdateCommentsResultDTO._(
      comments: proof.persistedText,
      message: "Draft saved successfully (${proof.length} chars).",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY:
  /// Used if the database write fails or the state evolution is blocked.
  factory UpdateCommentsResultDTO.failure(String error) {
    return UpdateCommentsResultDTO._(
      comments: null,
      message: "Failed to sync comments: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
