import 'package:flutter/material.dart';
import 'package:resume_matching_jd/components/my_item_lottie_title.dart';

class ListSelectionItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final Function()? onTap;
  const ListSelectionItem({
    super.key,
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: MyItemLottieTitle(
        iconPath: iconPath,
        label: label,
        fontSize: 13,
        onTap: onTap,
      ),
    );
  }
}
