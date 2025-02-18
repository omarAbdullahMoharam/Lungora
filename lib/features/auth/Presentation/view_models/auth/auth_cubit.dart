import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
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
      AuthResponse response = await authRepo.login(email, password);
      if (response.isSuccess) {
        emit(AuthSuccess(response));
      } else if (response.errors.isNotEmpty) {
        log(response.errors[0].toString());
        emit(AuthFailure(response.errors[0].toString()));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password,
      String confirmPassword) async {
    emit(AuthLoading());
    try {
      await authRepo.register(name, email, password, confirmPassword);
      emit(AuthRegister());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  // Future<void> logout() async {
  //   emit(AuthLoading());
  //   try {
  //     await authRepo.logout();
  //     emit(AuthLogout());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
  // Future<void> resetPassword(String email) async {
  //   emit(AuthLoading());
  //   try {
  //     await authRepo.resetPassword(email);
  //     emit(AuthResetPassword());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
  // Future<void> changePassword(String email, String password) async {
  //   emit(AuthLoading());
  //   try {
  //     await authRepo.changePassword(email, password);
  //     emit(AuthChangePassword());
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }
}
