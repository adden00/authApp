import 'package:dio/dio.dart';
import 'package:flutter_auth/common/Constants.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

part "login_effect.dart";
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends SideEffectBloc<LoginEvent, LoginState, LoginEffect> {
  final storage = GetIt.I<FlutterSecureStorage>();

  LoginBloc(this.repository) : super(LoginStateInitial()) {
    on<LoginEventLogIn>((event, emit) async {
      emit(LoginStateLoading());
      try {
        final result = await repository.logIn(event.loginData);
        await storage.write(key: TOKEN_KEY, value: result.data!.token);
        produceSideEffect(LoginEffectSuccess());

      } on DioError catch (e) {
        if (e.response?.statusCode == 422) {
          // emit(LoginStateIncorrectDataError());
        } else if (e.response?.statusCode == 404) {
          produceSideEffect(LoginEffectShowSnackbar("user not found!"));
        } else {
          produceSideEffect(LoginEffectShowSnackbar("network error!"));
        }
      }
      emit(LoginStateInputting());

    });
    on<LoginEventIncorrectData>((event, emit) {
      emit(LoginStateInputting());
    });
  }

  final AuthRepositoryAbstract repository;
}
