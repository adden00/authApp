import 'models/models.dart';

abstract class AuthRepositoryAbstract {

  Future<AuthResponse> registerNewUser(RegisterData registerData);
  Future<AuthResponse> logIn(LogInData logInData);
  Future<UserInfo> getUserInfo(String token);
  Future<List<UserInfo>> getAllUsers(String token);
}