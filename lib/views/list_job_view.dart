import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/components/job_list/job_list.dart';
import 'package:resume_matching_jd/view_models/list_job_view_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class ListJobView extends StatelessWidget {
  const ListJobView({super.key});

  @override
  Widget build(BuildContext context) {
    final svm = Provider.of<SaveViewModel>(context);
    final vm = Provider.of<ListJobViewModel>(context);
    TextEditingController searchController = TextEditingController(
      text: vm.search_keyword,
    );
    TextEditingController locationController = TextEditingController(
      text: vm.filter_location,
    );

    void _showFilterModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Consumer<ListJobViewModel>(
            builder: (context, vm, child) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Bộ lọc tìm kiếm",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    const Text(
                      "Mức lương",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        ChoiceChip(
                          label: const Text("Thấp đến Cao"),
                          selected: vm.filter_salary == 1,
                          onSelected: (v) {
                            vm.updateFilters(
                              salary: vm.filter_salary == 1 ? 0 : 1,
                            );
                          },
                        ),
                        ChoiceChip(
                          label: const Text("Cao đến Thấp"),
                          selected: vm.filter_salary == 2,
                          onSelected: (v) {
                            vm.updateFilters(
                              salary: vm.filter_salary == 2 ? 0 : 2,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      "Loại hình",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        ChoiceChip(
                          selected: vm.filter_job_type == "Full-time",
                          label: const Text("Full-time"),
                          onSelected: (v) {
                            vm.updateFilters(
                              jobType: vm.filter_job_type == "Full-time"
                                  ? ""
                                  : "Full-time",
                            );
                          },
                        ),
                        ChoiceChip(
                          selected: vm.filter_job_type == "Part-time",
                          label: const Text("Part-time"),
                          onSelected: (v) {
                            vm.updateFilters(
                              jobType: vm.filter_job_type == "Part-time"
                                  ? ""
                                  : "Part-time",
                            );
                          },
                        ),
                        ChoiceChip(
                          selected: vm.filter_job_type == "Remote",
                          label: const Text("Remote"),
                          onSelected: (v) {
                            vm.updateFilters(
                              jobType: vm.filter_job_type == "Remote"
                                  ? ""
                                  : "Remote",
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      "Địa điểm",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: "Nhập địa điểm",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        vm.updateFilters(location: value);
                      },
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              vm.resetFilters();
                              locationController.clear();
                              searchController.clear();
                            },
                            child: const Text("Xóa lọc"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              "Áp dụng",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text("Danh sách việc làm")),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Python...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: searchController,
                onEditingComplete: () {
                  vm.updateFilters(keyword: searchController.text);
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
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
                      _showFilterModal(context);
                    },
                    child: Text("Bộ lọc"),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: JobList(jobs: vm.Jobs)),
          ],
        ),
      ),
    );
  }
}
