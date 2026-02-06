import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/top/components/trendingSvg.dart';
import 'package:mobile/pages/selection/excerciseSelection.dart'; // import this at the top
import 'package:mobile/pages/homes/sections/top/components/topBoxDecoration.dart'; // import this at the top
import 'package:mobile/pages/homes/sections/top/components/greetings.dart';
import 'package:mobile/pages/homes/sections/top/components/instructionText.dart';
import 'package:mobile/pages/homes/sections/top/components/exerciseButton/startExerciseButton.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        decoration: TopBoxDecoration.blueCard,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(22), // padding for the whole column
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Greetings(name: "User"),
                  const InstructionText(
                    text:
                        "Do your knee extensions today to keep your streak alive.",
                  ),
                  StartExerciseButton(destinationPage: ExerciseSelectionPage()),
                ],
              ),
            ),
            const TrendingSvg(),
          ],
        ),
      ),
    );
  }
}
