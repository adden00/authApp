import '../../../data/auth_repository/models/models.dart';

abstract class AllUsersState {}

class AllUsersStateInitial extends AllUsersState {}

class AllUsersStateLoading extends AllUsersState {}

class AllUsersStateLoaded extends AllUsersState {
  AllUsersStateLoaded(this.users);

  final List<UserInfo> users;
}

class AllUsersStateError extends AllUsersState {
  AllUsersStateError(this.e);

  final Object e;
}

class AllUsersStateUnAuthorised extends AllUsersState {}
