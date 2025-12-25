import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/view_models/JDAI_view_model.dart';

Widget _buildSectionHeader(
  String title,
  IconData icon, {
  Color color = Colors.black87,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          maxLines: 3,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget PART_AI_1(
  JobModel job_detail,
  double scoreDisplay,
  void Function()? onPressed,
) {
  final String scoreDisplay = job_detail.match_score != null
      ? "${(job_detail.match_score! * 100).toStringAsFixed(1)}%"
      : "";

  final color_decor = job_detail.match_score == null
      ? Colors.green.shade300
      : job_detail.match_score! > 0.7
      ? Colors.green.shade500
      : job_detail.match_score! > 0.5
      ? Colors.orange.shade400
      : Colors.red.shade400;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green, width: .5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Độ phù hợp",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$scoreDisplay",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: color_decor,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.auto_awesome, size: 18),
          label: const Text("AI Phân tích"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),
      ],
    ),
  );
}

Widget utils_tag(String text) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(text, style: const TextStyle(fontSize: 12), softWrap: true),
);

class Utils {
  static void showAnalysisBottomSheet(
    BuildContext context,
    JDAIViewModel jdaiVm,
    JobModel job,
  ) {
    jdaiVm.clearDetailAnalysis();
    jdaiVm.analyzeJobDetail(job);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // --- Header ---
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(Icons.auto_awesome, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        "AI Phân tích chi tiết",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30),

                  Expanded(
                    child: Consumer<JDAIViewModel>(
                      builder: (context, vm, child) {
                        if (vm.isAnalyzingDetail) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(color: Colors.green),
                                SizedBox(height: 20),
                                Text("AI đang đọc hồ sơ của bạn..."),
                              ],
                            ),
                          );
                        }

                        final data = vm.detailAnalysisResult;
                        if (data == null)
                          return const Text("Không có dữ liệu.");

                        // Parse dữ liệu từ Map
                        final String general = data['danh_gia_chung'] ?? "";
                        final List strengths = data['diem_manh'] ?? [];
                        final List weaknesses =
                            data['diem_can_cai_thien'] ?? [];
                        final List advice = data['loi_khuyen'] ?? [];

                        return ListView(
                          controller: controller,
                          children: [
                            _buildSectionHeader(
                              "Đánh giá chung",
                              Icons.article,
                            ),
                            Text(
                              general,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 20),

                            if (strengths.isNotEmpty) ...[
                              _buildSectionHeader(
                                "Điểm mạnh",
                                Icons.thumb_up_alt,
                                color: Colors.green,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: strengths.map((s) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade500,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ), // Bo tròn giống Chip
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            s.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // 3. Cần cải thiện (Dạng List)
                            if (weaknesses.isNotEmpty) ...[
                              _buildSectionHeader(
                                "Cần cải thiện",
                                Icons.warning_amber_rounded,
                                color: Colors.orange,
                              ),
                              ...weaknesses.map(
                                (w) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.remove_circle_outline,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          w.toString(),
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // 4. Lời khuyên (Dạng Card)
                            if (advice.isNotEmpty) ...[
                              _buildSectionHeader(
                                "Lời khuyên từ AI",
                                Icons.tips_and_updates,
                                color: Colors.blue,
                              ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue.shade100,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: advice
                                      .map(
                                        (a) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.lightbulb,
                                                color: Colors.blue.shade700,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  a.toString(),
                                                  style: TextStyle(
                                                    color: Colors.blue.shade900,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],

                            const SizedBox(
                              height: 50,
                            ), // Padding bottom safe area
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void showMessage(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: isError ? Colors.red.shade600 : Colors.green.shade600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 3),
    ),
  );
}
