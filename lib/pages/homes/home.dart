import 'package:flutter/material.dart';
import 'package:mobile/pages/navbar/navbar.dart';
import 'package:mobile/pages/homes/sections/top/top.dart';
import 'package:mobile/pages/homes/sections/bottom/bottomSection.dart';
import 'package:mobile/pages/homes/sections/middle/middleSection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KneeNavBar(title: 'KneeMS'),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const TopSection(),

            const SizedBox(height: 12),

            const MiddleSection(),

            const SizedBox(height: 12),

            const BottomSection(),
          ],
        ),
      ),
    );
  }
}
