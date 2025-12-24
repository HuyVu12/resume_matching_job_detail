import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/view_models/welcome/welcome_view_model.dart';
import 'package:resume_matching_jd/views/welcome/components/welcome_page_component.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<WelcomeViewModel>(context);

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
                            onPressed: () {
                              MyRouter().navigateToLoginView(context);
                            },
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
                            onPressed: () {
                              MyRouter().navigateToRegisterView(context);
                            },
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
                      onPressed: () {
                        vm.onClickTraiNghiem(context);
                      },
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
