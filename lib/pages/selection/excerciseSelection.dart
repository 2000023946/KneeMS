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
      // 🟢 Background color removed (defaults to Theme)
      appBar: const KneeNavBarBack(title: 'Setup Exercise'),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: api.stateStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};
          final String selectedLeg = data['leg'] ?? '';
          final bool isConnected = data['is_connected'] ?? false;
          final bool isConnecting = data['is_connecting'] ?? false;
          final bool isStarting = data['is_starting_exercise'] ?? false;

          final ConnectState status = isConnected
              ? ConnectState.connected
              : (isConnecting ? ConnectState.connecting : ConnectState.idle);

          final bool canStartRound =
              selectedLeg.isNotEmpty && isConnected && !isStarting;

          return SafeArea(
            child: Stack(
              children: [
                // 🟢 Padding removed: content is flush to edges
                SelectionSetupForm(
                  selectedLeg: selectedLeg,
                  gadgetStatus: status,
                  onLegChanged: (leg) => api.chooseLeg(leg),
                  onConnectRequested: () => api.connectBluetooth("DEVICE_ID"),
                ),

                StartRoundButton(
                  isEnabled: canStartRound,
                  onPressed: isStarting
                      ? null
                      : () async {
                          final result = await api.startExercise();

                          if (result['success']) {
                            AppNavigator.push(
                              context,
                              const GuidedTrackingPage(),
                            );
                          }
                        },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
