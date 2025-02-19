import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/Auth/data/models/dio_handeler.dart';
import 'package:lungora/features/Auth/data/models/handeler.dart';
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
      log('Login attempt with email: $email'); // Don't log passwords in production
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
          // You might want to automatically log in the user after registration
          // Or show a specific success message
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
}
