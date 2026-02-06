import 'package:flutter/material.dart';

class StartRoundButton extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading; // 🔥 ADD THIS
  final VoidCallback? onPressed;

  const StartRoundButton({
    super.key,
    required this.isEnabled,
    this.isLoading = false, // 🔥 ADD THIS
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the background color
    final Color buttonColor = isEnabled
        ? const Color.fromARGB(255, 0, 105, 150) // 🔵 Bright Blue (Ready)
        : const Color(
            0xFF38BDF8,
          ).withOpacity(0.4); // 🌫️ Dimmed Blue (Not Ready)

    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            disabledBackgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isEnabled ? 4 : 0,
          ),
          onPressed: onPressed,
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  "START ROUND",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isEnabled
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
        ),
      ),
    );
  }
}
