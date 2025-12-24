import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_model.dart';

class JobService {
  final _supabase = Supabase.instance.client;
  Future<List<JobModel>> fetchJobsByQuery({
    String? keyword,
    String? jobType,
    String? location,
    int? salaryFilter, // 0: none, 1: low to high, 2: high to low
  }) async {
    try {
      dynamic query = _supabase.from('jobs').select();

      if (keyword != null && keyword.isNotEmpty) {
        query = query.or(
          'title.ilike.%$keyword%,description.ilike.%$keyword%,requirements.ilike.%$keyword%,benefits.ilike.%$keyword%,company_name.ilike.%$keyword%',
        );
      }
      if (jobType != null && jobType.isNotEmpty) {
        query = query.eq('job_type', jobType);
      }
      if (location != null && location.isNotEmpty) {
        query = query.ilike('location', '%$location%');
      }
      if (salaryFilter == 1) {
        query = query.order('salary_min', ascending: true);
      } else if (salaryFilter == 2) {
        query = query.order('salary_min', ascending: false);
      } else {
        query = query.order('created_at', ascending: false);
      }

      final response = await query;

      final data = response as List<dynamic>;
      return data.map((job) => JobModel.fromJson(job)).toList();
    } catch (e) {
      throw Exception('Lỗi khi truy vấn dữ liệu: $e');
    }
  }

  Future<List<JobModel>> fetchJobs({limit = 100}) async {
    try {
      final response = await _supabase
          .from('jobs')
          .select()
          .order('created_at', ascending: false)
          .limit(limit);

      final data = response as List<dynamic>;
      return data.map((job) => JobModel.fromJson(job)).toList();
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu: $e');
    }
  }
}
