import 'package:flutter/material.dart';

class StatNumber extends StatelessWidget {
  final String number;

  const StatNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
