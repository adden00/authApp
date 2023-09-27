import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.repository) : super(ProfileStateInitial()) {
    on<LoadUserDataEvent>((event, emit) async {
      emit(ProfileStateLoading());
      try {
        final storage = GetIt.I<FlutterSecureStorage>();
        final token = await storage.read(key: TOKEN_KEY);
        if (token != null){
          final userData = await repository.getUserInfo(token);
          emit(ProfileStateLoaded(userData));
        }
        else{
          emit(ProfileStateLoginError());
        }
      }
      catch(e) {
        emit(ProfileStateError(e.toString()));
      }
    },
    );
    on<LogOutEvent>((event, emit) async {
      final storage = GetIt.I<FlutterSecureStorage>();
      await storage.delete(key: TOKEN_KEY);
    });


  }

  final  AuthRepositoryAbstract repository;

}