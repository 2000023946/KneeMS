import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/states/tracking_state_registry.dart';
import 'package:mobile/pages/sessionSummary/session_summary_page.dart';
import 'package:mobile/src/app/app_api.dart';

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
            onStart: () async {
              logic.startExercise(controller, onRefresh);
              await AppApi().performRep();
            },
            onFinish: () async {
              final result = await AppApi().finishExercise();
              print(result);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SessionSummaryPage(totalReps: logic.repsCompleted),
                ),
              );
            },
            onRedo: () async {
              logic.redoRep(controller, onRefresh);
              await AppApi().redoRep();
            },
            onSave: () async {
              logic.saveRep(controller, onRefresh);
              await AppApi().registerRep();
            },
          ),
        );
      },
    );
  }
}
