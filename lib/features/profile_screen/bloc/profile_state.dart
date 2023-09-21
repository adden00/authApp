
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';

abstract class ProfileState{}

class ProfileStateInitial extends ProfileState {}
class ProfileStateLoading extends ProfileState {}
class ProfileStateLoaded extends ProfileState {
  ProfileStateLoaded(this.userInfo);
  final UserInfo userInfo;
}
class ProfileStateError extends ProfileState {
  ProfileStateError(this.error);
  final String error;
}
class ProfileStateLoginError extends ProfileState {}