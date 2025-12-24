import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/job_model.dart';

class JobDetailViewModel extends ChangeNotifier {
  bool _isLoading = false;
  JobModel? _jobDetail;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  JobModel? get jobDetail => _jobDetail;
  String get errorMessage => _errorMessage;
}
