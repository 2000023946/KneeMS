import 'package:flutter/material.dart';

class SummaryTitle extends StatelessWidget {
  final String text;

  const SummaryTitle({super.key, this.text = 'Session Summary'});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B), // Slate 800
      ),
    );
  }
}
