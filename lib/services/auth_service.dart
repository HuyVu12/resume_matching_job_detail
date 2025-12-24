import 'package:resume_matching_jd/models/user_model.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String role, // 'candidate' hoặc 'recruiter'
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Đăng ký thất bại: Không tạo được User.");
      }

      await _supabase.from('users').insert({
        'email': email,
        'username': username,
        'password': password,
        'phone': phone,
        'role': role,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      if (e is AuthException) {
        throw Exception('Lỗi đăng ký: ${e.message}');
      }
      throw Exception('Lỗi hệ thống: $e');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Đăng nhập thất bại.");
      }
      current_user = await getCurrentUserProfile() ?? UserModel();
    } catch (e) {
      if (e is AuthException) {
        throw Exception('Lỗi đăng nhập: ${e.message}');
      }
      throw Exception('Lỗi hệ thống: $e');
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<UserModel?> getCurrentUserProfile() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _supabase
          .from('users')
          .select()
          .eq('email', user.email!)
          .single();

      return UserModel.fromJson(data);
    } catch (e) {
      print("Không lấy được profile người dùng: $e");
      return null;
    }
  }

  Future<String?> getUserRole() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await _supabase
          .from('users')
          .select('role')
          .eq('email', user.email!)
          .single();

      return data['role'] as String?;
    } catch (e) {
      print("Không lấy được role: $e");
      return null;
    }
  }
}
