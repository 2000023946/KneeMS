import 'package:flutter/material.dart';
import 'package:mobile/pages/feedback/components/notesField/feedback_notes_field.dart';
import 'package:mobile/pages/feedback/components/title/feedback_subtitle.dart';
import 'package:mobile/pages/feedback/components/title/feedback_title.dart';
import 'package:mobile/pages/feedback/components/page_layout.dart';
import 'package:mobile/pages/feedback/components/startRatings/star_rating_selector.dart';
import 'package:mobile/pages/feedback/components/submit_button.dart';

class SessionFeedbackPage extends StatefulWidget {
  const SessionFeedbackPage({super.key});

  @override
  State<SessionFeedbackPage> createState() => _SessionFeedbackPageState();
}

class _SessionFeedbackPageState extends State<SessionFeedbackPage> {
  int _rating = 3;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Zero deep nesting - just a clear list of components
    return FeedbackPageLayout(
      children: [
        const SizedBox(height: 60),
        const FeedbackTitle(),
        const SizedBox(height: 12),
        const FeedbackSubtitle(),
        const SizedBox(height: 40),
        StarRatingSelector(
          rating: _rating,
          onRatingChanged: (val) => setState(() => _rating = val),
        ),
        const SizedBox(height: 48),
        FeedbackNotesField(controller: _notesController),
        const Spacer(),
        SubmitFeedbackButton(
          onSaveData: () {
            debugPrint('Saving Rating: $_rating');
            debugPrint('Saving Notes: ${_notesController.text}');
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
