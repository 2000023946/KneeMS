import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/initial_state_proofs.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';
import 'package:mobile/src/domain/setup/states/start_state.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

class BLEConnectionState implements IBLEUpdateable {
  final BLEDeviceAddress connectedDevice;

  BLEConnectionState._(this.connectedDevice);

  /// PROMOTION: Merges with a Leg Choice to reach the Full State tier.
  FullInitialStateCreatedProof selectLeg(LegChoice choice) {
    InitialStateCertificate certificate =
        InitialStateCertificateManager.issueForBLE(this);
    return FullInitialSelectionState.fromComponents(
      choice,
      connectedDevice,
      certificate,
    );
  }

  @override
  BLEPersistenceProof updateBLE(BLEDeviceAddress address) {
    final state = BLEConnectionState._(address);
    return BLEConnectionCreatedProof(state);
  }

  static BLEConnectionCreatedProof create(
    BLEDeviceAddress bleDeviceAddress,
    BLEConnectionCertificate cert,
  ) {
    final state = BLEConnectionState._(bleDeviceAddress);

    // We return the Witness that this was successfully fetched
    return BLEConnectionCreatedProof(state);
  }
}

/// The PUBLIC TYPE for BLE-specific births
final class BLEConnectionCertificate {
  BLEConnectionCertificate._();
}

/// The AUTHORIZED 'Token Issuer' for BLE states
abstract class BLEConnectionCertificateManager {
  // Authorization for system-driven rehydration
  static BLEConnectionCertificate issueForPersistence(
    IInitialStatePersistencePolicy persistence,
  ) => BLEConnectionCertificate._();

  static BLEConnectionCertificate issueForStart(StartingState persistence) =>
      BLEConnectionCertificate._();
}
