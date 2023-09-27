part of "profile_bloc.dart";
abstract class ProfileEvent {}

class LoadUserDataEvent extends ProfileEvent {}
class LogOutEvent extends ProfileEvent {}