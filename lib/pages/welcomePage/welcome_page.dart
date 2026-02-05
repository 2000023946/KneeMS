import 'package:flutter/material.dart';
import 'package:mobile/pages/welcomePage/components/welcome_background.dart';
import 'package:mobile/pages/welcomePage/components/contentLayer/welcome_content_layer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Prevents issues when the keyboard pops up elsewhere
      resizeToAvoidBottomInset: false,
      body: Stack(children: [WelcomeBackground(), WelcomeContentLayer()]),
    );
  }
}
