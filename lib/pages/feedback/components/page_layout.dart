import 'package:flutter/material.dart';

class FeedbackPageLayout extends StatelessWidget {
  final List<Widget> children;

  const FeedbackPageLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(children: children),
        ),
      ),
    );
  }
}
