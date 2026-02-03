import 'package:flutter/material.dart';

class StartButtonStyle {
  static ButtonStyle get style => TextButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );
}
