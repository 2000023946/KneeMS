import 'package:flutter/material.dart';

class StatLabel extends StatelessWidget {
  final String label;

  const StatLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 190, 188, 188),
          ),
        ),
      ),
    );
  }
}
