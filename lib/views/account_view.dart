import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_matching_jd/cores/utils.dart';
import 'package:resume_matching_jd/view_models/account_view_model.dart';
import 'package:resume_matching_jd/views/welcome/welcome_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late AccountViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AccountViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _viewModel.loadUserProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin cá nhân'),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: Consumer<AccountViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF43A047),
                ),
              );
            }

            if (viewModel.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  viewModel.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            final user = viewModel.userData;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // Avatar Section
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF43A047),
                            width: 3,
                          ),
                          image: user.avatar_url != null &&
                                  user.avatar_url!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(user.avatar_url!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: user.avatar_url == null ||
                                user.avatar_url!.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 60,
                                color: const Color(0xFF43A047),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Username
                    Center(
                      child: Text(
                        user.username ?? 'Người dùng',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Info Section
                    _buildInfoCard(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: user.email ?? 'Chưa có email',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.phone_outlined,
                      label: 'Số điện thoại',
                      value: user.phone ?? 'Chưa cập nhật',
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.work_outline,
                      label: 'Vai trò',
                      value: _getRoleName(user.role),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      icon: Icons.description_outlined,
                      label: 'CV',
                      value: user.resume_url != null && user.resume_url!.isNotEmpty
                          ? 'Đã tải lên'
                          : 'Chưa tải CV',
                    ),
                    const SizedBox(height: 40),
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _showLogoutDialog(context, viewModel);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF43A047),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build info card
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF43A047),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context, AccountViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Xác nhận đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                // Close dialog first
                Navigator.of(dialogContext).pop();
                
                // Perform logout
                await viewModel.logout();
                
                // After logout, navigate safely using outer context
                if (mounted && context.mounted) {
                  showMessage(context, 'Đăng xuất thành công!');
                  // Use pushAndRemoveUntil to go back to welcome
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeView(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Get role name in Vietnamese
  String _getRoleName(String? role) {
    switch (role) {
      case 'candidate':
        return 'Ứng viên';
      case 'recruiter':
        return 'Nhà tuyển dụng';
      default:
        return 'Chưa xác định';
    }
  }
}
