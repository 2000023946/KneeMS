import 'package:flutter/material.dart';

// --- STYLING LOGIC ---
/// This class handles all the conditional logic for colors in one place.
class LegSelectorTheme {
  final bool isSelected;

  LegSelectorTheme(this.isSelected);

  Color get borderColor =>
      isSelected ? Colors.blue.shade300 : Colors.grey.shade300;

  Color get backgroundColor =>
      isSelected ? Colors.blue.shade100 : const Color(0xFFF5F3F3);

  Color get circleColor =>
      isSelected ? Colors.blue.shade200 : const Color(0xFFDAD1D1);

  Color get primaryText => isSelected ? Colors.blue.shade700 : Colors.black;
}
