import 'package:flutter/material.dart';

class StartRoundButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const StartRoundButton({super.key, required this.isEnabled, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 90,
      child: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 60,
            child: TextButton(
              // If isEnabled is true, use the passed function, else null to disable
              onPressed: isEnabled ? onPressed : null,
              style: TextButton.styleFrom(
                backgroundColor: isEnabled
                    ? const Color(0xFF2563EB) // Blue when active
                    : const Color(0xFFE5E7EB), // Grey when disabled
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Start Round',
                style: TextStyle(
                  color: isEnabled ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
