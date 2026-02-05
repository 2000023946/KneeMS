import 'package:mobile/src/domain/models/exercise_model.dart';
import 'package:mobile/src/domain/models/exercise_record.dart';
import 'package:mobile/src/domain/models/history_persistence_proofs.dart';
import 'package:mobile/src/domain/models/i_exercise_history_policy.dart';

// Import domain Value Objects for rehydration
import 'package:mobile/src/domain/valueObjects/leg_choice.dart';
import 'package:mobile/src/domain/valueObjects/ble_device_address.dart';
import 'package:mobile/src/domain/valueObjects/rep_count.dart';
import 'package:mobile/src/domain/valueObjects/start_rating.dart';
import 'package:mobile/src/infrastructure/persistance/data_stores/history_table.dart';

class InMemoryHistoryAdapter implements IHistoryPersistencePolicy {
  final ExerciseHistoryStore _store = ExerciseHistoryStore();

  @override
  Future<ExerciseSavedProof> saveExercise(
    ExerciseModelCreatedProof proof,
  ) async {
    // 1. Convert the rich Domain Model into a persistable Record (Map wrapper)
    final record = ExerciseRecord.fromModel(proof.model);

    // 2. Commit to the Singleton List
    _store.commit(record);

    // 3. Return the receipt (Proof)
    return ExerciseSavedProof(
      persistedModel: proof.model,
      totalHistoryCount: _store.count,
    );
  }

  @override
  Future<ExerciseHistoryFetchedProof> fetchAllHistory() async {
    // 1. Fetch the encapsulated list of records
    final List<ExerciseRecord> records = _store.fetchAll();

    // 2. Obtain an authorized certificate to rehydrate raw maps back into Domain Models
    final cert = ExerciseModelCertificateManager.issueForHistoryFetch();

    // 3. Map the raw data back into rich ExerciseModel objects
    final List<ExerciseModel> domainModels = records.map((record) {
      final data = record.toMap();

      return ExerciseModel.fromPersistence(
        leg: LegChoice(data['leg_choice']),
        device: BLEDeviceAddress(data['device_address']),
        reps: RepCount(data['total_reps']),
        start: DateTime.parse(data['start_time']),
        end: DateTime.parse(data['end_time']),
        // Rating is nullable in history if the user skipped it
        rating: data['star_rating'] != null
            ? StarRating(data['star_rating'])
            : null,
        comments: data['comments'],
        cert: cert,
      );
    }).toList();

    // 4. Return the witness containing the full history list
    return ExerciseHistoryFetchedProof(domainModels);
  }
}
