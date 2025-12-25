import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:http/http.dart' as http;
import 'package:resume_matching_jd/services/server_service.dart';
import 'dart:convert';

import 'package:resume_matching_jd/view_models/save_view_model.dart';

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
    try {
      // var uri = Uri.parse(link_sever_ai + "/analyze-cv");
      String link_sever = await ServerService().fetchlink() + "/analyze-cv";
      var uri = Uri.parse(link_sever);

      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('file', _pickedFile!.path!),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final List<dynamic> jobsJson = json.decode(
          utf8.decode(response.bodyBytes),
        );
        _matchedJobs = jobsJson.map((json) => JobModel.fromJson(json)).toList();
      } else {
        print("Lỗi Server: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi kết nối: $e");
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }
}
