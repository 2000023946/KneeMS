import 'package:flutter/material.dart';
import 'package:mobile/pages/sessionSummary/components/summaryTitle/components/summary_subtitle.dart';
import 'package:mobile/pages/sessionSummary/components/summaryTitle/components/summary_title.dart';

class SummaryTitleGroup extends StatelessWidget {
  const SummaryTitleGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [SummaryTitle(), SizedBox(height: 12), SummarySubtitle()],
    );
  }
}
