// lib/pages/homes/sections/bottom/bottomSection.dart

import 'package:flutter/material.dart';
import 'package:mobile/src/app/app_api.dart';
import 'components/bottom_section_layout.dart';
import 'components/header.dart';
import 'components/recent_sessions_list.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSectionLayout(
      children: [
        const Header(),
        const SizedBox(height: 10),
        Flexible(
          flex: 4,
          child: FutureBuilder<Map<String, dynamic>>(
            future: AppApi().getHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final response = snapshot.data ?? {'success': false, 'data': []};
              final List rawData = response['data'] ?? [];
              print(rawData.take(2));
              if (rawData.isEmpty) {
                return const Center(
                  child: Text(
                    "No sessions yet",
                    style: TextStyle(color: Colors.white24),
                  ),
                );
              }

              // 🟢 Just pass the raw list of maps
              return RecentSessionsList(rawSessions: rawData.take(2).toList());
            },
          ),
        ),
      ],
    );
  }
}
