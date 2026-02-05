import 'package:flutter/material.dart';
import 'package:mobile/pages/feedback/components/startRatings/components/interactive_star_row.dart';
import 'package:mobile/pages/feedback/components/startRatings/components/ratings_range_label.dart';

class StarRatingSelector extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const StarRatingSelector({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InteractiveStarRow(rating: rating, onRatingChanged: onRatingChanged),
        const SizedBox(height: 8),
        const RatingRangeLabels(),
      ],
    );
  }
}
