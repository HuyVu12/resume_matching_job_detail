import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/view_models/home_view_model.dart';
import 'package:resume_matching_jd/views/homepage/homepage_view.dart';

class WelcomeViewModel extends ChangeNotifier {
  bool loading = false;

  void onClickTraiNghiem(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
          child: HomepageView(),
        ),
      ),
    );
  }
}
