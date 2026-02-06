import 'dart:async';
import 'package:mobile/src/app/app.dart';

class AppApi {
  static final AppApi _instance = AppApi._internal();
  factory AppApi() => _instance;

  final App _app = App();

  // The "Radio Station" for the UI
  final _stateController = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stateStream => _stateController.stream;

  AppApi._internal();

  /// Pushes the current state from persistence/domain to the stream
  void _refresh() {
    _stateController.add({
      'is_connected': _app.isBleConnected,
      'reps': _app.currentReps ?? 0,
      'leg': _app.currentLeg,
      'is_rep_staged': _app.isRepStaged,
      'stars': _app.getStars ?? 0,
      'comments': _app.getComments,
      'history': getHistory(),
    });
  }

  // --- 🏗️ SETUP API ---

  Future<Map<String, dynamic>> connectBluetooth(String address) async {
    _stateController.add({
      'is_connected': _app.isBleConnected,
      'reps': _app.currentReps ?? 0,
      'leg': _app.currentLeg,
      'is_rep_staged': _app.isRepStaged,
      'is_connecting': true,
    });
    final result = await _app.connectUseCase.execute(address);
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  Future<Map<String, dynamic>> chooseLeg(String leg) async {
    final result = await _app.chooseLegUseCase.execute(leg);
    _refresh();
    return {'success': result.success, 'choice': result.selectedLeg};
  }

  // --- 🏃‍♂️ TRACKING API ---

  Future<Map<String, dynamic>> startExercise() async {
    _stateController.add({
      'is_connected': _app.isBleConnected,
      'reps': _app.currentReps ?? 0,
      'leg': _app.currentLeg,
      'is_rep_staged': _app.isRepStaged,
      'is_starting_exercise': true,
    });
    final result = await _app.startUseCase.execute();
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  /// Wraps PerformRepUseCase (Staging)
  Future<Map<String, dynamic>> performRep() async {
    final result = await _app.performRepUseCase.execute();
    _refresh();
    return {'success': result.isReady, 'message': result.message};
  }

  Future<Map<String, dynamic>> redoRep() async {
    final result = await _app.redoRepUseCase.execute();
    _refresh();
    return {
      'success': result.success,
      'message': result.message,
      'current_count': result.count,
    };
  }

  /// Wraps RegisterRepUseCase (Confirming)
  Future<Map<String, dynamic>> registerRep() async {
    final result = await _app.registerRepUseCase.execute();
    _refresh();
    return {'success': result.success, 'new_count': result.count};
  }

  /// Wraps AbortExerciseUseCase
  Future<Map<String, dynamic>> abortExercise() async {
    final result = await _app.abortUseCase.execute();
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  /// Wraps FinishExerciseUseCase
  Future<Map<String, dynamic>> finishExercise() async {
    final result = await _app.finishExerciseUseCase.execute();
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  // --- ⭐ FEEDBACK & HISTORY API ---

  Future<Map<String, dynamic>> updateRating(int rating) async {
    final result = await _app.updateRatingUseCase.execute(rating);
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  Future<Map<String, dynamic>> updateComments(String comments) async {
    final result = await _app.updateCommentsUseCase.execute(comments);
    _refresh();
    return {'success': result.success, 'message': result.message};
  }

  Future<Map<String, dynamic>> finalizeWorkout() async {
    final result = await _app.finalizeUseCase.execute();
    _refresh();
    return {
      'success': result.success,
      'message': result.message,
      'totalReps': result.totalReps,
      'starRating': result.starRating,
    };
  }

  Future<Map<String, dynamic>> getHistory() async {
    final result = await _app.getHistoryUseCase.execute();
    return {
      'success': result.success,
      'data': result.workoutList,
      'count': result.workoutList.length,
      'error': result.errorMessage,
    };
  }

  void dispose() => _stateController.close();
}
