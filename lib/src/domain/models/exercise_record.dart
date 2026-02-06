import 'package:mobile/src/domain/models/exercise_model.dart';

class ExerciseRecord {
  final Map<String, dynamic> _data;

  // Private constructor
  ExerciseRecord._(this._data);

  /// Factory that converts a Domain Model into a persistable Record.
  factory ExerciseRecord.fromModel(ExerciseModel model) {
    return ExerciseRecord._({
      'leg_choice': model.legChoice.value,
      'device_address': model.deviceAddress.address,
      'total_reps': model.totalReps.value,
      'start_time': model.startTime.toIso8601String(),
      'end_time': model.endTime.toIso8601String(),
      'star_rating': model.rating.value,
      'comments': model.comments,
      'duration_seconds': model.totalDuration.inSeconds,
    });
  }

  /// Exposes the raw map for the DataStore.
  Map<String, dynamic> toMap() => Map.unmodifiable(_data);
}
