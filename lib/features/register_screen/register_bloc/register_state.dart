
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {}

class RegisterStateInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}
class RegisterStateLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}
class RegisterStateRegistered extends RegisterState {
  @override
  List<Object?> get props => [];
}
class RegisterStateWrongFormat extends RegisterState {
  @override
  List<Object?> get props => [];
}
class RegisterStateUserNotFound extends RegisterState {
  @override
  List<Object?> get props => [];
}
class RegisterStateNetworkError extends RegisterState {
  @override
  List<Object?> get props => [];
}
