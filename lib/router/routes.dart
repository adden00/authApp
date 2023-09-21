import 'package:flutter_auth/features/login_screen/login_screen.dart';
import 'package:flutter_auth/features/register_screen/register_screen.dart';
import 'package:flutter_auth/features/profile_screen/profile_screen.dart';
import 'package:flutter_auth/main_screen.dart';
import '../features/all_users_screen/all_users_screen.dart';

final routes = {
  "/": (context) => const MainScreen(),
  "/register": (context) => const RegisterScreen(),
  "/login": (context) => const LoginScreen(),
  "/profile": (context) => const Profile(),
  "/all_users": (context) => const AllUsersScreen(),
};
