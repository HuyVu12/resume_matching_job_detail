import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyBottomAppBarItem extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  final String iconPath;
  const MyBottomAppBarItem({
    super.key,
    this.onTap,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: LottieBuilder.asset(iconPath, repeat: false)),
            Text(label, style: const TextStyle(fontSize: 11), maxLines: 2),
          ],
        ),
      ),
    );
  }
}
