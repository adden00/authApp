part of 'register_bloc.dart';


abstract class RegisterEvent extends Equatable {}

class RegisterEventRegister extends RegisterEvent {
  RegisterEventRegister(this.registerData);
  final RegisterData registerData;

  @override
  List<Object?> get props => [registerData];
}

class RegisterEventIncorrectData extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
