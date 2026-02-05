import 'package:flutter/material.dart';

import '../states/connectionStates.dart';

class ConnectButton extends StatelessWidget {
  final GadgetUIState uiState;
  final VoidCallback onPressed;

  const ConnectButton({
    super.key,
    required this.uiState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
