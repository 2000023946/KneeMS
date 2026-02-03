import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/gadgetConnection/states/connectionStates.dart';

// --- CONCRETE STATE CLASSES ---
class IdleState extends GadgetUIState {
  const IdleState()
    : super(
        text: 'Connect Device',
        color: const Color(0xFF0F172A),
        icon: const Icon(Icons.bluetooth, color: Colors.white),
      );
}
