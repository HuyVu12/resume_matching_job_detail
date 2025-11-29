import 'package:flutter/material.dart';
import 'package:resume_matching_jd/components/my_item_lottie_title.dart';
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
            iconPath: 'assets/lotties/briefcase_icon.json',
            label: 'Việc làm',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/company_icon.json',
            label: 'Công ty',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/document_color_icon.json',
            label: 'Tạo CV',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/blog_icon.json',
            label: 'Tạo CV',
            onTap: () {},
          ),
          ListSelectionItem(
            iconPath: 'assets/lotties/tool_icon2.json',
            label: 'Tạo CV',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
