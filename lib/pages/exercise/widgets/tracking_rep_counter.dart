import 'package:flutter/material.dart';

class RepCounterDisplay extends StatelessWidget {
  final int count;
  const RepCounterDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        const Text(
          'REPS COMPLETED',
          style: TextStyle(
            color: Colors.white38,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
