import 'package:flutter/material.dart';

class AppNavigator {
  /// Replaces the long Navigator.push block with a simple call
  static Future<void> push(BuildContext context, Widget targetPage) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  /// Use this for Welcome/Feedback screens to prevent going back
  static void pushReplacement(BuildContext context, Widget targetPage) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget targetPage) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
      (route) => false,
    );
  }
}
