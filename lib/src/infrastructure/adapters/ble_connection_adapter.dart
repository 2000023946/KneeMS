import 'package:mobile/src/domain/setup/policy/i_ble_connection_policy.dart';
import 'package:mobile/src/domain/setup/proofs/ble_connection_proof.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';

class BLEConnectionAdapter implements IBLEConnectionPolicy {
  @override
  Future<BLEConnectionProof> verifyConnection(dynamic device) async {
    final String deviceId = device.toString();

    if (deviceId.isEmpty) {
      throw Exception("BLE_HARDWARE_ERROR: Invalid device address detected.");
    }
    final BLEDeviceAddress connectionDevice = BLEDeviceAddress(deviceId);
    // Now matches the positional constructor
    return BLEConnectionProof(connectionDevice);
  }
}
