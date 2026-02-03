import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/connect_gadget_card.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/legSelector/leg_selector_row.dart';

class SelectionSetupForm extends StatelessWidget {
  final String selectedLeg;
  final ValueChanged<String> onLegChanged;
  final ValueChanged<ConnectState> onGadgetStateChanged;

  const SelectionSetupForm({
    super.key,
    required this.selectedLeg,
    required this.onLegChanged,
    required this.onGadgetStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          LegSelectorRow(selectedLeg: selectedLeg, onChanged: onLegChanged),
          const SizedBox(height: 11),
          ConnectGadgetCard(onStateChanged: onGadgetStateChanged),
        ],
      ),
    );
  }
}
