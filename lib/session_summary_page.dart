import 'package:flutter/material.dart';
// Make sure to import your feedback page file here
import 'package:mobile/session_feed_back_page.dart';

class SessionSummaryPage extends StatelessWidget {
  final int totalReps;

  const SessionSummaryPage({super.key, required this.totalReps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Trophy Icon Header
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFEFF6FF),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  color: Color(0xFF2563EB),
                  size: 50,
                ),
              ),
              const SizedBox(height: 24),

              // Title and Subtitle
              const Text(
                'Session Summary',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Great work! Confirm your results below.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              // Reps Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Text(
                      '$totalReps',
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const Text(
                      'TOTAL REPS',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Action Buttons
              Column(
                children: [
                  // Save & Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // NAVIGATION ADDED HERE
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SessionFeedbackPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text(
                        'Save & Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        shadowColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Redo Session Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.refresh, color: Colors.black54),
                      label: const Text(
                        'Redo Session',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFE2E8F0),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
