import 'package:flutter/material.dart';
import '../states/connectionStates.dart';

class ConnectButton extends StatelessWidget {
  final GadgetUIState uiState;
  // 🟢 Changed to nullable so the button can be disabled
  final VoidCallback? onPressed;

  const ConnectButton({
    super.key,
    required this.uiState,
    this.onPressed, // 🟢 Removed 'required' if you want it to default to null
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        // Flutter automatically disables the button if onPressed is null
        onPressed: onPressed,
        icon: uiState.icon,
        label: Text(
          uiState.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: uiState.color,
          // 🟢 Optional: Add a disabled color so it looks right when locked
          disabledBackgroundColor: uiState.color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
