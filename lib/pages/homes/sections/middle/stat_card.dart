import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/middle/components/stat_icon.dart';
import 'package:mobile/pages/homes/sections/middle/components/stat_number.dart';
import 'package:mobile/pages/homes/sections/middle/components/stat_label.dart';

class StatCard extends StatelessWidget {
  final String iconPath;
  final String number;
  final String label;
  final Color iconColor;

  const StatCard({
    super.key,
    required this.iconPath,
    required this.number,
    required this.label,
    this.iconColor = const Color.fromARGB(87, 89, 92, 255),
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              StatIcon(iconPath: iconPath, iconColor: iconColor),
              StatNumber(number: number),
              const SizedBox(height: 8),
              StatLabel(label: label),
            ],
          ),
        ),
      ),
    );
  }
}
