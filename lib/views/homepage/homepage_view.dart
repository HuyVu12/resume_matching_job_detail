import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/components/bottom_app_bar/my_bottom_app_bar.dart';
import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/view_models/home_view_model.dart';
import 'package:resume_matching_jd/views/homepage/components/list_selection.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeViewModel>().loadJobs());
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("Home")),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Lập trình viên Python...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            // SliverToBoxAdapter(child: ListSelection()),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Công việc mới đăng",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text("Xem tất cả")),
                ],
              ),
            ),
            SliverToBoxAdapter(child: JobList(jobs: vm.jobs)),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
