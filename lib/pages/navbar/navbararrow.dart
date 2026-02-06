import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart'; // Import your API
import 'navbar.dart';

class KneeNavBarBack extends KneeNavBar {
  const KneeNavBarBack({super.key, required super.title});

  @override
  Widget build(BuildContext context) {
    final AppApi api = AppApi(); // Access the singleton

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () async {
          // 1. Trigger the Domain Abort
          // This wipes the Persistence (Setup/Tracking tables)
          await api.abortExercise();

          // 2. Pop the page
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey.withAlpha(50)),
      ),
    );
  }
}
