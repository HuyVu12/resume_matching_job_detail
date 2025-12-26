import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/view_models/JDAI_view_model.dart';
import 'package:resume_matching_jd/view_models/home_view_model.dart';
import 'package:resume_matching_jd/view_models/job_detail_view_model.dart';
import 'package:resume_matching_jd/view_models/list_job_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';
import 'package:resume_matching_jd/view_models/welcome_view_model.dart';
import 'package:resume_matching_jd/views/welcome/welcome_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => JobDetailViewModel()),
        ChangeNotifierProvider(create: (context) => ListJobViewModel()),
        ChangeNotifierProvider(create: (context) => JobDetailViewModel()),
        ChangeNotifierProvider(create: (context) => JDAIViewModel()),
        ChangeNotifierProvider(
          create: (context) => SaveViewModel(),
          lazy: false,
        ),
      ],
      child: const MainApp(),
    ),
  );
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
      home: WelcomeView(),
    );
  }
}
