import 'package:flutter/material.dart';
import 'package:mobile/pages/sessionSummary/components/buttons/components/redo_session_button.dart';
import 'package:mobile/pages/sessionSummary/components/buttons/components/save_continue.dart';

class SummaryActionButtons extends StatelessWidget {
  const SummaryActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SaveContinueButton(),
        SizedBox(height: 16),
        RedoSessionButton(),
      ],
    );
  }
}
