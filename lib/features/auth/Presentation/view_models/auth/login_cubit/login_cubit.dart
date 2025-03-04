import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/dio_handeler.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      LoginResponse loginResponse = await authRepo.login(email, password);

      // TODO: Save the token and user details for future use
      if (loginResponse.isSuccess && loginResponse.result?.token != null) {
        emit(LoginSuccess(loginResponse));
      } else {
        emit(LoginFailure(loginResponse.errors.isNotEmpty
            ? loginResponse.errors[0]
            : 'Login failed'));
      }
    } catch (e) {
      if (e is DioException) {
        log('Login Dio Error - Status Code: ${e.response?.statusCode}');
        log('Response Data: ${e.response?.data}');

        DioErrorHandler.handleError(e);

        // Extract the error message from the response body
        String errorMessage = 'An unexpected error occurred';
        if (e.response?.data is Map<String, dynamic>) {
          final responseData = e.response?.data as Map<String, dynamic>;
          if (responseData.containsKey('message')) {
            errorMessage = responseData['message'].toString();
          } else if (responseData.containsKey('errors')) {
            final errors = responseData['errors'] as List<dynamic>;
            if (errors.isNotEmpty) {
              errorMessage = errors[0].toString();
            }
          }
        }

        emit(LoginFailure(errorMessage));
      } else {
        emit(LoginFailure('An unexpected error occurred'));
      }
      log(e.toString());
    }
  }
}
