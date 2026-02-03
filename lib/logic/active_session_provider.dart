import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this

class ActiveSessionProvider extends ChangeNotifier {
  String? _title;
  int _reps = 0;
  int _painRating = 0;
  String _notes = "";

  String get title => _title ?? "Leg Extension";
  int get reps => _reps;
  int get painRating => _painRating;

  void startSession(String title) {
    _title = title;
    _reps = 0;
    _painRating = 0;
    _notes = "";
    notifyListeners();
  }

  void updateReps(int count) {
    _reps = count;
    notifyListeners();
  }

  void updateFeedback(int rating, String notes) {
    _painRating = rating;
    _notes = notes;
    notifyListeners();
  }

  // FIXED: No more StackTrace/BuildContext mess.
  // This produces: "Tue, Feb 3, 4:15 PM"
  String get formattedDate =>
      DateFormat('E, MMM d, h:mm a').format(DateTime.now());
}
