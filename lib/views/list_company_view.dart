import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/models/company_model.dart';
import 'package:resume_matching_jd/view_models/list_job_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class ListCompanyView extends StatelessWidget {
  const ListCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    final svm = Provider.of<SaveViewModel>(context);
    final vm = Provider.of<ListJobViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("Danh sách công ty")),
            SliverToBoxAdapter(
              child: Column(
                children: svm.Companies.map(
                  (company) => CompanyCard(company_detail: company),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final CompanyModel company_detail;

  const CompanyCard({super.key, required this.company_detail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         CompanyDetailView(company_detail: company_detail),
        //   ),
        // );
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

            // Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company_detail.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    company_detail.description,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                  const SizedBox(height: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 6),
                        _tag(company_detail.address ?? "Không xác định"),
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
