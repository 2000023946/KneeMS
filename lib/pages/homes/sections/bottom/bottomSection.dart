import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/sections/bottom/components/no_recents.dart';
import 'package:provider/provider.dart';
import 'package:mobile/logic/history_provider.dart';
import 'components/bottom_section_layout.dart';
import 'components/header.dart';
import 'components/recent_sessions_list.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the data source
    final sessions = Provider.of<HistoryProvider>(context).sessions;

    // 2. Logic to get the last 2 sessions (newest first)
    final recentSessions = sessions.reversed.take(2).toList();

    return BottomSectionLayout(
      children: [
        const Header(),
        const SizedBox(height: 10),
        Flexible(
          flex: 4,
          child: recentSessions.isEmpty
              ? const RecentEmptyState() // Extracted Component
              : RecentSessionsList(
                  sessions: recentSessions,
                ), // Extracted Component
        ),
      ],
    );
  }
}
