import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/card_container.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/connect_button.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/gadget_avatar.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/instruction_text.dart';
import 'package:mobile/pages/selection/gadgetConnection/cardComponents/selection_header.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/gadget_registry.dart'
    show GadgetRegistry;

class ConnectGadgetCard extends StatefulWidget {
  final void Function(ConnectState)? onStateChanged;

  const ConnectGadgetCard({super.key, this.onStateChanged});

  @override
  State<ConnectGadgetCard> createState() => _ConnectGadgetCardState();
}

class _ConnectGadgetCardState extends State<ConnectGadgetCard> {
  ConnectState _currentKey = ConnectState.idle;

  void _onButtonPressed() {
    if (_currentKey == ConnectState.idle) {
      _updateState(ConnectState.connecting);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) _updateState(ConnectState.connected);
      });
    }
  }

  void _updateState(ConnectState newState) {
    setState(() => _currentKey = newState);
    widget.onStateChanged?.call(newState);
  }

  @override
  Widget build(BuildContext context) {
    final uiState = GadgetRegistry.states[_currentKey]!;

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
                ConnectButton(uiState: uiState, onPressed: _onButtonPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
