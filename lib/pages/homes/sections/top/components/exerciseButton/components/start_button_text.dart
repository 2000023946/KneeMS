import 'package:flutter/material.dart';

class StartButtonText extends StatelessWidget {
  final String label;
  const StartButtonText({super.key, this.label = 'Start Exercise'});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
