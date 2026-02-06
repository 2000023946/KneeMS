import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class SaveFeedbackResultDTO extends BaseResultDTO {
  // Extracted Primitives
  final int? totalReps;
  final String? legUsed;
  final String? deviceAddress;
  final String? startTime;
  final String? endTime;
  final int? starRating;
  final String? userComments;
  final String message;

  SaveFeedbackResultDTO._({
    required this.totalReps,
    required this.legUsed,
    required this.deviceAddress,
    required this.startTime,
    required this.endTime,
    required this.starRating,
    required this.userComments,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS: Extracts values from the model into flat primitives
  factory SaveFeedbackResultDTO.success(dynamic model) {
    return SaveFeedbackResultDTO._(
      totalReps: model.totalReps.value,
      legUsed: model.legChoice.toString(),
      deviceAddress: model.deviceAddress.address,
      startTime: model.startTime.toIso8601String(),
      endTime: model.endTime.toIso8601String(),
      starRating: model.rating?.value,
      userComments: model.comments,
      message: "Workout archived successfully.",
      success: true,
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  /// FAILURE: Nulls out content and provides the error
  factory SaveFeedbackResultDTO.failure(String error) {
    return SaveFeedbackResultDTO._(
      totalReps: null,
      legUsed: null,
      deviceAddress: null,
      startTime: null,
      endTime: null,
      starRating: null,
      userComments: null,
      message: "Archive failed: $error",
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
