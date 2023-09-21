import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

abstract class RegisterEvent {}

class RegisterEventRegister extends RegisterEvent {
  RegisterEventRegister(this.registerData);
  final RegisterData registerData;
}

class RegisterEventIncorrectData extends RegisterEvent {}
