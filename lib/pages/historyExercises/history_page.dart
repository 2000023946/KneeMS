import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart';
import 'package:mobile/pages/historyExercises/historyCardInfo/components/history_empty.dart';
import 'package:mobile/pages/historyExercises/historyCardInfo/history_card.dart';
import 'package:mobile/pages/navbar/navbar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const KneeNavBar(title: 'History', showBack: true),
      body: FutureBuilder<Map<String, dynamic>>(
        // 🟢 Fetching raw data directly from the API
        future: AppApi().getHistory(),
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Extract Data Safely
          final response = snapshot.data ?? {'success': false, 'data': []};
          final List rawSessions = response['data'] ?? [];

          // 3. Empty State Check
          if (rawSessions.isEmpty) {
            return const HistoryEmptyState();
          }

          // 4. Build the List
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: rawSessions.length,
            itemBuilder: (context, index) {
              // Reverse the list to show newest items at the top
              final session = rawSessions.reversed.toList()[index];

              // 🟢 Map the raw Map keys to the HistoryCard fields
              return HistoryCard(
                title: "${session['leg'] ?? 'Unknown'} Leg Session",
                date: _formatDate(session['date'] ?? ''),
                reps: session['reps'] ?? 0,
                painRating: session['stars'] ?? 0, // Using stars as the metric
              );
            },
          );
        },
      ),
    );
  }

  /// Simple date formatter to keep raw ISO strings out of the UI
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
