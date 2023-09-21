
class AuthResponse {
  AuthResponse({required this.message, required this.isSuccess, this.data});

  final bool isSuccess;
  final RegisterResponseData? data;
  final String message;
}

class RegisterResponseData {
  const RegisterResponseData({required this.token, required this.name});

  final String token;
  final String name;

}