import 'package:flutter/material.dart';

class HistoryPainRating extends StatelessWidget {
  final int painRating;

  const HistoryPainRating({super.key, required this.painRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'PAIN RATING: ',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.1,
            fontWeight: FontWeight.bold,
            color: Colors.black26,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: List.generate(
            5,
            (index) => Icon(
              Icons.star,
              size: 18,
              color: index < painRating
                  ? const Color(0xFFFFC107)
                  : const Color(0xFFE2E8F0),
            ),
          ),
        ),
      ],
    );
  }
}
