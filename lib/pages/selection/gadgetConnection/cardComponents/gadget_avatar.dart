import 'package:flutter/material.dart';

class GadgetAvatar extends StatelessWidget {
  final String imagePath;

  const GadgetAvatar({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(imagePath),
    );
  }
}
