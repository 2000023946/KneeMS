import 'package:flutter/material.dart';

class ExerciseInfo extends StatelessWidget {
  final String name;
  final String timestamp;

  const ExerciseInfo({super.key, required this.name, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 4),
        Text(timestamp, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
