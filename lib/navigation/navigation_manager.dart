


import 'package:flutter/material.dart';
import 'package:flutter_auth/navigation/routes.dart';

class NavigationManager {

  final key = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => key.currentState!;

  void navToLogin() {
    _navigator.pushNamed(RouteNames.login);
  }

  void navToRegister() {
    _navigator.pushNamed(RouteNames.register);
  }

  void navToAllUsers() {
    _navigator.pushNamed(RouteNames.allUsers);
  }

  void navToProfile() {
    _navigator.pushNamedAndRemoveUntil( RouteNames.profile, (route) => false);
  }

  void returnToHome() {
    _navigator.pushNamedAndRemoveUntil(RouteNames.home, (route) => false);
  }

}