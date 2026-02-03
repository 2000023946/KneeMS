import 'package:flutter/material.dart';
import 'components/buttons/action_buttons.dart';
import 'components/repCard/rep_card.dart';
import 'components/summaryTitle/title_group.dart';
import 'components/trophy_icon.dart';
import 'components/summary_page_layout.dart'; // New Import

class SessionSummaryPage extends StatelessWidget {
  final int totalReps;

  const SessionSummaryPage({super.key, required this.totalReps});

  @override
  Widget build(BuildContext context) {
    // Zero deep nesting - structural logic is now encapsulated
    return SummaryPageLayout(
      children: [
        const Spacer(flex: 2),
        const SummaryTrophyIcon(),
        const SizedBox(height: 24),
        const SummaryTitleGroup(),
        const SizedBox(height: 40),
        RepsSummaryCard(totalReps: totalReps),
        const Spacer(flex: 3),
        const SummaryActionButtons(),
        const SizedBox(height: 20),
      ],
    );
  }
}
