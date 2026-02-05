import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/ble_connection_proof.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/initial_state_proofs.dart';
import 'package:mobile/src/domain/setup/states/ble_state.dart';
import 'package:mobile/src/domain/setup/states/leg_choice_state.dart';
import 'package:mobile/src/domain/tracking/proofs/tracking_state_proofs.dart';
import 'package:mobile/src/domain/tracking/states/exercise_state.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

class FullInitialSelectionState implements ILegUpdateable, IBLEUpdateable {
  final LegChoice selectedLeg;
  final BLEDeviceAddress connectedDevice;

  // Private constructor ensures you can't bypass the components.
  FullInitialSelectionState._({
    required this.selectedLeg,
    required this.connectedDevice,
  });

  static FullInitialStateCreatedProof fromComponents(
    LegChoice leg,
    BLEDeviceAddress address,
    InitialStateCertificate cert,
  ) {
    final state = FullInitialSelectionState._(
      selectedLeg: leg,
      connectedDevice: address,
    );
    return FullInitialStateCreatedProof(state);
  }

  // If we update the leg here, we stay in the Full State.
  @override
  FullInitialStateCreatedProof updateLeg(LegChoice newChoice) {
    final newState = FullInitialSelectionState._(
      selectedLeg: newChoice,
      connectedDevice: connectedDevice,
    );

    // We issue the creation proof for the new object
    return FullInitialStateCreatedProof(newState);
  }

  @override
  FullInitialStateCreatedProof updateBLE(BLEDeviceAddress newAddress) {
    final newState = FullInitialSelectionState._(
      selectedLeg: selectedLeg,
      connectedDevice: newAddress,
    );

    // We issue a creation proof for the newly assembled object
    return FullInitialStateCreatedProof(newState);
  }

  /// The Final Transition: Now 100% Null-Safe.
  ExerciseStartedProof transitionToExercise(
    BLEConnectionProof currentConnection,
  ) {
    // The "if" is now a clean Value Object comparison
    currentConnection.verifyAgainst(connectedDevice);
    final cert = TrackingCertificateManager.issueForPromotion(this);
    return ExerciseInProgressState.create(selectedLeg, connectedDevice, cert);
  }
}

/// The 'Token' that only this file knows about.
/// We use a sealed class so even within this file,
/// we know exactly what sub-types exist.
final class InitialStateCertificate {
  InitialStateCertificate._();
}

/// The AUTHORIZED 'Token Issuer'
abstract class InitialStateCertificateManager {
  // We can track the origin if needed, or keep it generic
  static InitialStateCertificate issueForLeg(LegSelectionState state) =>
      InitialStateCertificate._();

  static InitialStateCertificate issueForBLE(BLEConnectionState state) =>
      InitialStateCertificate._();

  // New: A specific hatch for the Persistence layer (Adapter)
  static InitialStateCertificate issueForPersistence(
    IInitialStatePersistencePolicy persistence,
  ) => InitialStateCertificate._();
}
