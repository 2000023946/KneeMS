import 'package:flutter/material.dart';

class SelectionHeader extends StatelessWidget {
  final String text;

  const SelectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A2130),
      ),
    );
  }
}
