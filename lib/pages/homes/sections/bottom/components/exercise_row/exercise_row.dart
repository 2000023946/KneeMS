import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/bottom/components/exercise_row/components/exercise_icon.dart';
import 'package:mobile/pages/homes/sections/bottom/components/exercise_row/components/exercise_info.dart';

class ExerciseRow extends StatelessWidget {
  final String name;
  final String timestamp;
  final String reps;
  final String iconPath;

  const ExerciseRow({
    super.key,
    required this.name,
    required this.timestamp,
    required this.reps,
    this.iconPath = 'assets/icons/flow.svg',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExerciseIcon(iconPath: iconPath),
              const SizedBox(width: 9),
              ExerciseInfo(name: name, timestamp: timestamp),
            ],
          ),
          Text(reps),
        ],
      ),
    );
  }
}
