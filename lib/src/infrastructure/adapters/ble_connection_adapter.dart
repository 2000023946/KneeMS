import 'package:mobile/src/domain/setup/policy/i_ble_connection_policy.dart';
import 'package:mobile/src/domain/setup/proofs/ble_connection_proof.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';

class BLEConnectionAdapter implements IBLEConnectionPolicy {
  @override
  Future<BLEConnectionProof> verifyConnection(dynamic device) async {
    // 1. Simulate Hardware Latency
    // This represents the time taken for the BLE handshake and GATT service discovery
    await Future.delayed(const Duration(seconds: 3));

    final String deviceId = device.toString();

    if (deviceId.isEmpty) {
      throw Exception("BLE_HARDWARE_ERROR: Invalid device address detected.");
    }

    final BLEDeviceAddress connectionDevice = BLEDeviceAddress(deviceId);

    // 2. Mint the Proof
    // In a real adapter, this only happens AFTER the hardware confirms the link is active
    return BLEConnectionProof(connectionDevice);
  }
}
