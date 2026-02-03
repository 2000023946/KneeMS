import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/home.dart';
import 'package:mobile/utils/action_buttons.dart';
import 'package:mobile/utils/app_navigator.dart';

class SubmitFeedbackButton extends StatelessWidget {
  final VoidCallback? onSaveData;

  const SubmitFeedbackButton({super.key, this.onSaveData});

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(
      label: 'Submit Feedback',
      onPressed: () {
        onSaveData?.call(); //
        AppNavigator.pushAndRemoveUntil(context, const HomePage()); //
      },
    );
  }
}
