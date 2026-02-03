import 'package:flutter/material.dart';

class WelcomeBranding extends StatelessWidget {
  const WelcomeBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'KneeMS',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Track your knee health,\nstay motivated.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white, height: 1.4),
        ),
      ],
    );
  }
}
