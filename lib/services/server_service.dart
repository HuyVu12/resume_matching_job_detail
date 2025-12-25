import 'package:supabase_flutter/supabase_flutter.dart';

class ServerService {
  final _supabase = Supabase.instance.client;

  Future<String> fetchlink() async {
    try {
      final response = await _supabase
          .from('sever')
          .select()
          .order('created_at', ascending: false)
          .limit(1);

      final data = response as List<dynamic>;
      if (data.isNotEmpty) {
        return data[0]['link'] as String;
      }
      return "";
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu: $e');
    }
  }
}
