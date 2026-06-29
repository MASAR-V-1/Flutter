import 'user_model.dart';

class LoginResponseModel {
  final String message;
  final UserModel user;
  final String token;

  const LoginResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    final Map<String, dynamic> source =
    data is Map<String, dynamic> ? data : json;

    return LoginResponseModel(
      message: json['message'] ?? source['message'] ?? '',
      user: UserModel.fromJson(source['user'] ?? {}),
      token: source['token'] ?? '',
    );
  }
}