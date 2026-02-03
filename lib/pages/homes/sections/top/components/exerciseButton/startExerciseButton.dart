import 'package:flutter/material.dart';
import 'components/start_button_style.dart';
import 'components/start_button_icon.dart';
import 'components/start_button_text.dart';
import 'components/start_button_logic.dart'; // import the logic

class StartExerciseButton extends StatelessWidget {
  final Widget destinationPage;
  final String label;
  final String iconPath;

  const StartExerciseButton({
    super.key,
    required this.destinationPage,
    this.label = 'Start Exercise',
    this.iconPath = 'assets/icons/play.svg',
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox.expand(
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            // Use the logic from the other file
            onPressed: StartButtonLogic.navigateToPage(
              context,
              destinationPage,
            ),
            style: StartButtonStyle.style,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StartButtonIcon(iconPath: iconPath),
                const SizedBox(width: 8),
                StartButtonText(label: label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
