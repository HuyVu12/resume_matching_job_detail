import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/models/company_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/view_models/job_detail_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class CompanyDetailView extends StatelessWidget {
  final CompanyModel company_detail;

  const CompanyDetailView({super.key, required this.company_detail});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<JobDetailViewModel>(context);
    final svm = Provider.of<SaveViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text(company_detail.name)),
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
                    image: company_detail.logo_url == null
                        ? null
                        : company_detail.logo_url!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(company_detail.logo_url!),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                  child:
                      company_detail.logo_url == null ||
                          company_detail.logo_url!.isEmpty
                      ? Icon(Icons.business, color: Colors.grey.shade400)
                      : null,
                ),
              ),

              Text(
                company_detail.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                company_detail.description,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Địa chỉ: ${company_detail.address ?? "Không xác định"}",
                style: const TextStyle(fontSize: 14),
              ),
              InkWell(
                onTap: () async {
                  final String? urlString = company_detail.website;
                  if (urlString != null &&
                      await canLaunchUrl(Uri.parse(urlString))) {
                    await launchUrl(Uri.parse(urlString));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Không thể mở trang web')),
                    );
                  }
                },
                child: const Text(
                  "Xem trang công ty",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Divider(),
              Text(
                "Công việc tại ${company_detail.name}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              JobList(
                jobs: svm.get_all_jobs_by_company_name(company_detail.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _tag(String text) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(text, style: const TextStyle(fontSize: 12)),
);
