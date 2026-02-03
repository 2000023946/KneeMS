import 'package:flutter/material.dart';
import 'package:mobile/models/exercise_session.dart';
import 'exercise_row/exercise_row.dart';

class RecentSessionsList extends StatelessWidget {
  final List<ExerciseSession> sessions;

  const RecentSessionsList({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sessions.map((session) {
        return ExerciseRow(
          name: session.title,
          timestamp: session.date,
          reps: '${session.reps} Reps',
        );
      }).toList(),
    );
  }
}
