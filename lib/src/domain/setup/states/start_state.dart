import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/initial_state_proofs.dart';
import 'package:mobile/src/domain/setup/states/ble_state.dart';
import 'package:mobile/src/domain/setup/states/leg_choice_state.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

/// THE PIVOT: Zero attributes. 100% valid.
class StartingState implements ILegUpdateable, IBLEUpdateable {
  @override
  LegSelectionCreatedProof updateLeg(LegChoice choice) {
    // Transition from Nothing -> Leg
    LegSelectionCertificate cert = LegSelectionCertificateManager.issueForStart(
      this,
    );
    return LegSelectionState.create(choice, cert);
  }

  @override
  BLEConnectionCreatedProof updateBLE(BLEDeviceAddress address) {
    // Transition from Nothing -> BLE
    BLEConnectionCertificate cert =
        BLEConnectionCertificateManager.issueForStart(this);
    return BLEConnectionState.create(address, cert);
  }
}
