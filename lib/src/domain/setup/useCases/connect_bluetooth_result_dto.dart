import 'base_dto.dart';
import '../proofs/persistence_proof.dart';

class ConnectBluetoothResultDTO extends BaseResultDTO {
  final String deviceAddress;
  final String message; // Hardware or persistence feedback

  ConnectBluetoothResultDTO._({
    required this.deviceAddress,
    required this.message,
    required bool success,
    required String timestamp,
  }) : super(success: success, timestamp: timestamp);

  /// SUCCESS FACTORY
  factory ConnectBluetoothResultDTO.success(ConnectionPersistedProof proof) {
    return ConnectBluetoothResultDTO._(
      deviceAddress: proof.deviceAddress,
      message: "Connected and persisted device: ${proof.deviceAddress}",
      success: true,
      timestamp: proof.timestamp.toIso8601String(),
    );
  }

  /// FAILURE FACTORY
  factory ConnectBluetoothResultDTO.failure(String error) {
    return ConnectBluetoothResultDTO._(
      deviceAddress: 'Not Connected',
      message: error,
      success: false,
      timestamp: DateTime.now().toIso8601String(),
    );
  }
}
