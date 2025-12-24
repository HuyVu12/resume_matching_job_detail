import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resume_matching_jd/models/job_model.dart';

class JDAIViewModel extends ChangeNotifier {
  PlatformFile? _pickedFile;
  bool _isAnalyzing = false;
  List<JobModel> _matchedJobs = [];

  // Getters
  PlatformFile? get pickedFile => _pickedFile;
  bool get isAnalyzing => _isAnalyzing;
  List<JobModel> get matchedJobs => _matchedJobs;
  String? get fileName => _pickedFile?.name;

  Future<void> pickCV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        _pickedFile = result.files.first;
        _matchedJobs = [];
        notifyListeners();
      } else {}
    } catch (e) {
      print("Lỗi chọn file: $e");
    }
  }

  void removeFile() {
    _pickedFile = null;
    _matchedJobs = [];
    notifyListeners();
  }

  Future<void> analyzeCV() async {
    if (_pickedFile == null) return;

    _isAnalyzing = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _matchedJobs = [];

    _isAnalyzing = false;
    notifyListeners();
  }
}
