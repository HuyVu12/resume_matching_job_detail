import 'package:flutter/material.dart';

class ToolsViewModel extends ChangeNotifier {
  // URL Constants cho các công cụ
  static const String mbtiTestUrl = 'https://www.topcv.vn/trac-nghiem-tinh-cach-mbti';
  static const String miTestUrl = 'https://vn.joboko.com/trac-nghiem-da-tri-thong-minh-mi';
  static const String grossNetUrl = 'https://www.topcv.vn/tinh-luong-gross-net';

  // Model dữ liệu cho các công cụ
  List<ToolItem> _tools = [
    ToolItem(
      id: 1,
      title: 'Công cụ tính lương Gross - Net',
      icon: Icons.attach_money,
      description: 'Tính toán lương thực nhận nhanh chóng',
      url: grossNetUrl,
    ),
  ];

  List<ToolItem> get tools => _tools;

  // Action khi nhấn nút "Khám phá" cho MBTI
  void exploreMBTI() {
    print('Navigate to MBTI test: $mbtiTestUrl');
    notifyListeners();
  }

  // Action khi nhấn nút "Khám phá" cho MI
  void exploreMultipleIntelligence() {
    print('Navigate to MI test: $miTestUrl');
    notifyListeners();
  }

  // Action khi nhấn vào công cụ
  void selectTool(int toolId) {
    print('Selected tool: $toolId');
    notifyListeners();
  }
}

class ToolItem {
  final int id;
  final String title;
  final IconData icon;
  final String description;
  final String url;

  ToolItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.url,
  });
}

