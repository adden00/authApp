part of "login_bloc.dart";

abstract class LoginState {}

class LoginStateInitial extends LoginState {}
class LoginStateLoading extends LoginState {}
class LoginStateInputting extends LoginState {}
