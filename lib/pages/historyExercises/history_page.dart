import 'package:flutter/material.dart';
import 'package:mobile/pages/historyExercises/historyCardInfo/history_card.dart';
import 'package:mobile/pages/navbar/navbar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Single consistent array of data
  static const List<Map<String, dynamic>> _historyData = [
    {
      'title': 'Right Leg Extension',
      'date': 'Today, 10:00 AM',
      'reps': 12,
      'pain': 2,
    },
    {
      'title': 'Left Leg Extension',
      'date': 'Yesterday, 09:30 AM',
      'reps': 10,
      'pain': 1,
    },
    {
      'title': 'Right Leg Extension',
      'date': 'Mon, Feb 20, 4:15 PM',
      'reps': 15,
      'pain': 3,
    },
    {
      'title': 'Left Leg Extension',
      'date': 'Sun, Feb 19, 11:00 AM',
      'reps': 12,
      'pain': 2,
    },
    {
      'title': 'Right Leg Extension',
      'date': 'Sat, Feb 18, 10:00 AM',
      'reps': 8,
      'pain': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const KneeNavBar(title: 'History', showBack: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _historyData.length,
        itemBuilder: (context, index) {
          final item = _historyData[index];
          return HistoryCard(
            title: item['title'],
            date: item['date'],
            reps: item['reps'],
            painRating: item['pain'],
          );
        },
      ),
    );
  }
}
