import 'package:flutter/material.dart';

class SummarySubtitle extends StatelessWidget {
  final String text;

  const SummarySubtitle({
    super.key,
    this.text = 'Great work! Confirm your results below.',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54, // Subtle grey
      ),
    );
  }
}
