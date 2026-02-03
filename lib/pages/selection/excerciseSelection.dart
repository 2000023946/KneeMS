import 'package:flutter/material.dart';

class ExerciseSelectionPage extends StatelessWidget {
  const ExerciseSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Selection'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'This is the Exercise Selection Page',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
