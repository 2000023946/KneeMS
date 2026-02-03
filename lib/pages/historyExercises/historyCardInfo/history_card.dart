import 'package:flutter/material.dart';
import 'components/history_card_icon.dart';
import 'components/history_card_info.dart';
import 'components/history_pain_rating.dart';
import 'components/history_rep_badge.dart';
import 'components/history_card_layout.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final int reps;
  final int painRating;

  const HistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.reps,
    required this.painRating,
  });

  @override
  Widget build(BuildContext context) {
    return HistoryCardLayout(
      children: [
        Row(
          children: [
            HistoryCardIcon(isRightLeg: title.contains('Right')),
            const SizedBox(width: 16),
            HistoryCardInfo(title: title, date: date),
            const SizedBox(width: 8),
            HistoryRepBadge(reps: reps),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: Color(0xFFF1F5F9), thickness: 1),
        ),
        HistoryPainRating(painRating: painRating),
      ],
    );
  }
}
