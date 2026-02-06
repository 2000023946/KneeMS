import 'package:mobile/src/domain/models/exercise_model.dart';
import 'package:mobile/src/domain/setup/proofs/domain_proofs.dart';
import 'package:mobile/src/domain/setup/proofs/persistence_proof.dart';

/// Receipt: Confirms the global repository has successfully archived the session.
class ExerciseModelCreatedProof extends DomainProof {
  final ExerciseModel model;

  ExerciseModelCreatedProof(this.model) : super();
}

/// Witness that an individual workout was successfully saved to the database.
class ExerciseSavedProof extends PersistenceProof {
  final ExerciseModel persistedModel;
  final int totalHistoryCount;

  ExerciseSavedProof({
    required this.persistedModel,
    required this.totalHistoryCount,
  });
}

/// Witness that the full workout history was successfully fetched.
class ExerciseHistoryFetchedProof extends PersistenceProof {
  final List<ExerciseModel> history;

  ExerciseHistoryFetchedProof(this.history);
}
