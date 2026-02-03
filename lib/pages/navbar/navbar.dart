import 'package:flutter/material.dart';

class KneeNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const KneeNavBar({super.key, required this.title, this.showBack = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            )
          : null,
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
