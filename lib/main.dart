import 'package:flutter/material.dart';
import 'package:mobile/pages/welcomePage/welcome_page.dart';

void main() {
  // 🟢 Ensures Flutter is ready before we touch any platform channels or storage
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GE Research App',
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}
