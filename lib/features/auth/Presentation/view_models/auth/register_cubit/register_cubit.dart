import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/dio_handeler.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/auth/data/models/register_response_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit(this.authRepo) : super(RegisterInitial());

  Future<void> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(RegisterLoading());
    try {
      log('Registration attempt with email: $email');
      RegisterResponse response = await authRepo.register(
        name,
        email,
        password,
        confirmPassword,
      );

      if (response.isSuccess && response.result?.token != null) {
        emit(RegisterSuccess(response));
      } else {
        emit(
          RegisterFailure(response.errors.isNotEmpty
              ? response.errors[0]
              : 'Registration failed'),
        );
      }
    } catch (e) {
      if (e is DioException) {
        log('Register Dio Error - Status Code: ${e.response?.statusCode}');
        log('Response Data: ${e.response?.data}');

        final errorHandler = DioErrorHandler.handleError(e);

        emit(RegisterFailure(e.response?.statusCode == 400
            ? errorHandler.errors[0]
            : errorHandler.errorMessage));
      } else {
        emit(RegisterFailure('An unexpected error occurred'));
      }
      log(e.toString());
    }
  }
}
