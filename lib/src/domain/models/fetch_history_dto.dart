import 'package:mobile/src/domain/setup/useCases/base_dto.dart';

class FetchHistoryResultDTO extends BaseResultDTO {
  final List<Map<String, dynamic>> workoutList;
  final String? errorMessage;

  FetchHistoryResultDTO._({
    required this.workoutList,
    required bool success,
    required String timestamp,
    this.errorMessage,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS: Returns the list of flattened workout records.
  factory FetchHistoryResultDTO.success(List<Map<String, dynamic>> list) {
    return FetchHistoryResultDTO._(
      workoutList: list,
      success: true,
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  /// FAILURE: Returns an empty list and the error message.
  factory FetchHistoryResultDTO.failure(String message) {
    return FetchHistoryResultDTO._(
      workoutList: [], // Prevent null-pointer exceptions in UI lists
      success: false,
      errorMessage: message,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
