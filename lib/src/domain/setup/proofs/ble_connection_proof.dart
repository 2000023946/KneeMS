import 'package:mobile/src/domain/setup/exceptions/securityException.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';

class BLEConnectionProof extends DomainProof {
  // The proof now wraps the Value Object directly
  final BLEDeviceAddress connectedDevice;

  BLEConnectionProof(this.connectedDevice);

  /// The Gatekeeper
  /// Since both sides are now Value Objects, we just use the == operator.
  void verifyAgainst(BLEDeviceAddress stateAddress) {
    if (connectedDevice != stateAddress) {
      throw SecurityException(
        "PROOF_MISMATCH: The connected brace (${connectedDevice.address}) "
        "does not match the session brace (${stateAddress.address}).",
      );
    }
    // Logic continues only if they are equal
  }
}
