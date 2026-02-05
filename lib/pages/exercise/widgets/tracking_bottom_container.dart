import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/states/tracking_state_registry.dart';
import 'package:mobile/pages/sessionSummary/session_summary_page.dart';

class TrackingBottomContainer extends StatelessWidget {
  final AnimationController controller;
  final TrackingController logic;
  final VoidCallback onRefresh; // To trigger setState in the parent

  const TrackingBottomContainer({
    super.key,
    required this.controller,
    required this.logic,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: TrackingRegistry.getUI(
            logic.currentState,
            currentProgress: controller.value,
            onStart: () => logic.startExercise(controller, onRefresh),
            onFinish: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SessionSummaryPage(totalReps: logic.repsCompleted),
              ),
            ),
            onRedo: () => logic.redoRep(controller, onRefresh),
            onSave: () => logic.saveRep(controller, onRefresh),
          ),
        );
      },
    );
  }
}
