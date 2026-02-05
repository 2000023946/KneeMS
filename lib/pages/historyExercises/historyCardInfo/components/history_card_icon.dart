import 'package:flutter/material.dart';

class HistoryCardIcon extends StatelessWidget {
  final bool isRightLeg;

  const HistoryCardIcon({super.key, required this.isRightLeg});

  @override
  Widget build(BuildContext context) {
    final iconColor = isRightLeg
        ? const Color(0xFFEFF6FF)
        : const Color(0xFFF5F3FF);
    final pulseColor = isRightLeg
        ? const Color(0xFF2563EB)
        : const Color(0xFF8B5CF6);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.show_chart, color: pulseColor, size: 28),
    );
  }
}
