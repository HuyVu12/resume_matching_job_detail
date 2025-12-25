class UserModel {
  final int id;
  final String? username;
  final String? email;
  final String? password;
  final String? avatar_url;
  final String? role;
  final String? phone;
  final String? resume_url;
  UserModel({
    this.id = 0,
    this.username,
    this.email,
    this.password,
    this.avatar_url,
    this.role,
    this.phone,
    this.resume_url,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      avatar_url: json['avatar_url'],
      role: json['role'],
      phone: json['phone'],
      resume_url: json['resume_url'],
    );
  }
}
