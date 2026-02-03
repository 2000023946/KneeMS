import 'package:flutter/material.dart';

class TopBoxDecoration {
  static const double borderRadiusValue = 16;

  static BoxDecoration blueCard = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(borderRadiusValue),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withValues(), // light gray shadow
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(1, 1), // shadow moves 1px right and 1px down
      ),
    ],
  );
}
