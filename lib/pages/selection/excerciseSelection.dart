import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart';
import 'package:mobile/pages/exercise/guided_tracking_page.dart';
import 'package:mobile/pages/navbar/navbararrow.dart';
import 'package:mobile/pages/selection/components/start_round_button.dart';
import 'package:mobile/pages/selection/components/selection_form.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/utils/app_navigator.dart';

class ExerciseSelectionPage extends StatelessWidget {
  const ExerciseSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = AppApi();

    return Scaffold(
      appBar: const KneeNavBarBack(title: 'Setup Exercise'),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: api.stateStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};
          final String selectedLeg = data['leg'] ?? '';
          final bool isConnected = data['is_connected'] ?? false;
          final bool isConnecting = data['is_connecting'] ?? false;
          final bool isStarting = data['is_starting_exercise'] ?? false;

          // 🔥 NEW: Disable everything when ANY operation is in progress
          final bool isAnyOperationInProgress = isConnecting || isStarting;

          final ConnectState status = isConnected
              ? ConnectState.connected
              : (isConnecting ? ConnectState.connecting : ConnectState.idle);

          final bool canStartRound =
              selectedLeg.isNotEmpty && isConnected && !isStarting;

          return SafeArea(
            child: Stack(
              children: [
                // 🔥 Wrap form in AbsorbPointer to disable all interactions
                AbsorbPointer(
                  absorbing:
                      isAnyOperationInProgress, // Blocks all touches when true
                  child: Opacity(
                    opacity: isAnyOperationInProgress
                        ? 0.5
                        : 1.0, // Visual feedback
                    child: SelectionSetupForm(
                      selectedLeg: selectedLeg,
                      gadgetStatus: status,
                      onLegChanged: (leg) => api.chooseLeg(leg),
                      onConnectRequested: () =>
                          api.connectBluetooth("DEVICE_ID"),
                    ),
                  ),
                ),

                StartRoundButton(
                  isEnabled: canStartRound,
                  isLoading: isStarting,
                  onPressed: canStartRound
                      ? () async {
                          final result = await api.startExercise();

                          if (result['success']) {
                            AppNavigator.push(
                              context,
                              const GuidedTrackingPage(),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result['message'] ??
                                      'Failed to start exercise',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
