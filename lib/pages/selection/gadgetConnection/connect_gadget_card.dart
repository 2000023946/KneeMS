import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/card_container.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/connect_button.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/gadget_avatar.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/instruction_text.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/selection_header.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/gadget_registry.dart'
    show GadgetRegistry;

class ConnectGadgetCard extends StatelessWidget {
  // Now we take the status as a parameter from the Stream
  final ConnectState status;
  final VoidCallback onConnectRequested;

  const ConnectGadgetCard({
    super.key,
    required this.status,
    required this.onConnectRequested,
  });

  @override
  Widget build(BuildContext context) {
    // UI state is derived solely from the passed-in status
    final uiState = GadgetRegistry.states[status]!;

    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SelectionHeader(text: '2. Connect Gadget'),
          const SizedBox(height: 12),
          GadgetCardContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GadgetAvatar(
                  imagePath: 'assets/images/doctor_holding_tablet.png',
                ),
                const SizedBox(height: 16),
                const GadgetInstructionText(
                  text:
                      'Make sure your KneeMS device is turned on and strapped comfortably.',
                ),
                const SizedBox(height: 20),
                // Button just triggers the callback
                ConnectButton(
                  uiState: uiState,
                  onPressed: status == ConnectState.idle
                      ? onConnectRequested
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
