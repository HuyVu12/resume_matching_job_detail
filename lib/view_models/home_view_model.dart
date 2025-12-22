import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

class HomeViewModel extends ChangeNotifier {
  final JobService _jobService = JobService();

  List<JobModel> _jobs = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<JobModel> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadJobs() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _jobs = await _jobService.fetchJobs();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
