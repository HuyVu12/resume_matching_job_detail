import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/models/company_model.dart';
import 'package:resume_matching_jd/view_models/home_view_model.dart';
import 'package:resume_matching_jd/views/auth/login_view.dart';
import 'package:resume_matching_jd/views/auth/register_view.dart';
import 'package:resume_matching_jd/views/company_detail_view.dart';
import 'package:resume_matching_jd/views/homepage/homepage_view.dart';
import 'package:resume_matching_jd/views/job_detail_ai_view.dart';
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

  void navigateToCompanyDetailView(BuildContext context, CompanyModel company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyDetailView(company_detail: company),
      ),
    );
  }

  void navigateToRegisterView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterView()),
    );
  }

  void navigateToLoginView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  void navigateToJobDetailAiView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JobDetailAiView()),
    );
  }
}
