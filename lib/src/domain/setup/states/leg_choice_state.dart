import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/ble_connection_proof.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/initial_state_proofs.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';
import 'package:mobile/src/domain/setup/states/start_state.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

class LegSelectionState implements ILegUpdateable {
  final LegChoice selectedLeg;

  LegSelectionState._(this.selectedLeg);

  /// PROMOTION FLOW: Merges with BLE to create the Full State tier.
  FullInitialStateCreatedProof connectBLE(BLEConnectionProof proof) {
    InitialStateCertificate certificate =
        InitialStateCertificateManager.issueForLeg(this);
    return FullInitialSelectionState.fromComponents(
      selectedLeg,
      proof.connectedDevice,
      certificate, // Using the VO from the proof directly
    );
  }

  @override
  LegPersistenceProof updateLeg(LegChoice choice) {
    final next = LegSelectionState._(choice);
    // We issue a witness that a new partial state was created.
    return LegSelectionCreatedProof(next);
  }

  static LegSelectionCreatedProof create(
    LegChoice legChoice,
    LegSelectionCertificate cert,
  ) {
    final state = LegSelectionState._(legChoice);
    return LegSelectionCreatedProof(state);
  }
}

/// The 'Token' that only this file knows about.
/// We use a sealed class so even within this file,
/// we know exactly what sub-types exist.
final class LegSelectionCertificate {
  LegSelectionCertificate._();
}

/// The AUTHORIZED 'Token Issuer'
abstract class LegSelectionCertificateManager {
  // New: A specific hatch for the Persistence layer (Adapter)
  static LegSelectionCertificate issueForPersistence(
    IInitialStatePersistencePolicy persistence,
  ) => LegSelectionCertificate._();

  static LegSelectionCertificate issueForStart(StartingState persistence) =>
      LegSelectionCertificate._();
}
