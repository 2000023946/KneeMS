import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/home.dart';

class SessionFeedbackPage extends StatefulWidget {
  const SessionFeedbackPage({super.key});

  @override
  State<SessionFeedbackPage> createState() => _SessionFeedbackPageState();
}

class _SessionFeedbackPageState extends State<SessionFeedbackPage> {
  int _rating = 3; // Initial rating as per your screenshot
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Title and Subtitle
              const Text(
                'Session Complete',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'How is your knee feeling after this round?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              // Star Rating Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _rating = index + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        size: 48,
                        color: index < _rating
                            ? const Color(0xFFFFC107) // Yellow for selected
                            : const Color(0xFFE2E8F0), // Gray for unselected
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),

              // Pain Labels
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Low Pain',
                      style: TextStyle(color: Colors.black38, fontSize: 14),
                    ),
                    Text(
                      'High Pain',
                      style: TextStyle(color: Colors.black38, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Notes Input Field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes (Optional)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Any swelling or stiffness?',
                  hintStyle: const TextStyle(color: Colors.black26),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF2563EB),
                      width: 1.5,
                    ), // Blue border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF2563EB),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Submit Feedback Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // 1. Log or Save the data
                    print('Rating: $_rating, Notes: ${_notesController.text}');

                    // 2. Navigate to Home and clear the stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomePage(), // Ensure HomePage is imported
                      ),
                      (route) =>
                          false, // This condition removes all previous routes
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB), // Primary blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit Feedback',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
