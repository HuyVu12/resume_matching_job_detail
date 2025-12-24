import 'package:flutter/material.dart';
import 'package:resume_matching_jd/cores/my_router.dart';

class WelcomeViewModel extends ChangeNotifier {
  bool loading = false;

  void onClickTraiNghiem(context) {
    MyRouter().navigateToHome(context);
  }
}
