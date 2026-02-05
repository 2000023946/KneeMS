import 'package:flutter/material.dart';

class HistoryCardInfo extends StatelessWidget {
  final String title;
  final String date;

  const HistoryCardInfo({super.key, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: Colors.black38,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  date,
                  style: const TextStyle(color: Colors.black38, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
