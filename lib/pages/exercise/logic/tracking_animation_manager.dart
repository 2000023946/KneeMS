import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/logic/tracking_logic.dart';

class TrackingAnimationManager {
  late final AnimationController controller;
  final TrackingController logic;
  final VoidCallback onStateChange;

  TrackingAnimationManager({
    required TickerProvider vsync,
    required this.logic,
    required this.onStateChange,
  }) {
    // Initialize the controller and listener in the constructor
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 4),
    )..addStatusListener(_handleStatusChange);
  }

  void _handleStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      logic.currentState = TrackingState.review;
      onStateChange();
    }
  }

  void dispose() => controller.dispose();
}
