import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartButtonIcon extends StatelessWidget {
  final String iconPath;
  const StartButtonIcon({super.key, this.iconPath = 'assets/icons/play.svg'});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
    );
  }
}
