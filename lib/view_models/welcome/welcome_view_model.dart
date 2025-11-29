import 'package:flutter/material.dart';
import 'package:resume_matching_jd/views/homepage/homepage_view.dart';

class WelcomeViewModel extends ChangeNotifier {
  bool loading = false;

  void onClickTraiNghiem(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageView()),
    );
  }
}
