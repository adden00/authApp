part of "login_bloc.dart";

abstract class LoginEvent {}

class LoginEventLogIn extends LoginEvent {
  LoginEventLogIn(this.loginData);

  final LogInData loginData;
}

class LoginEventIncorrectData extends LoginEvent {}