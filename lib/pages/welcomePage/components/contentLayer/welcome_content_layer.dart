import 'package:flutter/material.dart';
import 'package:mobile/pages/welcomePage/components/contentLayer/components/welcome_branding.dart';
import 'package:mobile/pages/welcomePage/components/contentLayer/components/welcome_button.dart';
import 'package:mobile/pages/welcomePage/components/contentLayer/components/welcome_logo.dart';

class WelcomeContentLayer extends StatelessWidget {
  const WelcomeContentLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            Spacer(),
            WelcomeLogo(),
            SizedBox(height: 32),
            WelcomeBranding(),
            Spacer(),
            WelcomeGetStartedButton(),
          ],
        ),
      ),
    );
  }
}
