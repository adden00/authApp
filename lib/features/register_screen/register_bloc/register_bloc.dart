import 'package:dio/dio.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_effect.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_event.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:side_effect_bloc/side_effect_bloc.dart';

import '../../../common/Constants.dart';

class RegisterBloc extends SideEffectBloc<RegisterEvent, RegisterState, RegisterEffect> {
  RegisterBloc(this.repository) : super(RegisterStateInitial()) {
    on<RegisterEventRegister>((event, emit) async {
      final storage = GetIt.I<FlutterSecureStorage>();
      emit(RegisterStateLoading());
      try {
        final response = await repository.registerNewUser(event.registerData);
        if (response.isSuccess) {
          await storage.write(key: TOKEN_KEY, value: response.data!.token);
          produceSideEffect(RegisterEffectSuccess());
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 422) {
          emit(RegisterStateInputting());

        } else {
          produceSideEffect(RegisterEffectShowSnackbar("newtwork error!"));
        }
      }
      emit(RegisterStateInputting());

    });

    on<RegisterEventIncorrectData>((event, emit) {
      emit(RegisterStateInputting());
    });
  }
  final AuthRepositoryAbstract repository;
}
