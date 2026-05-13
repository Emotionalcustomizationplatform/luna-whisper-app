import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LunaWhisperApp());
}

class LunaWhisperApp extends StatelessWidget {
  const LunaWhisperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luna Whisper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFc8b6ff),
        scaffoldBackgroundColor: const Color(0xFF0a0a1f),
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0a0a1f),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
