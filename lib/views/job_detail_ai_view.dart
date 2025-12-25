import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/view_models/JDAI_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class JobDetailAiView extends StatelessWidget {
  const JobDetailAiView({super.key});

  final Color primaryGreen = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JDAIViewModel>(context);
    final svm = Provider.of<SaveViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("JD AI Matcher"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tải lên CV của bạn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _buildUploadArea(context, vm),

            const SizedBox(height: 20),
            if (vm.pickedFile != null && vm.pickedFile!.extension == 'pdf')
              _buildPdfPreview(vm.pickedFile!.path!),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // Logic: Chỉ cho bấm khi đã chọn file và không đang loading
                onPressed: (vm.pickedFile != null && !vm.isAnalyzing)
                    ? () => vm.analyzeCV()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: vm.isAnalyzing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "PHÂN TÍCH & TÌM VIỆC",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 30),

            if (vm.matchedJobs.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Công việc phù hợp nhất",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Đã tìm thấy ${vm.matchedJobs.length} việc",
                    style: TextStyle(
                      color: primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              JobList(jobs: vm.matchedJobs),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPdfPreview(String filePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Xem trước nội dung:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PDFView(
              filePath: filePath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageFling: false,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            ),
          ),
        ),

        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildUploadArea(BuildContext context, JDAIViewModel vm) {
    bool hasFile = vm.pickedFile != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasFile ? primaryGreen : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            hasFile ? Icons.file_present_rounded : Icons.cloud_upload_outlined,
            size: 50,
            color: hasFile ? primaryGreen : Colors.grey,
          ),
          const SizedBox(height: 10),

          Text(
            hasFile ? vm.fileName! : "Kéo thả hoặc chọn file PDF/Word",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: hasFile ? Colors.black : Colors.grey,
              fontWeight: hasFile ? FontWeight.bold : FontWeight.normal,
              fontSize: hasFile ? 16 : 14,
            ),
          ),

          const SizedBox(height: 15),

          if (!hasFile)
            OutlinedButton(
              onPressed: () => vm.pickCV(), // Gọi hàm từ VM
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Chọn CV từ của bạn",
                style: TextStyle(color: primaryGreen),
              ),
            ),

          if (hasFile)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextButton.icon(
                //   onPressed: () => vm.pickCV(), // Chọn lại file khác
                //   icon: const Icon(Icons.refresh, size: 16, color: Colors.blue),
                //   label: const Text(
                //     "Đổi file",
                //     style: TextStyle(color: Colors.blue),
                //   ),
                // ),
                // const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: () => vm.removeFile(), // Xóa file
                  icon: const Icon(Icons.close, size: 16, color: Colors.red),
                  label: const Text("Xóa", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
