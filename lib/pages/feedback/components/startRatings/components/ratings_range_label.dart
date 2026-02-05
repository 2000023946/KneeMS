import 'package:flutter/material.dart';

class RatingRangeLabels extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;

  const RatingRangeLabels({
    super.key,
    this.leftLabel = 'Low Pain',
    this.rightLabel = 'High Pain',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftLabel,
            style: const TextStyle(color: Colors.black38, fontSize: 14),
          ),
          Text(
            rightLabel,
            style: const TextStyle(color: Colors.black38, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
