import 'package:flutter/material.dart';

class RecentEmptyState extends StatelessWidget {
  const RecentEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No exercises yet. Start a session!",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
