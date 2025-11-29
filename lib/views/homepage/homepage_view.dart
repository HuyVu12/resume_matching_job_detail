import 'package:flutter/material.dart';
import 'package:resume_matching_jd/components/bottom_app_bar/my_bottom_app_bar.dart';
import 'package:resume_matching_jd/views/homepage/components/list_selection.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
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
            SliverToBoxAdapter(child: ListSelection()),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
