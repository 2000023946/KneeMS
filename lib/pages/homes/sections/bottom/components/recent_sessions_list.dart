// lib/pages/homes/sections/bottom/components/recent_sessions_list.dart

import 'package:flutter/material.dart';
import 'exercise_row/exercise_row.dart';

class RecentSessionsList extends StatelessWidget {
  // 🟢 Accept raw data instead of a Domain Model
  final List<dynamic> rawSessions;

  const RecentSessionsList({super.key, required this.rawSessions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: rawSessions.map((session) {
        // Extract values from the map keys defined in your AppApi/Persistence
        final String leg = session['leg'] ?? 'Unknown';
        final int reps = session['reps'] ?? 0;
        final String date = session['date'] ?? '';

        return ExerciseRow(
          name: "$leg Leg Session",
          timestamp: _formatDate(date),
          reps: "$reps Reps",
        );
      }).toList(),
    );
  }

  // Simple helper to keep the UI clean if you don't want raw ISO strings
  String _formatDate(String iso) {
    if (iso.isEmpty) return 'No Date';
    try {
      final dt = DateTime.parse(iso);
      return "${dt.month}/${dt.day}/${dt.year}";
    } catch (_) {
      return iso;
    }
  }
}
