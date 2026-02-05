import 'package:flutter/material.dart';

class SummaryTrophyIcon extends StatelessWidget {
  const SummaryTrophyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xFFEFF6FF),
      child: Icon(
        Icons.emoji_events_outlined,
        color: Color(0xFF2563EB),
        size: 50,
      ),
    );
  }
}
