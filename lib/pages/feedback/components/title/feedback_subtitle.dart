import 'package:flutter/material.dart';

class FeedbackSubtitle extends StatelessWidget {
  const FeedbackSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'How is your knee feeling after this round?',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }
}
