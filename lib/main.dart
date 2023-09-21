import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'MyApp.dart';


void main() {
  GetIt.I.registerLazySingleton<AuthRepositoryAbstract>(() => AuthRepositoryImpl(dio: Dio()));
  GetIt.I.registerLazySingleton(() => const FlutterSecureStorage());
  runApp(const MyApp());
}





