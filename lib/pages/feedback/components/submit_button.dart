import 'package:flutter/material.dart';
import 'package:mobile/logic/active_session_provider.dart';
import 'package:mobile/logic/history_provider.dart';
import 'package:mobile/models/exercise_session.dart';
import 'package:mobile/pages/homes/home.dart';
import 'package:mobile/utils/action_buttons.dart';
import 'package:mobile/utils/app_navigator.dart';
import 'package:provider/provider.dart';

class SubmitFeedbackButton extends StatelessWidget {
  final VoidCallback? onSaveData;

  const SubmitFeedbackButton({super.key, this.onSaveData});

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(
      label: 'Submit Feedback',

      // Inside SubmitFeedbackButton build
      // lib/pages/feedback/components/submit_button.dart
      // lib/pages/feedback/components/submit_button.dart
      onPressed: () {
        final active = Provider.of<ActiveSessionProvider>(
          context,
          listen: false,
        );
        final history = Provider.of<HistoryProvider>(context, listen: false);

        final session = ExerciseSession(
          title: active.title,
          date: active.formattedDate, // This is now a clean string
          reps: active.reps,
          painRating: active.painRating,
        );

        history.addSession(session);
        AppNavigator.pushAndRemoveUntil(context, const HomePage());
      },
    );
  }
}
