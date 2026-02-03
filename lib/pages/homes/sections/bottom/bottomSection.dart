import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/bottom/components/app_decoration.dart';
import 'package:mobile/pages/homes/sections/bottom/components/header.dart';
import 'package:mobile/pages/homes/sections/bottom/components/exercise_row/exercise_row.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
        decoration: AppDecoration.blueCard,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Header(), // keeps the header
              Flexible(
                flex: 4,
                child: Column(
                  children: const [
                    ExerciseRow(
                      name: 'Knee Extension',
                      timestamp: 'Yesterday, 10:00 AM',
                      reps: '12 Reps',
                    ),
                    ExerciseRow(
                      name: 'Knee Extension',
                      timestamp: 'Yesterday, 10:00 AM',
                      reps: '12 Reps',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
