
import 'package:dio/dio.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/loginEvent.dart';
import 'package:flutter_auth/features/login_screen/loginBloc/loginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final storage = GetIt.I<FlutterSecureStorage>();
  LoginBloc( this.repository) : super(LoginStateInitial()) {
    on<LoginEventLogIn>((event, emit) async {
      emit(LoginStateLoading());
      try{
        final result = await repository.logIn(event.loginData);
        if (result.isSuccess) {
          await storage.write(key: TOKEN_KEY, value: result.data!.token);
          emit(LoginStateLoginSuccess());
        }
      }
      on DioError catch(e) {
        if (e.response?.statusCode == 422) {
          emit(LoginStateIncorrectDataError());
        }
        else if(e.response?.statusCode == 404) {
          emit(LoginStateUserNotFound());
        }
        else {
          emit(LoginStateNetworkError());
        }
      }
    });
    on<LoginEventIncorrectData>((event, emit) {
      emit(LoginStateIncorrectDataError());
    });
  }

  final AuthRepositoryAbstract repository;
}