import 'package:equatable/equatable.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

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
