import 'package:flutter/material.dart';
import 'package:mobile/pages/selection/legSelector/legSelectorCard/stylesSelectorCard.dart';

// --- SUB-COMPONENT: SIDE CIRCLE ---
class LegSideCircle extends StatelessWidget {
  final String side;
  final LegSelectorTheme theme;

  const LegSideCircle({super.key, required this.side, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.circleColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            side.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: 1,
              color: theme.primaryText,
            ),
          ),
        ),
      ),
    );
  }
}
