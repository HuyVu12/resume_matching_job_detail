import 'package:flutter/material.dart';
import 'package:resume_matching_jd/components/job_list/job_card.dart';
import 'package:resume_matching_jd/models/job.dart';
import 'package:resume_matching_jd/models/job_model.dart';

class JobList extends StatelessWidget {
  final List<JobModel> jobs;
  const JobList({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: jobs.map((job) => JobCard(job_detail: job)).toList(),
    );
  }
}
