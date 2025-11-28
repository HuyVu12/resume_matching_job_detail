import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePageComponentItem extends StatelessWidget {
  final String link;
  final String type;
  final String title;
  final String description;

  const WelcomePageComponentItem({
    super.key,
    required this.link,
    required this.type,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: double.infinity,
            child: type == "lottie"
                ? Lottie.asset(link, fit: BoxFit.contain)
                : Image.asset(link, fit: BoxFit.contain),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            spacing: 10,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                description,
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
