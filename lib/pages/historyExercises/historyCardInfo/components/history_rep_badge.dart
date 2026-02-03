import 'package:flutter/material.dart';

class HistoryRepBadge extends StatelessWidget {
  final int reps;

  const HistoryRepBadge({super.key, required this.reps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$reps Reps',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF475569),
        ),
      ),
    );
  }
}
