import 'package:flutter/material.dart';

class LegSelectorCard extends StatelessWidget {
  final String side; // "L" or "R"
  final bool isSelected;
  final VoidCallback onTap;

  const LegSelectorCard({
    super.key,
    required this.side,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRight = side.toUpperCase() == 'R';
    final label = isRight ? 'Right Leg' : 'Left Leg';

    // Colors based on selected state
    final borderColor = isSelected
        ? Colors.blue.shade300
        : Colors.grey.shade300;
    final containerColor = isSelected
        ? Colors.blue.shade100
        : const Color(0xFFF5F3F3);
    final circleColor = isSelected
        ? Colors.blue.shade200
        : const Color(0xFFDAD1D1);
    final textColor = isSelected ? Colors.blue.shade700 : Colors.black;
    final letterColor = isSelected ? Colors.blue.shade700 : Colors.black;

    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Center(
            // Center the group of circle + label
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circle with letter
                SizedBox(
                  width: 52,
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        side.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1,
                          color: letterColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8), // spacing between circle and label
                // Label
                Text(label, style: TextStyle(fontSize: 16, color: textColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
