import 'package:flutter/material.dart';

class RepCountDisplay extends StatelessWidget {
  final int count;
  const RepCountDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$count',
      style: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1E293B),
      ),
    );
  }
}
