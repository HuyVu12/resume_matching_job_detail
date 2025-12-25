import 'package:flutter/material.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/cores/utils.dart';
import 'package:resume_matching_jd/views/homepage/components/list_selection_item.dart';

class ListSelection extends StatelessWidget {
  const ListSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ListSelectionItem(
            iconPath: 'assets/lotties/job.json',
            label: 'Việc làm',
            onTap: () {
              MyRouter().navigateToJobList(context);
            },
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/company.json',
            label: 'Công ty',
            onTap: () {
              MyRouter().navigateToCompanyList(context);
            },
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/document_icon.json',
            label: 'Tạo CV',
            onTap: () {
              MyRouter().navigateToWebView(
                context,
                'Tạo CV online',
                "https://timviec365.vn/cv-xin-viec",
              );
            },
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/mark.json',
            label: 'Blog',
            onTap: () {
              showMessage(context, "Chức năng đang được hoàn thiện.");
            },
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/tool.json',
            label: 'Công cụ',
            onTap: () {
              MyRouter().navigateToToolsView(context);
            },
          ),
        ],
      ),
    );
  }
}
