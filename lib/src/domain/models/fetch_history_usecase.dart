import 'package:mobile/src/domain/models/fetch_history_dto.dart';
import 'package:mobile/src/domain/models/i_exercise_history_policy.dart';

class GetWorkoutHistoryUseCase {
  final IHistoryPersistencePolicy _historyPersistence;

  GetWorkoutHistoryUseCase(this._historyPersistence);

  Future<FetchHistoryResultDTO> execute() async {
    try {
      final historyProof = await _historyPersistence.fetchAllHistory();

      // Flatten the models into a UI-friendly list of maps
      final flattened = historyProof.history
          .map(
            (m) => {
              'reps': m.totalReps.value,
              'leg': m.legChoice.toString(),
              'date': m.startTime.toIso8601String(),
              'stars': m.rating?.value ?? 0,
              'comments': m.comments ?? "",
            },
          )
          .toList();

      return FetchHistoryResultDTO.success(flattened);
    } catch (e) {
      return FetchHistoryResultDTO.failure(e.toString());
    }
  }
}
