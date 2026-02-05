import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';

class ConnectingState extends GadgetUIState {
  const ConnectingState()
    : super(
        text: 'Connecting...',
        color: Colors.blueGrey,
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      );
}
