import 'package:resume_matching_jd/cores/utils.dart';
import 'package:resume_matching_jd/view_models/JDAI_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/view_models/job_detail_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class JobDetailView extends StatelessWidget {
  final JobModel job_detail;

  const JobDetailView({super.key, required this.job_detail});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobDetailViewModel>(context);
    final svm = Provider.of<SaveViewModel>(context);
    final jdaivm = Provider.of<JDAIViewModel>(context);

    if (jdaivm.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showMessage(context, jdaivm.errorMessage!, isError: true);
        jdaivm.clearErrorMessage();
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(job_detail.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                    image: job_detail.logoUrl == null
                        ? null
                        : job_detail.logoUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(job_detail.logoUrl!),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                  child:
                      job_detail.logoUrl == null || job_detail.logoUrl!.isEmpty
                      ? Icon(Icons.business, color: Colors.grey.shade400)
                      : null,
                ),
              ),

              Text(
                svm.get_company(job_detail.company_id).name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                svm.get_company(job_detail.company_id).description,
                style: const TextStyle(fontSize: 16),
              ),

              InkWell(
                onTap: () async {
                  final String? urlString = svm
                      .get_company(job_detail.company_id)
                      .website;
                  if (urlString != null &&
                      await canLaunchUrl(Uri.parse(urlString))) {
                    await launchUrl(Uri.parse(urlString));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Không thể mở trang web')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ), // Tăng vùng bấm
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link, color: Colors.blue, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Website công ty",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(),
              if (job_detail.match_score != null) ...[
                PART_AI_1(job_detail, job_detail.match_score!, () {
                  Utils.showAnalysisBottomSheet(context, jdaivm, job_detail);
                }),
                const SizedBox(height: 15),
              ],

              Text(
                job_detail.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                job_detail.description ?? "No description available.",
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  utils_tag(
                    job_detail.salaryMin != null && job_detail.salaryMax != null
                        ? "${job_detail.salaryMin! / 1000000} - ${job_detail.salaryMax! / 1000000} triệu VND"
                        : "Thương lượng",
                  ),
                  const SizedBox(width: 6),
                  utils_tag(job_detail.location ?? "Không xác định"),
                  const SizedBox(width: 6),
                  utils_tag(job_detail.job_type ?? "Không xác định"),
                ],
              ),
              Divider(),
              Text(
                "Yêu cầu công việc",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                job_detail.requirements ?? "No description available.",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Quyền lợi",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                job_detail.benefits ?? "No description available.",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Địa điểm làm việc",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${job_detail.location} - ${svm.get_company(job_detail.company_id!!).address}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: FilledButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            showMessage(context, "Chức năng đang được hoàn thiện.");
          },
          child: const Text("Ứng tuyển ngay"),
        ),
      ),
    );
  }
}
