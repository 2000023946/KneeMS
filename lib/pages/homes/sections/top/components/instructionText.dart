import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  final String text;
  const InstructionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: SizedBox.expand(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromARGB(179, 255, 247, 247),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
