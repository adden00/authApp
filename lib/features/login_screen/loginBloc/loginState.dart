
abstract class LoginState {}

class LoginStateInitial extends LoginState {}
class LoginStateLoading extends LoginState {}
class LoginStateLoginSuccess extends LoginState {}
class LoginStateIncorrectDataError extends LoginState {}
class LoginStateUserNotFound extends LoginState {}
class LoginStateNetworkError extends LoginState {}
