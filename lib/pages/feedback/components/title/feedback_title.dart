import 'package:flutter/material.dart';

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Session Complete',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }
}
