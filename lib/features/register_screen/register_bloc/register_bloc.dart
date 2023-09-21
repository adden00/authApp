import 'package:dio/dio.dart';
import 'package:flutter_auth/data/auth_repository/auth_repository.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_event.dart';
import 'package:flutter_auth/features/register_screen/register_bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../common/Constants.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.repository) : super(RegisterStateInitial()) {
    on<RegisterEventRegister>((event, emit) async {
      final storage = GetIt.I<FlutterSecureStorage>();
      emit(RegisterStateLoading());
      try {
        final response = await repository.registerNewUser(event.registerData);
        if (response.isSuccess) {
          await storage.write(key: TOKEN_KEY, value: response.data!.token);
          emit(RegisterStateRegistered());
        }
      } on DioError catch (e) {
        if (e.response?.statusCode == 422) {
          emit(RegisterStateWrongFormat());
        } else if (e.response?.statusCode == 404) {
          emit(RegisterStateUserNotFound());
        } else {
          (emit(RegisterStateNetworkError()));
        }
      }
      catch(e) {
        emit(RegisterStateNetworkError());
      }
    });
    on<RegisterEventIncorrectData>((event, emit) {
      emit(RegisterStateWrongFormat());
    });
  }
  final AuthRepositoryAbstract repository;
}
