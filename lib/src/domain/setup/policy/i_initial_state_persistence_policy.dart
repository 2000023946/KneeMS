import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';
import 'package:mobile/src/domain/setup/states/initial_state.dart';
import 'package:mobile/src/domain/setup/states/leg_choice_state.dart';

abstract class IInitialStatePersistencePolicy {
  // --- SAVERS ---
  Future<LegPersistedProof> saveLeg(LegPersistenceProof proof);
  Future<ConnectionPersistedProof> saveConnection(BLEPersistenceProof proof);

  // --- FETCHERS ---
  Future<LegStateFetchedProof> getOrCreateLegUpdateable();
  Future<BLEStateFetchedProof> getOrCreateBLEUpdateable();

  /// Fetches the current state of the setup process.
  /// Returns a witness containing the state (e.g. StartingState if empty).
  Future<InitialStateFetchedProof> getInitialState();

  /// Wipes the setup table.
  /// Returns a witness confirming the database is now clean.
  Future<SetupClearedProof> clearSetup();

  // --- CERTIFICATE HELPERS ---
  InitialStateCertificate getInitialStateCertificate() {
    return InitialStateCertificateManager.issueForPersistence(this);
  }

  LegSelectionCertificate getLegSelectionCertificate() {
    return LegSelectionCertificateManager.issueForPersistence(this);
  }
}
