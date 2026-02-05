import 'package:flutter/material.dart';

class TotalRepsLabel extends StatelessWidget {
  const TotalRepsLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'TOTAL REPS',
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
        color: Colors.black38,
      ),
    );
  }
}
