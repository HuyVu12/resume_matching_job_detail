import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_model.dart';

class JobService {
  final _supabase = Supabase.instance.client;

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await _supabase
          .from('jobs')
          .select()
          .order('created_at', ascending: false)
          .limit(10);

      final data = response as List<dynamic>;
      return data.map((job) => JobModel.fromJson(job)).toList();
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu: $e');
    }
  }
}
