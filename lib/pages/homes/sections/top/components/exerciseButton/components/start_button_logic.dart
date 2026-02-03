import 'package:flutter/material.dart';

class StartButtonLogic {
  // Returns a function that navigates to the given page
  static VoidCallback navigateToPage(BuildContext context, Widget page) {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    };
  }
}
