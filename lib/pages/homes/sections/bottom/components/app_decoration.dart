import 'package:flutter/material.dart';

class AppDecoration {
  static const double borderRadiusValue = 16;

  static BoxDecoration blueCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withValues(), // light gray shadow
        spreadRadius: 1, // small spread
        blurRadius: 1, // small blur
        offset: Offset(1, 1), // shadow moves 1px right and 1px down
      ),
    ],
  );
}
