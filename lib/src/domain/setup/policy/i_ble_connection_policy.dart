import '../proofs/ble_connection_proof.dart';

abstract class IBLEConnectionPolicy {
  /// Verifies the hardware connection to the smart brace/gadget.
  ///
  /// Takes a [device] (usually from a BLE plugin) and returns a
  /// [BLEConnectionProof] if the connection is stable enough for a session.
  Future<BLEConnectionProof> verifyConnection(dynamic device);
}
