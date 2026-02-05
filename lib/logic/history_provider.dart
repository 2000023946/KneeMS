import 'package:flutter/material.dart';
import '../domain/states/exercise_session.dart';

class HistoryProvider extends ChangeNotifier {
  // 1. Initialize an empty list of sessions
  final List<ExerciseSession> _sessions = [];

  // 2. Add the getter that BottomSection is looking for
  List<ExerciseSession> get sessions => List.unmodifiable(_sessions);

  // 3. Keep the convenience getter for the single most recent session
  ExerciseSession? get recentSession =>
      _sessions.isNotEmpty ? _sessions.last : null;

  // 4. Update the method to add to the list
  void addSession(ExerciseSession session) {
    _sessions.add(session);
    notifyListeners(); // Triggers the Home Page / BottomSection to refresh
  }
}
