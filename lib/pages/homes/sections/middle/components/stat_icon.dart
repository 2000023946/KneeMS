import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatIcon extends StatelessWidget {
  final String iconPath;
  final Color iconColor;

  const StatIcon({
    super.key,
    required this.iconPath,
    this.iconColor = const Color.fromARGB(87, 89, 92, 255),
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: SvgPicture.asset(
        iconPath,
        width: 150,
        height: 150,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}
