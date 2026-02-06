import 'package:mobile/src/domain/setup/policy/i_initial_state_persistence_policy.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';
import 'package:mobile/src/domain/setup/useCases/choose_leg_result_dto.dart';
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';

class ChooseLegUseCase {
  final IInitialStatePersistencePolicy _persistence;

  ChooseLegUseCase(this._persistence);

  /// The Gatekeeper: Handles error boundaries and DTO mapping.
  Future<ChooseLegResultDTO> execute(String rawLeg) async {
    try {
      final saveProof = await _performLegSelection(rawLeg);
      return ChooseLegResultDTO.success(saveProof);
    } catch (e) {
      return ChooseLegResultDTO.failure(e.toString());
    }
  }

  /// The Logic: The atomic steps of the "Overwrite" flow.
  Future<LegPersistedProof> _performLegSelection(String rawLeg) async {
    // 1. Domain Validation (Value Object)
    final choice = LegChoice(rawLeg);

    // 2. Hydrate/Create the Updater Interface
    final LegStateFetchedProof legUpdateableObject = await _persistence
        .getOrCreateLegUpdateable();

    // 3. State Evolution (Returns Creation Proof)
    final transitionProof = legUpdateableObject.state.updateLeg(choice);

    // 4. Persistence Commit (Overwrites SetupTable)
    return await _persistence.saveLeg(transitionProof);
  }
}
