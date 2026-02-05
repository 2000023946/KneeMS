import 'package:mobile/src/domain/models/history_persistence_proofs.dart';

abstract class IHistoryPersistencePolicy {
  /// Commits a newly created ExerciseModel to permanent storage.
  Future<ExerciseSavedProof> saveExercise(ExerciseModelCreatedProof proof);

  /// Retrieves the entire list of archived workouts.
  Future<ExerciseHistoryFetchedProof> fetchAllHistory();
}
