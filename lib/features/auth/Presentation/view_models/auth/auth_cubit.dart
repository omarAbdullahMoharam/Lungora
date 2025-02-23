import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/core/helpers/dio_handeler.dart';
import 'package:lungora/core/helpers/response_handeler.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(
    this.authRepo,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      log('Login attempt with email: $email');
      AuthResponse response = await authRepo.login(email, password);
      final handler = ResponseHandler.fromAuthResponse(response);

      handler.when(
        onSuccess: (data) {
          emit(AuthSuccess(response));
        },
        onError: (message) {
          emit(AuthFailure(message));
        },
      );
    } catch (e) {
      if (e is DioException) {
        log('Status Code: ${e.response?.statusCode}');
        log('Response Data: ${e.response?.data}');

        final errorHandler = DioErrorHandler.handleError(e);

        if (e.response?.statusCode == 400) {
          emit(AuthFailure('Invalid email or password. Please try again.'));
          return;
        }

        emit(AuthFailure(errorHandler.errorMessage));
      } else {
        emit(AuthFailure('An unexpected error occurred'));
      }
      log(e.toString());
    }
  }

  Future<void> register(String name, String email, String password,
      String confirmPassword) async {
    emit(AuthLoading());
    try {
      AuthResponse response =
          await authRepo.register(name, email, password, confirmPassword);
      final handler = ResponseHandler.fromAuthResponse(response);

      handler.when(
        onSuccess: (data) {
          emit(AuthRegister());
        },
        onError: (message) => emit(AuthFailure(message)),
      );
    } catch (e) {
      if (e is DioException) {
        final errorHandler = DioErrorHandler.handleError(e);
        emit(AuthFailure(errorHandler.errorMessage));
      } else {
        emit(AuthFailure('An unexpected error occurred during registration'));
      }
      log(e.toString());
    }
  }

  Future<void> forgetUserPassword({required String email}) async {
    emit(AuthLoading());
    try {
      AuthResponse response = await authRepo.forgetUserPassword(email);
      final handler = ResponseHandler.fromAuthResponse(response);

      handler.when(
        onSuccess: (data) {
          log('Forget Password Success: ${response.message}');
          emit(
            AuthSuccess(response, responseResult: response.message),
          );
        },
        onError: (message) {
          // Get the most appropriate error message
          String errorMessage = response.errors.isNotEmpty
              ? response.errors.first.toString()
              : response.message;

          log('Forget Password Error: $errorMessage');
          emit(AuthFailure(errorMessage));
        },
      );
    } catch (e) {
      if (e is DioException) {
        final errorHandler = DioErrorHandler.handleError(e);
        String errorMessage = errorHandler.errorMessage.toString();

        // Handle specific DioException cases
        if (e.response?.data is Map<String, dynamic>) {
          final responseData = e.response?.data as Map<String, dynamic>;
          if (responseData.containsKey('message')) {
            errorMessage = responseData['message'].toString();
          }
        }

        log('Dio Error in forget password: $errorMessage');
        emit(AuthFailure(errorMessage));
      } else {
        log('Unexpected error in forget password: $e');
        emit(AuthFailure('An unexpected error occurred during password reset'));
      }
    }
  }
}
