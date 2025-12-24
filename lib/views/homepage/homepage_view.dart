import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/components/bottom_app_bar/my_bottom_app_bar.dart';
import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';
import 'package:resume_matching_jd/views/homepage/components/list_selection.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  @override
  Widget build(BuildContext context) {
    final svm = Provider.of<SaveViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("Home")),
            SliverToBoxAdapter(
              // child: TextField(
              //   decoration: InputDecoration(
              //     hintText: "Lập trình viên Python...",
              //     prefixIcon: Icon(Icons.search),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //   ),
              // ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(child: ListSelection()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Công việc mới đăng",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      MyRouter().navigateToJobList(context);
                    },
                    child: Text("Xem tất cả"),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: JobList(jobs: svm.Jobs.sublist(0, 10))),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
