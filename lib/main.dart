import 'package:chat/pages/auth_or_app_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
          primaryColor: Color(0xFF4DD0E1),
          textTheme:
              const TextTheme(bodyLarge: TextStyle(color: Colors.white))),
      home: AuthOrAppPage(),
    );
  }
}
