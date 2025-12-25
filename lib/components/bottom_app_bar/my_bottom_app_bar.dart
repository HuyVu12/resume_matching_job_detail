import 'package:flutter/material.dart';
import 'package:resume_matching_jd/components/bottom_app_bar/my_bottom_app_bar_item.dart';
import 'package:resume_matching_jd/cores/my_router.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MyBottomAppBarItem(
            iconPath: "assets/lotties/home_icon.json",
            label: "Home",
            onTap: () {},
          ),
          MyBottomAppBarItem(
            iconPath: "assets/lotties/document_icon.json",
            label: "Tạo CV",
            onTap: () {},
          ),
          MyBottomAppBarItem(
            iconPath: "assets/lotties/demand_icon.json",
            label: "JD AI",
            onTap: () {
              MyRouter().navigateToJobDetailAiView(context);
            },
          ),
          MyBottomAppBarItem(
            iconPath: "assets/lotties/notification_icon.json",
            label: "Notice",
            onTap: () {},
          ),
          MyBottomAppBarItem(
            iconPath: "assets/lotties/user_icon.json",
            label: "Account",
            onTap: () {
              MyRouter().navigateToAccountView(context);
            },
          ),
        ],
      ),
    );
  }
}
