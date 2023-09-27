import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

part 'all_users_event.dart';
part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  final storage = GetIt.I<FlutterSecureStorage>();
  AllUsersBloc(this.repository) : super(AllUsersStateInitial()) {
    on<AllUsersEventLoadUsers>((event, emit) async {
      emit(AllUsersStateLoading());
      try {
        final token = await storage.read(key: TOKEN_KEY);
        if (token != null){
          final users = await repository.getAllUsers(token);
          emit(AllUsersStateLoaded(users));
        }
        else {
          emit(AllUsersStateUnAuthorised());
        }

      }
      catch (e) {
        emit(AllUsersStateError(e));
      }
    });
  }
  final AuthRepositoryAbstract repository;
}