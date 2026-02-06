import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart';

class GuidedTrackingTopBar extends StatelessWidget {
  const GuidedTrackingTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: () async {
              await AppApi().abortExercise();
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: Center(
              child: Text(
                'GUIDED TRACKING',
                style: TextStyle(
                  color: Colors.white54,
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
