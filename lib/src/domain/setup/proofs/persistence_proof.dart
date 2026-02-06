import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';

/// The base receipt for any local storage action.
class PersistenceProof {
  final DateTime timestamp;
  PersistenceProof() : timestamp = DateTime.now();
}

/// Proof that the Leg Choice is safely written to the phone.
class LegPersistedProof extends PersistenceProof {
  final String legValue;
  LegPersistedProof(this.legValue);
}

/// Proof that the BLE Device is safely written to the phone.
class ConnectionPersistedProof extends PersistenceProof {
  final String deviceAddress;
  // ignore: annotate_overrides
  ConnectionPersistedProof(this.deviceAddress);
}

class LegStateFetchedProof extends PersistenceProof {
  final ILegUpdateable state;

  LegStateFetchedProof(this.state);
}

/// Witness that a BLEUpdateable state was successfully rehydrated
class BLEStateFetchedProof extends PersistenceProof {
  final IBLEUpdateable state;

  BLEStateFetchedProof(this.state);
}

class InitialStateFetchedProof extends DomainProof {
  final FullInitialSelectionState state;

  InitialStateFetchedProof(this.state);
}

class SetupClearedProof extends DomainProof {
  final DateTime clearedAt;

  SetupClearedProof() : clearedAt = DateTime.now(), super();
}
