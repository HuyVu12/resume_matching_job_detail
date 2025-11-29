import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/view_models/welcome/welcome_view_model.dart';
import 'package:resume_matching_jd/views/welcome/welcome_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => WelcomeViewModel(),
        child: WelcomeView(),
      ),
    );
  }
}
