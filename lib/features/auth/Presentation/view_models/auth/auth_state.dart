part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthResponse response;
  String? responseResult;
  AuthSuccess(this.response, {this.responseResult});
}

final class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}

final class AuthLogout extends AuthState {}

final class AuthRegister extends AuthState {}

final class AuthLogin extends AuthState {}

final class AuthResetPassword extends AuthState {}

final class AuthChangePassword extends AuthState {}

final class AuthVerifyPassword extends AuthState {}
