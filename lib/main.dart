import 'package:flutter/material.dart';
import 'package:mobile/logic/active_session_provider.dart';
import 'package:mobile/logic/history_provider.dart';
import 'package:mobile/pages/welcomePage/welcome_page.dart';
import 'package:provider/provider.dart'; // Add this

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // This helps mitigate issues with raw key data transitions on Web

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => ActiveSessionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
