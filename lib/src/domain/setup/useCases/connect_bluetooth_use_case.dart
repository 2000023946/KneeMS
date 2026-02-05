import 'package:mobile/src/domain/setup/policy/i_ble_connection_policy.dart';
import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';
import 'package:mobile/src/domain/setup/useCases/connect_bluetooth_result_dto.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';

class ConnectBluetoothUseCase {
  final IBLEConnectionPolicy _hardware;
  final IInitialStatePersistencePolicy _persistence;

  ConnectBluetoothUseCase(this._hardware, this._persistence);

  /// The Gatekeeper: Wraps the domain transaction in a Result DTO.
  Future<ConnectBluetoothResultDTO> execute(String address) async {
    try {
      final saveProof = await _performBluetoothConnection(address);
      return ConnectBluetoothResultDTO.success(saveProof);
    } catch (e) {
      // In a real app, you might log the stacktrace here too.
      return ConnectBluetoothResultDTO.failure(e.toString());
    }
  }

  /// The Logic: Orchestrates Hardware Verification and Domain Evolution.
  Future<ConnectionPersistedProof> _performBluetoothConnection(
    String address,
  ) async {
    // 1. Hardware Verification (Returns Proof that device exists/responds)
    final connectionProof = await _hardware.verifyConnection(
      BLEDeviceAddress(address),
    );

    // 2. Hydrate the "Updateable" Interface from Persistence
    // Could be a StartingState or a LegSelectionState
    final fetchProof = await _persistence.getOrCreateBLEUpdateable();

    // 3. State Evolution (Polymorphic Transition)
    // StartingState -> BLEConnectionCreatedProof
    // LegSelectionState -> FullInitialStateCreatedProof
    final transitionProof = fetchProof.state.updateBLE(
      connectionProof.connectedDevice,
    );

    // 4. Persistence Commit
    return await _persistence.saveConnection(transitionProof);
  }
}
