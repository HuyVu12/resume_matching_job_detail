import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/job_model.dart';
import 'package:resume_matching_jd/views/job_detail_view.dart';

class JobCard extends StatelessWidget {
  final JobModel job_detail;

  const JobCard({super.key, required this.job_detail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailView(job_detail: job_detail),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8),
                image: job_detail.logoUrl == null
                    ? null
                    : job_detail.logoUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(job_detail.logoUrl!),
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
              child: job_detail.logoUrl == null || job_detail.logoUrl!.isEmpty
                  ? Icon(Icons.business, color: Colors.grey.shade400)
                  : null,
            ),

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job_detail.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    job_detail.company_name,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _tag(
                          job_detail.salaryMin != null &&
                                  job_detail.salaryMax != null
                              ? "${job_detail.salaryMin! / 1000000} - ${job_detail.salaryMax! / 1000000} triệu VND"
                              : "Thương lượng",
                        ),
                        const SizedBox(width: 6),
                        _tag(job_detail.location ?? "Không xác định"),
                        const SizedBox(width: 6),
                        _tag(job_detail.job_type ?? "Không xác định"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(text, style: const TextStyle(fontSize: 12)),
  );
}
