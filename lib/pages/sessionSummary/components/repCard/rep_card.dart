import 'package:flutter/material.dart';
import 'package:mobile/pages/sessionSummary/components/repCard/components/card_container.dart';
import 'package:mobile/pages/sessionSummary/components/repCard/components/repCountDisplay.dart';
import 'package:mobile/pages/sessionSummary/components/repCard/components/total_reps_label.dart';

class RepsSummaryCard extends StatelessWidget {
  final int totalReps;

  const RepsSummaryCard({super.key, required this.totalReps});

  @override
  Widget build(BuildContext context) {
    return SummaryCardContainer(
      child: Column(
        children: [
          RepCountDisplay(count: totalReps),
          const TotalRepsLabel(),
        ],
      ),
    );
  }
}
