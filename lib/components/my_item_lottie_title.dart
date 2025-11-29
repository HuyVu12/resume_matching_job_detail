import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class MyItemLottieTitle extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  final String iconPath;
  double fontSize;
  double? heightLottie;
  MyItemLottieTitle({
    super.key,
    this.onTap,
    this.fontSize = 16,
    this.heightLottie,
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
            Expanded(
              child: LottieBuilder.asset(
                iconPath,
                repeat: false,
                height: heightLottie,
              ),
            ),
            Text(label, style: TextStyle(fontSize: fontSize), maxLines: 2),
          ],
        ),
      ),
    );
  }
}
