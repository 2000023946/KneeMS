import 'package:flutter/material.dart';
import 'app_decoration.dart';

class BottomSectionLayout extends StatelessWidget {
  final List<Widget> children;

  const BottomSectionLayout({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 4,
      child: Container(
        decoration: AppDecoration.blueCard,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: children),
        ),
      ),
    );
  }
}
