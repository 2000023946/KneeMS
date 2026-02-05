import 'package:flutter/material.dart';
import 'package:mobile/logic/active_session_provider.dart';
import 'package:mobile/pages/sessionSummary/session_summary_page.dart';
import 'package:mobile/utils/app_navigator.dart';
import 'package:provider/provider.dart';
import 'tracking_logic.dart';

class TrackingController {
  TrackingState currentState = TrackingState.idle;
  int repsCompleted = 0;

  // Logic for starting a rep
  void startExercise(AnimationController controller, Function updateUI) {
    currentState = TrackingState.extending;
    updateUI();
    controller.forward(from: 0.0);
  }

  // Logic for saving a rep
  void saveRep(AnimationController controller, Function updateUI) {
    repsCompleted++;
    currentState = TrackingState.idle;
    updateUI();
    controller.reset();
  }

  // Logic for redoing a rep
  void redoRep(AnimationController controller, Function updateUI) {
    currentState = TrackingState.idle;
    updateUI();
    controller.reset();
  }

  void finishExercise(BuildContext context) {
    // 1. Save the final count to the "Scratchpad" Provider
    context.read<ActiveSessionProvider>().updateReps(repsCompleted);

    // 2. Navigate to the Summary Page
    // Pass repsCompleted if your SummaryPage still requires it as a param,
    // though now it can just read from ActiveSessionProvider too!
    AppNavigator.push(context, SessionSummaryPage(totalReps: repsCompleted));
  }
}
