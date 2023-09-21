import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_auth/common/constants.dart';

import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepositoryAbstract {
  const AuthRepositoryImpl({required this.dio});

  final Dio dio;

  @override
  Future<AuthResponse> registerNewUser(RegisterData registerData) async {
    final FormData formData = FormData.fromMap({
      "email": registerData.email,
      "password": registerData.password,
      "name": registerData.name,
      "password_confirmation": registerData.confirmPassword
    });

    final response = await dio.post("http://$WIFI_IP/mobile/register",
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json"
        }));
    final data = response.data as Map<String, dynamic>;
    final bool isSuccess = data["success"];
    final String message = data["message"];

    final userData = data["data"] as Map<String, dynamic>;
    final String token = userData["token"];
    final String name = userData["name"];
    if (isSuccess == true) {
      return AuthResponse(
          isSuccess: true,
          message: message,
          data: RegisterResponseData(token: token, name: name));
    } else {
      return AuthResponse(isSuccess: false, message: message);
    }
  }

  @override
  Future<AuthResponse> logIn(LogInData logInData) async {
    final FormData formData = FormData.fromMap(
        {"email": logInData.email, "password": logInData.password});

    final response = await dio.post("http://$WIFI_IP/mobile/login",
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json"
        }));

    final data = response.data as Map<String, dynamic>;

    final bool isSuccess = data["success"];
    final String message = data["message"];

    final userData = data["data"] as Map<String, dynamic>;
    final String token = userData["token"];
    final String name = userData["name"];
    if (isSuccess == true) {
      return AuthResponse(
          isSuccess: true,
          message: message,
          data: RegisterResponseData(token: token, name: name));
    } else {
      return AuthResponse(isSuccess: false, message: message);
    }
  }

  @override
  Future<UserInfo> getUserInfo(String token) async {
    final response = await dio.get("http://$WIFI_IP/api/user",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        }));
    final user = UserInfo.fromJson(response.data);
    return user;
  }

  @override
  Future<List<UserInfo>> getAllUsers(String token) async {
    final response = await dio.get("http://$WIFI_IP/mobile/users",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        }));
    final data = response.data as Map<String, dynamic>;
    final users = (data["data"] as List<dynamic>).map((it) {
      final user = UserInfo.fromJson(it as Map<String, dynamic>);
      return user;
    }).toList();
    return users;
  }
}
