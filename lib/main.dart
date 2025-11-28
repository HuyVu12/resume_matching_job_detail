import 'package:flutter/material.dart';
import 'package:resume_matching_jd/views/welcome/welcome_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WelcomeView()
      ),
    );
  }
  
}
