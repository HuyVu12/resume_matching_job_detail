import 'package:flutter/material.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/cores/utils.dart';
import 'package:resume_matching_jd/services/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;
  String _selectedRole =
      'candidate'; // Mặc định là ứng viên (candidate hoặc recruiter)

  void _handleRegister() {
    AuthService()
        .signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _usernameController.text.trim(),
          phone: _phoneController.text.trim(),
          role: _selectedRole,
        )
        .then((_) {
          showMessage(context, "Đăng ký thành công! Vui lòng đăng nhập.");
          MyRouter().navigateToLoginView(context);
        })
        .catchError((error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Lỗi đăng ký: $error')));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
               Color(0xFF5E60C0), // Tím đậm (Deep Periwinkle) - thay cho Xanh lá đậm
                Color(0xFF8A8CFF), // Tím trung tính (màu chính trong ảnh) - thay cho Xanh lá trung tính
                Color(0xFFC5C7FF), // Tím lavender nhạt - thay cho Xanh bạc hà nhạt
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tạo tài khoản",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Bắt đầu hành trình sự nghiệp của bạn",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Phần Form màu trắng bo tròn
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          "Bạn là?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              _buildRoleButton("Ứng viên", "candidate"),
                              _buildRoleButton("Nhà tuyển dụng", "recruiter"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // --- FORM NHẬP LIỆU ---
                        _buildShadowContainer(
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: _fullnameController,
                                hint: "Họ và tên",
                                icon: Icons.person_outline,
                              ),
                              _buildTextField(
                                controller: _usernameController,
                                hint: "Tên tài khoản",
                                icon: Icons.account_circle_outlined,
                              ),
                              _buildDivider(),
                              _buildTextField(
                                controller: _phoneController,
                                hint: "Số điện thoại",
                                icon: Icons.phone_android_outlined,
                                inputType: TextInputType.phone,
                              ),
                              _buildDivider(),
                              _buildTextField(
                                controller: _emailController,
                                hint: "Địa chỉ Email",
                                icon: Icons.email_outlined,
                                inputType: TextInputType.emailAddress,
                              ),
                              _buildDivider(),
                              _buildTextField(
                                controller: _passwordController,
                                hint: "Mật khẩu",
                                icon: Icons.lock_outline,
                                isPassword: true,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Nút Đăng ký
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8A8CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blue.withOpacity(0.4),
                            ),
                            child: const Text(
                              "ĐĂNG KÝ NGAY",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Chuyển qua trang Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Đã có tài khoản?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                MyRouter().navigateToLoginView(context);
                              },
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8A8CFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(String title, String value) {
    bool isSelected = _selectedRole == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedRole = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.blue[800] : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShadowContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isLast = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: isPassword && _isObscure,
        keyboardType: inputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.blue[400]),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey[100],
    );
  }
}
