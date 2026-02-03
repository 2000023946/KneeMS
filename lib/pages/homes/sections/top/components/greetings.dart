import 'package:flutter/material.dart';

class Greetings extends StatelessWidget {
  final String name; // you can make the greeting dynamic
  const Greetings({super.key, this.name = "User"});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox.expand(
        child: Text(
          "Hello, $name!",
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 31,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
