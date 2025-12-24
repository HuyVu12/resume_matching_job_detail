import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/company_model.dart';
import 'package:resume_matching_jd/models/job.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/services/company_service.dart';
import 'package:resume_matching_jd/services/job_service.dart';

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
    notifyListeners();
  }

  CompanyModel get_company(int index) {
    return _Companies[index - 1];
  }
}
