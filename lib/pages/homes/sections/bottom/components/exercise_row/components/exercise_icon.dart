import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExerciseIcon extends StatelessWidget {
  final String iconPath;

  const ExerciseIcon({super.key, this.iconPath = 'assets/icons/flow.svg'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color.fromARGB(153, 227, 226, 226),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 26,
          height: 26,
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(255, 68, 68, 68),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
