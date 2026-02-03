import 'package:flutter/material.dart';
import 'package:mobile/logic/active_session_provider.dart';
import 'package:mobile/pages/exercise/guided_tracking_page.dart';
import 'package:mobile/pages/navbar/navbararrow.dart';
import 'package:mobile/pages/selection/components/start_round_button.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/components/selection_form.dart';
import 'package:mobile/utils/app_navigator.dart';
import 'package:provider/provider.dart';

class ExerciseSelectionPage extends StatefulWidget {
  const ExerciseSelectionPage({super.key});

  @override
  State<ExerciseSelectionPage> createState() => _ExerciseSelectionPageState();
}

class _ExerciseSelectionPageState extends State<ExerciseSelectionPage> {
  String selectedLeg = '';
  ConnectState gadgetState = ConnectState.idle;

  bool get canStartRound =>
      selectedLeg != '' && gadgetState == ConnectState.connected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KneeNavBarBack(title: 'Setup Exercise'),
      body: Stack(
        children: [
          // 1. Setup Form Component
          SelectionSetupForm(
            selectedLeg: selectedLeg,
            onLegChanged: (leg) => setState(() => selectedLeg = leg),
            onGadgetStateChanged: (state) =>
                setState(() => gadgetState = state),
          ),

          // 2. Action Button Component
          StartRoundButton(
            isEnabled: canStartRound,
            onPressed: () {
              // Save the exercise choice to the scratchpad
              context.read<ActiveSessionProvider>().startSession(
                "Right Leg Extension",
              );
              AppNavigator.push(context, const GuidedTrackingPage());
            },
          ),
        ],
      ),
    );
  }
}
