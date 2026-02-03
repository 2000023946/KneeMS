import 'package:flutter/material.dart';
import 'package:mobile/utils/action_buttons.dart';
import 'package:mobile/utils/app_navigator.dart';
import 'package:mobile/pages/feedback/session_feed_back_page.dart';

class SaveContinueButton extends StatelessWidget {
  const SaveContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(
      label: 'Save & Continue',
      icon: const Icon(Icons.check, color: Colors.white),
      onPressed: () => AppNavigator.push(context, const SessionFeedbackPage()),
    );
  }
}
