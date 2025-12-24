import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/services/job_service.dart';

class ListJobViewModel extends ChangeNotifier {
  List<JobModel> Jobs = [];
  int filter_salary = 0; // 0: none, 1: low to high, 2: high to low
  String filter_job_type = ""; // e.g., "Full-time", "Part-time"
  String filter_location = "";
  String filter_company = "";
  String search_keyword = "";

  ListJobViewModel() {
    JobService().fetchJobs().then((fetchedJobs) {
      setJobs(fetchedJobs);
    });
  }
  void resetFilters() {
    filter_salary = 0;
    filter_job_type = "";
    filter_location = "";
    filter_company = "";
    search_keyword = "";
    notifyListeners();
    JobService().fetchJobs().then((fetchedJobs) {
      setJobs(fetchedJobs);
    });
  }

  void updateFilters({
    int? salary,
    String? jobType,
    String? location,
    String? company,
    String? keyword,
  }) {
    if (salary != null) filter_salary = salary;
    if (jobType != null) filter_job_type = jobType;
    if (location != null) filter_location = location;
    if (company != null) filter_company = company;
    if (keyword != null) search_keyword = keyword;
    notifyListeners();
    JobService()
        .fetchJobsByQuery(
          salaryFilter: filter_salary,
          jobType: filter_job_type.isNotEmpty ? filter_job_type : null,
          location: filter_location.isNotEmpty ? filter_location : null,
          keyword: search_keyword.isNotEmpty ? search_keyword : null,
        )
        .then((fetchedJobs) {
          setJobs(fetchedJobs);
        });
    notifyListeners();
  }

  void setJobs(List<JobModel> newJobs) {
    Jobs = newJobs;
    notifyListeners();
  }
}
