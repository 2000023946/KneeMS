import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/legSelector/legSelectorCard/stylesSelectorCard.dart';
import 'package:mobile/pages/selection/legSelector/legSelectorCard/legSelectorCircle.dart';

// --- MAIN COMPONENT: LEG SELECTOR CARD ---
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
    // Initialize the theme logic based on selection state
    final theme = LegSelectorTheme(isSelected);
    final label = side.toUpperCase() == 'R' ? 'Right Leg' : 'Left Leg';

    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.borderColor, width: 2),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Call the circle sub-component
                LegSideCircle(side: side, theme: theme),
                const SizedBox(height: 8),
                // Label text
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.primaryText,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
