import 'package:flutter/material.dart';
import 'package:mobile/utils/action_buttons.dart';

class RedoSessionButton extends StatelessWidget {
  const RedoSessionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryActionButton(
      label: 'Redo Session',
      icon: const Icon(Icons.refresh, color: Colors.black54),
      isOutlined: true,
      onPressed: () => Navigator.pop(context),
    );
  }
}
