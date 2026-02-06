abstract class BaseResultDTO {
  final bool success;
  final String timestamp;

  BaseResultDTO({required this.success, String? timestamp})
    : timestamp = timestamp ?? DateTime.now().toIso8601String();
}
