import 'package:flutter/material.dart';
import 'package:is_it/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xffc3002f),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
        cardColor: const Color(0xffce355a),
        canvasColor: const Color(0xfff5f5f5),
      ),
      home: const HomeScreen(),
    );
  }
}
