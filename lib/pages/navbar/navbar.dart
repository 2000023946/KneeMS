import 'package:flutter/material.dart';

class KneeNavBar extends StatelessWidget implements PreferredSizeWidget {
  const KneeNavBar({super.key});

  @override
  // This defines the total height of your bar (Standard height + your 1px border)
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'KneeMS',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withAlpha(50), // Subtle border
          height: 1.0,
        ),
      ),
    );
  }
}
