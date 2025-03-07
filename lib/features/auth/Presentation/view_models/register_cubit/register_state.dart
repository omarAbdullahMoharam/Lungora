part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponse response;
  final String? token;

  RegisterSuccess(this.response) : token = response.result?.token;
}

final class RegisterFailure extends RegisterState {
  final String errMessage;

  RegisterFailure(this.errMessage);
}
