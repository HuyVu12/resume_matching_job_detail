import 'package:flutter/material.dart';
import 'package:resume_matching_jd/views/welcome/components/welcome_page_component.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(child: WelcomePageComponent()),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                            child: Text(
                              "Đăng ký",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Trải nghiêm ngay không cần đăng nhập"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
