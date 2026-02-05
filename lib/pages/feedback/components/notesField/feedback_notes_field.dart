import 'package:flutter/material.dart';
import 'package:mobile/pages/feedback/components/notesField/components/label.dart';
import 'package:mobile/pages/feedback/components/notesField/components/text_input.dart';

class FeedbackNotesField extends StatelessWidget {
  final TextEditingController controller;

  const FeedbackNotesField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FeedbackNotesLabel(),
        const SizedBox(height: 12),
        FeedbackTextInput(controller: controller),
      ],
    );
  }
}
