import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/initial_state_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';
import 'package:mobile/src/domain/setup/states/ble_state.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';
import 'package:mobile/src/domain/setup/states/leg_choice_state.dart';
import 'package:mobile/src/domain/setup/states/start_state.dart';

import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/setup_table.dart';

class InMemorySetupAdapter extends IInitialStatePersistencePolicy {
  final SessionDataStore _table = SessionDataStore();

  // --- GETTERS (The State Decider) ---

  @override
  Future<LegStateFetchedProof> getOrCreateLegUpdateable() async {
    final leg = _table.getSetupLeg();
    final ble = _table.getSetupDevice();

    // 1. If both exist, return the Full State (it implements ILegUpdateable)
    if (leg != null && ble != null) {
      FullInitialStateCreatedProof proof =
          FullInitialSelectionState.fromComponents(
            LegChoice(leg),
            BLEDeviceAddress(ble),
            getInitialStateCertificate(),
          );
      return LegStateFetchedProof(proof.state);
    }

    // 2. If only leg exists, return Partial Leg State
    if (leg != null) {
      LegSelectionCreatedProof proof = LegSelectionState.create(
        LegChoice(leg),
        getLegSelectionCertificate(),
      );

      return LegStateFetchedProof(proof.state);
    }

    // 3. Fallback: return a blank LegSelectionState to start the flow
    return LegStateFetchedProof(StartingState());
  }

  @override
  Future<BLEStateFetchedProof> getOrCreateBLEUpdateable() async {
    final leg = _table.getSetupLeg();
    final ble = _table.getSetupDevice();

    // 1. If both exist, return Full State (it implements IBLEUpdateable)
    if (leg != null && ble != null) {
      FullInitialStateCreatedProof proof =
          FullInitialSelectionState.fromComponents(
            LegChoice(leg),
            BLEDeviceAddress(ble),
            getInitialStateCertificate(),
          );
      return BLEStateFetchedProof(proof.state);
    }

    // 2. If only BLE exists, return Partial BLE State
    if (ble != null) {
      // 1. Get the permit for this static call
      final cert = BLEConnectionCertificateManager.issueForPersistence(this);

      // 2. Call the guarded static rehydrate method
      final proof = BLEConnectionState.create(BLEDeviceAddress(ble), cert);
      return BLEStateFetchedProof(proof.state);
    }

    // 3. Fallback: return a blank BLEConnectionState
    return BLEStateFetchedProof(StartingState());
  }

  @override
  Future<InitialStateFetchedProof> getInitialState() async {
    final leg = _table.getSetupLeg();
    final device = _table.getSetupDevice();

    // THE GUARD: Throw error if anything is missing
    if (leg == null || device == null) {
      throw Exception(
        "Incomplete Setup Data: Found Leg=$leg, Device=$device. "
        "Cannot issue InitialStateFetchedProof.",
      );
    }

    // If we reach here, data is 100% present.
    final proofOfState = FullInitialSelectionState.fromComponents(
      LegChoice(leg),
      BLEDeviceAddress(device),
      getInitialStateCertificate(), // Using your existing cert logic
    );

    return InitialStateFetchedProof(proofOfState.state);
  }

  // --- SAVERS (The Atomic Overwriters) ---

  @override
  Future<LegPersistedProof> saveLeg(LegPersistenceProof proof) async {
    final String value = proof.leg.value; // Extracting primitive from VO

    // OVERWRITE
    _table.putLegChoice(value);

    return LegPersistedProof(value);
  }

  @override
  Future<ConnectionPersistedProof> saveConnection(
    BLEPersistenceProof proof,
  ) async {
    final String value = proof.address.address;

    // OVERWRITE
    _table.putDeviceAddress(value);

    return ConnectionPersistedProof(value);
  }

  @override
  Future<SetupClearedProof> clearSetup() async {
    // Execute the wipe
    _table.clearSetup();

    // Issue the Death Certificate
    return SetupClearedProof();
  }
}
