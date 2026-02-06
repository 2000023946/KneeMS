import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart'; // 🟢 Added API import
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
  final TextEditingController _notesController = TextEditingController();
  int _rating = 3;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // lib/pages/feedback/session_feed_back_page.dart
  @override
  Widget build(BuildContext context) {
    // Use the local final variable, but ensure AppApi is initialized
    final api = AppApi();

    return StreamBuilder<Map<String, dynamic>>(
      // Use the variable directly; if this fails, the Singleton definition in app_api.dart is the culprit
      stream: api.stateStream,
      builder: (context, snapshot) {
        // Always provide a fallback for the UI data
        final data = snapshot.data ?? {};

        print(data);

        return FeedbackPageLayout(
          children: [
            const SizedBox(height: 60),
            const FeedbackTitle(),
            const SizedBox(height: 12),
            const FeedbackSubtitle(),
            const SizedBox(height: 40),
            StarRatingSelector(
              rating: _rating,
              onRatingChanged: (val) async {
                await AppApi().updateRating(val);
                setState(() => _rating = val);
              },
            ),
            const SizedBox(height: 48),
            FeedbackNotesField(controller: _notesController),
            const Spacer(),
            SubmitFeedbackButton(
              onSaveData: () async {
                final res = await api.finalizeWorkout();

                if (context.mounted && res['success']) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
