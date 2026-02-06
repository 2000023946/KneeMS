import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/connect_gadget_card.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/legSelector/leg_selector_row.dart';
// lib/pages/selection/components/selection_form.dart

class SelectionSetupForm extends StatelessWidget {
  final String selectedLeg;
  final ConnectState gadgetStatus; // Match the new Enum name
  final Function(String) onLegChanged;
  final VoidCallback onConnectRequested;

  const SelectionSetupForm({
    super.key,
    required this.selectedLeg,
    required this.gadgetStatus,
    required this.onLegChanged,
    required this.onConnectRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(11),
      child: Column(
        children: [
          // 1. Leg Selection
          LegSelectorRow(selectedLeg: selectedLeg, onChanged: onLegChanged),
          const SizedBox(height: 20),

          // 2. The fix for your error:
          ConnectGadgetCard(
            status: gadgetStatus, // Pass the status enum
            onConnectRequested: onConnectRequested, // Pass the API trigger
          ),
        ],
      ),
    );
  }
}
