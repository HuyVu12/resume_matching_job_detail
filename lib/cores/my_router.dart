import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/view_models/home_view_model.dart';
import 'package:resume_matching_jd/views/homepage/homepage_view.dart';
import 'package:resume_matching_jd/views/list_company_view.dart';
import 'package:resume_matching_jd/views/list_job_view.dart';

class MyRouter {
  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomepageView()),
    );
  }

  void navigateToJobList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListJobView()),
    );
  }

  void navigateToCompanyList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListCompanyView()),
    );
  }
}
