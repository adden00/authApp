
abstract class RegisterState {}

class RegisterStateInitial extends RegisterState {}
class RegisterStateLoading extends RegisterState {}
class RegisterStateRegistered extends RegisterState {}
class RegisterStateWrongFormat extends RegisterState {}
class RegisterStateUserNotFound extends RegisterState {}
class RegisterStateNetworkError extends RegisterState {}
