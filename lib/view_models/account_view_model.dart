import 'package:flutter/material.dart';
import 'package:resume_matching_jd/models/user_model.dart';
import 'package:resume_matching_jd/services/auth_service.dart';
import 'package:resume_matching_jd/view_models/save_view_model.dart';

class AccountViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel _userData = current_user;
  bool _isLoading = false;
  String _errorMessage = '';

  UserModel get userData => _userData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  AccountViewModel() {
    _userData = current_user;
  }

  /// Load user profile data từ Supabase
  Future<void> loadUserProfile() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final userProfile = await _authService.getCurrentUserProfile();
      if (userProfile != null) {
        _userData = userProfile;
        current_user = userProfile; // Update global current_user
      } else {
        _errorMessage = 'Không thể tải thông tin người dùng';
      }
    } catch (e) {
      _errorMessage = 'Lỗi: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      // Sign out từ Supabase
      await _authService.signOut();
    } catch (e) {
      _errorMessage = 'Lỗi logout: ${e.toString()}';
    } finally {
      // Always clear user data regardless of logout success
      current_user = UserModel();
      _userData = UserModel();
      _isLoading = false;
      notifyListeners();
    }
  }
}
