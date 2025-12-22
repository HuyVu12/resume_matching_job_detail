import 'package:flutter/material.dart';
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
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/company.json',
            label: 'Công ty',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/document_icon.json',
            label: 'Tạo CV',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/mark.json',
            label: 'Blog',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/tool.json',
            label: 'Công cụ',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
