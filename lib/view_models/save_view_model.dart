import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/company_model.dart';
import 'package:resume_matching_jd/models/job.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/models/user_model.dart';
import 'package:resume_matching_jd/services/company_service.dart';
import 'package:resume_matching_jd/services/job_service.dart';
import 'package:resume_matching_jd/services/server_service.dart';

UserModel current_user = UserModel();
String link_sever_ai = "";

class SaveViewModel extends ChangeNotifier {
  List<CompanyModel> _Companies = [];
  List<CompanyModel> get Companies => _Companies;
  List<JobModel> _Jobs = [];
  List<JobModel> get Jobs => _Jobs;

  SaveViewModel() {
    load_data();
  }

  Future<void> load_data() async {
    _Companies = await CompanyService().fetchCompanies();
    _Jobs = await JobService().fetchJobs();
    link_sever_ai = await ServerService().fetchlink();
    notifyListeners();
  }

  CompanyModel get_company(int index) {
    return _Companies[index - 1];
  }

  List<JobModel> get_all_jobs_by_company_name(String company_name) {
    return _Jobs.where(
      (job) =>
          job.company_name.toLowerCase().contains(company_name.toLowerCase()),
    ).toList();
  }
}
