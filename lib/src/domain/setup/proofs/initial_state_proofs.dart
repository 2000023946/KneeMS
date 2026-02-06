import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/states/ble_state.dart';
import 'package:mobile/src/domain/setup/states/leg_choice_state.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

import '../states/initial_state.dart';

/// Witness for the moment the "Full" state is born from two components.
class FullInitialStateCreatedProof extends DomainProof
    implements LegPersistenceProof, BLEPersistenceProof {
  final FullInitialSelectionState state;
  FullInitialStateCreatedProof(this.state);

  @override
  LegChoice get leg => state.selectedLeg;

  @override
  BLEDeviceAddress get address => state.connectedDevice;
}

class LegSelectionCreatedProof extends DomainProof
    implements LegPersistenceProof {
  final LegSelectionState state;

  LegSelectionCreatedProof(this.state);

  @override
  LegChoice get leg => state.selectedLeg;
}

class BLEConnectionCreatedProof extends DomainProof
    implements BLEPersistenceProof {
  final BLEConnectionState state;

  BLEConnectionCreatedProof(this.state);

  @override
  BLEDeviceAddress get address => state.connectedDevice;
}
