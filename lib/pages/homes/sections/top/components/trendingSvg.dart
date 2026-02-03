import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingSvg extends StatelessWidget {
  const TrendingSvg({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -19,
      bottom: -35,
      child: SvgPicture.asset(
        'assets/icons/trending_up.svg',
        width: 150, // adjust size
        height: 150,
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(87, 89, 92, 255), // your fill color
          BlendMode.srcIn, // applies the color to both stroke & fill
        ),
      ),
    );
  }
}
