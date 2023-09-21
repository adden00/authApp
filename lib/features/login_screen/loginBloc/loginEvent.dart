

import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

abstract class LoginEvent {}

class LoginEventLogIn extends LoginEvent {
  LoginEventLogIn(this.loginData);

  final LogInData loginData;
}

class LoginEventIncorrectData extends LoginEvent {}