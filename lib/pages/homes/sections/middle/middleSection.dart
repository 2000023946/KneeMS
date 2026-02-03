import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/middle/stat_card.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        children: const [
          StatCard(
            iconPath: 'assets/icons/award.svg',
            number: '4',
            label: 'Day Streak',
          ),
          SizedBox(width: 11),
          StatCard(
            iconPath: 'assets/icons/calendar.svg',
            number: '85',
            label: 'Goals Met',
          ),
        ],
      ),
    );
  }
}
