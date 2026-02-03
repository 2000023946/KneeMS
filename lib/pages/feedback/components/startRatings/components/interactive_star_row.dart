import 'package:flutter/material.dart';

class InteractiveStarRow extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const InteractiveStarRow({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isSelected = index < rating;
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              isSelected ? Icons.star : Icons.star_border,
              size: 48,
              color: isSelected
                  ? const Color(0xFFFFC107) // Amber
                  : const Color(0xFFE2E8F0), // Slate 200
            ),
          ),
        );
      }),
    );
  }
}
