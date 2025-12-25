import 'package:flutter/material.dart';
import 'package:resume_matching_jd/cores/my_router.dart';
import 'package:resume_matching_jd/services/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;

  void _handleLogin() {
    AuthService()
        .signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        )
        .then((_) {
          MyRouter().navigateToHome(context);
        })
        .catchError((error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Lỗi đăng nhập'),
              content: Text(error.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
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
              Color(0xFF2E7D32), // Xanh lá đậm (Forest Green)
              Color(0xFF43A047), // Xanh lá trung tính
              Color(0xFFA5D6A7), // Xanh bạc hà nhạt (Mint)
            ],
            ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    Text(
                      "Xin chào,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Đăng nhập để tiếp tục",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

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
                        const SizedBox(height: 20),

                        _buildShadowContainer(
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: _emailController,
                                hint: "Địa chỉ Email",
                                icon: Icons.email_outlined,
                                inputType: TextInputType.emailAddress,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                height: 1,
                                color: Colors.grey[100], // Divider
                              ),
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

                        const SizedBox(height: 20),

                        // Nút Quên mật khẩu
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Điều hướng đến trang quên mật khẩu
                            },
                            child: const Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Nút Đăng nhập
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color(0xFF43A047),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 8,
                              shadowColor: Colors.blue.withOpacity(0.4),
                            ),
                            child: const Text(
                              "ĐĂNG NHẬP",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                        const Text(
                          "Hoặc đăng nhập với",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 20),

                        // Social Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              "assets/google.png",
                              "Google",
                            ), // Cần thêm ảnh icon
                            const SizedBox(width: 20),
                            _buildSocialButton(
                              "assets/facebook.png",
                              "Facebook",
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Chuyển sang màn hình Đăng ký
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Chưa có tài khoản?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                MyRouter().navigateToRegisterView(context);
                              },
                              child: const Text(
                                "Đăng ký ngay",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
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

  // --- WIDGET CON DÙNG LẠI ---

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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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

  Widget _buildSocialButton(String iconPath, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            label == "Google" ? Icons.g_mobiledata : Icons.facebook,
            color: label == "Google" ? Colors.red : Colors.blue[800],
            size: 30,
          ),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
