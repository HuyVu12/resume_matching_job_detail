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
  bool _isAnalyzingDetail = false;
  Map<String, dynamic>? _detailAnalysisResult;
  String? _errorMessage = '';

  // Getters
  PlatformFile? get pickedFile => _pickedFile;
  bool get isAnalyzing => _isAnalyzing;
  List<JobModel> get matchedJobs => _matchedJobs;
  String? get fileName => _pickedFile?.name;
  String? get errorMessage => _errorMessage;

  bool get isAnalyzingDetail => _isAnalyzingDetail;
  Map<String, dynamic>? get detailAnalysisResult => _detailAnalysisResult;

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
        _errorMessage = "Lỗi Server: ${response.statusCode}";
        print("Lỗi Server: ${response.statusCode}");
      }
    } catch (e) {
      _errorMessage = "Lỗi kết nối: $e";
      print("Lỗi kết nối: $e");
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  Future<void> analyzeJobDetail(JobModel job) async {
    if (_pickedFile == null) {
      notifyListeners();
      return;
    }

    _isAnalyzingDetail = true;
    _detailAnalysisResult = null;
    notifyListeners();

    try {
      String link_server =
          await ServerService().fetchlink() + "/analyze-match-detail";
      var uri = Uri.parse(link_server);

      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('file', _pickedFile!.path!),
      );

      request.fields['job_id'] = (job.id ?? "").toString();
      request.fields['job_title'] = job.title;
      request.fields['job_requirements'] = job.requirements ?? "";
      request.fields['job_description'] = job.description ?? "";
      request.fields['match_score'] = (job.match_score ?? 0).toString();

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final decoded = json.decode(utf8.decode(response.bodyBytes));

        if (decoded is Map) {
          _detailAnalysisResult = Map<String, dynamic>.from(decoded);
        } else {
          print("Lỗi format JSON từ server: $decoded");
          throw Exception("Invalid JSON format");
        }
      } else {
        print("Lỗi Server Code: ${response.statusCode}");
        _errorMessage = "Lỗi Server: ${response.statusCode}";
        _detailAnalysisResult = {
          "danh_gia_chung": "Lỗi Server: ${response.statusCode}",
          "diem_manh": [],
          "diem_can_cai_thien": [],
          "loi_khuyen": [],
        };
      }
    } catch (e) {
      print("Exception khi analyzeJobDetail: $e");
      _errorMessage = "Lỗi kết nối: $e";
      _detailAnalysisResult = {
        "danh_gia_chung": "Không thể kết nối tới AI server. Chi tiết: $e",
        "diem_manh": [],
        "diem_can_cai_thien": [],
        "loi_khuyen": [],
      };
    } finally {
      _isAnalyzingDetail = false;
      notifyListeners(); // Báo cho UI rebuild
    }

    // Debug: In ra console xem data có thật không
    print("DEBUG DATA: $_detailAnalysisResult");
  }

  void clearDetailAnalysis() {
    _detailAnalysisResult = null;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}
