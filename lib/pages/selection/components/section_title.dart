import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20, // Slightly smaller
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A2130),
      ),
    );
  }
}
