import 'package:flutter/material.dart';

enum ConnectState { idle, connecting, connected }

// --- STATE BASE CLASS ---
/// Defines the properties that every state must provide
abstract class GadgetUIState {
  final String text;
  final Color color;
  final Widget icon;

  const GadgetUIState({
    required this.text,
    required this.color,
    required this.icon,
  });
}
