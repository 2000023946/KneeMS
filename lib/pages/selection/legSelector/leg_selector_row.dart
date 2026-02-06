import 'package:flutter/material.dart';
import 'legSelectorCard/legSelectorCard.dart';
import 'package:mobile/pages/selection/components/section_title.dart';

class LegSelectorRow extends StatelessWidget {
  final String selectedLeg; // "L", "R", or ''
  final ValueChanged<String> onChanged; // callback when a leg is selected

  const LegSelectorRow({
    super.key,
    required this.selectedLeg,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: '1. Which leg are you exercising?'),
          const SizedBox(height: 11),
          Expanded(
            child: Row(
              children: [
                LegSelectorCard(
                  side: 'L',
                  isSelected: selectedLeg == 'Left',
                  onTap: () => onChanged('L'),
                ),
                const SizedBox(width: 15),
                LegSelectorCard(
                  side: 'R',
                  isSelected: selectedLeg == 'Right',
                  onTap: () => onChanged('R'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
