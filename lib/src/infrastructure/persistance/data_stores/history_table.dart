import 'package:mobile/src/domain/models/exercise_record.dart';

class ExerciseHistoryStore {
  // --- SINGLETON SETUP ---
  static final ExerciseHistoryStore _instance =
      ExerciseHistoryStore._internal();
  ExerciseHistoryStore._internal();
  factory ExerciseHistoryStore() => _instance;

  /// The private encapsulated list of workout records.
  final List<ExerciseRecord> _history = [];

  /// Pushes a new record into the vault.
  void commit(ExerciseRecord record) {
    print('commint ${record.toMap()}');
    _history.add(record);
    print(
      '📂 HistoryStore: Record committed. Total entries: ${_history.length}',
    );
  }

  /// Retrieves all records.
  /// Returns an unmodifiable list to prevent external tampering.
  List<ExerciseRecord> fetchAll() {
    return List.unmodifiable(_history);
  }

  /// Provides the raw count of archived workouts.
  int get count => _history.length;

  /// Clears all history (Maintenance/System Reset).
  void clearAll() {
    _history.clear();
  }
}
