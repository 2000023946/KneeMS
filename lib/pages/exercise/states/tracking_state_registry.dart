import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_logic.dart';
import 'package:mobile/pages/exercise/states/extending_state.dart';
import 'package:mobile/pages/exercise/states/review_state.dart';
import 'package:mobile/pages/exercise/states/tracking_start_state.dart';

class TrackingRegistry {
  static Widget getUI(
    TrackingState state, {
    required VoidCallback onStart,
    required VoidCallback onFinish,
    required VoidCallback onRedo,
    required VoidCallback onSave,
    required double currentProgress, // Added this parameter
  }) {
    switch (state) {
      case TrackingState.extending:
        return ExtendingUI(progress: currentProgress);
      case TrackingState.review:
        return ReviewUI(onRedo: onRedo, onSave: onSave);
      case TrackingState.idle:
        return StartUI(onStart: onStart, onFinish: onFinish);
    }
  }
}
