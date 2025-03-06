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

// Login Logic for user login with email and password
  // Future<void> login(String email, String password) async {
  //   emit(AuthLoading());
  //   try {
  //     log('Login attempt with email: $email');
  //     LoginResponse response = await authRepo.login(email, password);

  //     if (response.isSuccess && response.result?.token != null) {
  //       emit(LoginSuccess(response));
  //     } else {
  //       emit(AuthFailure(
  //           response.errors.isNotEmpty ? response.errors[0] : 'Login failed'));
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       log('Status Code: ${e.response?.statusCode}');
  //       log('Response Data: ${e.response?.data}');

  //       final errorHandler = DioErrorHandler.handleError(e);

  //       if (e.response?.statusCode == 400) {
  //         emit(AuthFailure(errorHandler.errors[0]));
  //         return;
  //       }

  //       emit(AuthFailure(errorHandler.errorMessage));
  //     } else {
  //       emit(AuthFailure('An unexpected error occurred'));
  //     }
  //     log(e.toString());
  //   }
  // }

// Register Logic for new user registration with name, email, password and confirm password
  // Future<void> register(
  //   String name,
  //   String email,
  //   String password,
  //   String confirmPassword,
  // ) async {
  //   emit(AuthLoading());
  //   try {
  //     AuthResponse response =
  //         await authRepo.register(name, email, password, confirmPassword);
  //     final handler = ResponseHandler.fromAuthResponse(response);

  //     handler.when(
  //       onSuccess: (data) {
  //         emit(AuthRegister());
  //       },
  //       onError: (message) => emit(AuthFailure(message)),
  //     );
  //   } catch (e) {
  //     if (e is DioException) {
  //       final errorHandler = DioErrorHandler.handleError(e);
  //       emit(AuthFailure(errorHandler.errorMessage));
  //     } else {
  //       emit(AuthFailure('An unexpected error occurred during registration'));
  //     }
  //     log(e.toString());
  //   }
  // }

// Forget Password Logic for reset password code
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

// Verify OTP Logic for user verification with email and OTP
  Future<void> verifyUserOTP(
      {required String email, required String otp}) async {
    emit(AuthLoading());
    try {
      AuthResponse response = await authRepo.verifyUserOTP(
        email: email,
        otp: otp,
      );
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
        final errorHandler = DioErrorHandler.handleError(e);
        emit(AuthFailure(errorHandler.errorMessage));
      } else {
        emit(AuthFailure(
            'An unexpected error occurred during OTP verification'));
      }
      log(e.toString());
    }
  }

  // Reset Password Logic for user password reset
  Future<void> resetUserPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      AuthResponse response = await authRepo.resetUserPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
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
        final errorHandler = DioErrorHandler.handleError(e);
        emit(AuthFailure(errorHandler.errorMessage));
      } else {
        emit(AuthFailure('An unexpected error occurred during password reset'));
      }
      log(e.toString());
    }
  }
}
