import 'package:flutter/material.dart';

class FeedbackNotesLabel extends StatelessWidget {
  final String text;

  const FeedbackNotesLabel({super.key, this.text = 'Notes (Optional)'});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B), // Slate 800
      ),
    );
  }
}
