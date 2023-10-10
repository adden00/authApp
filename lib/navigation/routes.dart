import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/login_screen/login_screen.dart';
import 'package:flutter_auth/features/register_screen/register_screen.dart';
import 'package:flutter_auth/features/profile_screen/profile_screen.dart';
import 'package:flutter_auth/main_screen.dart';
import '../../features/all_users_screen/all_users_screen.dart';

abstract class RouteNames {
  const RouteNames._();

  static const initial = home;

  static const home = "/";
  static const register = "/register";
  static const login = "/login";
  static const profile = "/profile";
  static const allUsers = "/all_users";

}

abstract class RoutesBuilder {
  const RoutesBuilder._();
  static final routes = <String, Widget Function(BuildContext)>{
    RouteNames.home: (_) => const MainScreen(),
    RouteNames.register: (_) => const RegisterScreen(),
    RouteNames.login: (_) => const LoginScreen(),
    RouteNames.profile: (_) => const ProfileScreen(),
    RouteNames.allUsers: (_) => const AllUsersScreen()
  };
}
