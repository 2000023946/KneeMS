import 'package:flutter/material.dart';
import 'package:mobile/utils/action_buttons.dart';

class SubmitFeedbackButton extends StatelessWidget {
  final VoidCallback onSaveData;

  // Fixed constructor syntax
  const SubmitFeedbackButton({super.key, required this.onSaveData});

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(label: 'Submit Feedback', onPressed: onSaveData);
  }
}
