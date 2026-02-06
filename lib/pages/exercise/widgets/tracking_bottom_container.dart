import 'package:flutter/material.dart';
import 'package:mobile/pages/exercise/logic/tracking_controller.dart';
import 'package:mobile/pages/exercise/states/tracking_state_registry.dart';
import 'package:mobile/pages/sessionSummary/session_summary_page.dart';
import 'package:mobile/src/app/app_api.dart';

class TrackingBottomContainer extends StatefulWidget {
  final AnimationController controller;
  final TrackingController logic;
  final VoidCallback onRefresh;

  const TrackingBottomContainer({
    super.key,
    required this.controller,
    required this.logic,
    required this.onRefresh,
  });

  @override
  State<TrackingBottomContainer> createState() =>
      _TrackingBottomContainerState();
}

class _TrackingBottomContainerState extends State<TrackingBottomContainer> {
  final AppApi _api = AppApi();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _api.stateStream,
      builder: (context, snapshot) {
        // Get current state from stream (source of truth)
        final state = snapshot.data ?? {};
        final reps = state['reps'] ?? 0;
        final isConnected = state['is_connected'] ?? false;
        final isRepStaged = state['is_rep_staged'] ?? false;

        return AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: TrackingRegistry.getUI(
                widget.logic.currentState,
                currentProgress: widget.controller.value,

                onStart: () async {
                  // API first, then UI animation
                  final result = await _api.performRep();

                  if (result['success']) {
                    widget.logic.startExercise(
                      widget.controller,
                      widget.onRefresh,
                    );
                  } else {
                    _showError(
                      context,
                      result['message'] ?? 'Failed to start rep',
                    );
                  }
                },

                onFinish: () async {
                  final result = await _api.finishExercise();

                  if (result['success']) {
                    // Navigate using API state, not UI state
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionSummaryPage(
                          totalReps: reps, // From stream state
                        ),
                      ),
                    );
                  } else {
                    _showError(
                      context,
                      result['message'] ?? 'Failed to finish exercise',
                    );
                  }
                },

                onRedo: () async {
                  final result = await _api.redoRep();

                  if (result['success']) {
                    widget.logic.redoRep(widget.controller, widget.onRefresh);
                  } else {
                    _showError(
                      context,
                      result['message'] ?? 'Failed to redo rep',
                    );
                  }
                },

                onSave: () async {
                  final result = await _api.registerRep();

                  if (result['success']) {
                    widget.logic.saveRep(widget.controller, widget.onRefresh);
                  } else {
                    _showError(
                      context,
                      result['message'] ?? 'Failed to save rep',
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
