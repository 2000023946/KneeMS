import 'package:flutter/material.dart';

class GadgetInstructionText extends StatelessWidget {
  final String text;

  const GadgetInstructionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Colors.blueGrey.shade600,
        height: 1.3,
      ),
    );
  }
}
