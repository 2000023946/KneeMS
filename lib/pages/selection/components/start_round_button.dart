import 'package:flutter/material.dart';

class StartRoundButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const StartRoundButton({super.key, required this.isEnabled, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // 1. Logic: Determine if we are waiting for hardware to initialize
    final bool isLoading = onPressed == null && isEnabled == false;

    // 2. Logic: Determine the background color
    // If it's ready to be clicked, we use the bright Sky Blue.
    // If it's disabled or loading, we dim it down.
    final Color buttonColor = isEnabled
        ? const Color.fromARGB(255, 0, 105, 150) // 🔵 Bright Blue (Ready)
        : const Color(
            0xFF38BDF8,
          ).withOpacity(0.4); // 🌫️ Dimmed Blue (Not Ready/Loading)

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
            // We use the same color for the disabled state to avoid sudden gray flashes
            disabledBackgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isEnabled ? 4 : 0, // Add a little shadow when it's ready
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
                    // White text only pops if the button is ready or loading
                    color: isEnabled || isLoading
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
        ),
      ),
    );
  }
}
