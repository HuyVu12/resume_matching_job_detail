import 'package:resume_matching_jd/models/company_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyService {
  final _supabase = Supabase.instance.client;

  Future<List<CompanyModel>> fetchCompanies() async {
    try {
      final response = await _supabase
          .from('companies')
          .select()
          .order('id', ascending: true);

      final data = response as List<dynamic>;
      return data.map((company) => CompanyModel.fromJson(company)).toList();
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu: $e');
    }
  }
}
