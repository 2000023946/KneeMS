import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String actionLabel;

  const Header({
    super.key,
    this.title = 'Recent Progress',
    this.actionLabel = 'View All',
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(actionLabel, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
