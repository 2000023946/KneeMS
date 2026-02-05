import 'package:flutter/material.dart';

class SummaryPageLayout extends StatelessWidget {
  final List<Widget> children;

  const SummaryPageLayout({super.key, required this.children});

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
