import 'package:flutter/material.dart';
import 'package:resume_matching_jd/views/welcome/components/welcome_page_component_item.dart';

class WelcomePageComponent extends StatelessWidget {
  const WelcomePageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        WelcomePageComponentItem(
          link: "assets/lotties/Successful Marketer.json",
          type: "lottie",
          title: "Việc làm xứng tầm",
          description: "Thăng tiến nhanh, công việc hấp dẫn, thu nhập xứng tầm",
        ),
        WelcomePageComponentItem(
          link: "assets/lotties/Tech Assistant.json",
          type: "lottie",
          title: "Cá nhân hóa trải nghiệm",
          description:
              "Sử dụng công nghệ AI dự đoán, cá nhân hóa việc làm phù hợp với bạn",
        ),
        WelcomePageComponentItem(
          link: "assets/lotties/Teamwork.json",
          type: "lottie",
          title: "Đồng hành cung bạn trên hành trình sự nghiệp",
          description: "Tìm kiếm, kết nối, xây dựng thành công",
        ),
      ],
    );
  }
}
