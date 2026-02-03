import 'package:flutter/material.dart';
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
}
