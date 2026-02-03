import 'package:flutter/material.dart';

class ExtendingUI extends StatelessWidget {
  final double
  progress; // This value comes from the AnimationController (0.0 to 1.0)
  const ExtendingUI({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('extending'),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // The Status Header
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_outlined, color: Colors.white54, size: 20),
              SizedBox(width: 8),
              Text(
                "Extending...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // The Animated Blue Line (Fixed)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress, // This binds the blue line to the 4-second timer
              minHeight: 10,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Follow the animation",
            style: TextStyle(color: Colors.white24, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Keep your StartUI and ReviewUI classes in this file as well...
