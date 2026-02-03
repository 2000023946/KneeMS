import 'package:flutter/material.dart';
import 'package:mobile/pages/historyExercises/historyCardInfo/components/history_empty.dart';
import 'package:provider/provider.dart';
import 'package:mobile/logic/history_provider.dart';
import 'package:mobile/pages/historyExercises/historyCardInfo/history_card.dart';
import 'package:mobile/pages/navbar/navbar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Subscribe to the publisher
    final sessions = Provider.of<HistoryProvider>(context).sessions;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const KneeNavBar(title: 'History', showBack: true),
      body: sessions.isEmpty
          ? const HistoryEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                // reverse the list to show newest items at the top
                final session = sessions.reversed.toList()[index];

                return HistoryCard(
                  title: session.title,
                  date: session.date,
                  reps: session.reps,
                  painRating: session.painRating,
                );
              },
            ),
    );
  }
}
