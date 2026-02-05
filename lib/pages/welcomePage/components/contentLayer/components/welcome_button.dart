import 'package:flutter/material.dart';
import 'package:mobile/pages/homes/home.dart';
import 'package:mobile/utils/app_navigator.dart';

class WelcomeGetStartedButton extends StatelessWidget {
  const WelcomeGetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: () =>
            AppNavigator.pushReplacement(context, const HomePage()),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF2563EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get Started',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
