import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';

class ConnectedState extends GadgetUIState {
  const ConnectedState()
    : super(
        text: 'Connected',
        color: Colors.green,
        icon: const Icon(Icons.check, color: Colors.white),
      );
}
