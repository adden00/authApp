part of "profile_bloc.dart";


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