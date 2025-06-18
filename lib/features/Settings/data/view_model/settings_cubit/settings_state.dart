part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsSuccess extends SettingsState {
  final String message;
  SettingsSuccess(this.message);
}

final class SettingsGetUserDataSuccess extends SettingsState {
  final UserModel userModel;
  SettingsGetUserDataSuccess(this.userModel);
}
final class SettingsFailure extends SettingsState {
  final String errMessage;
  SettingsFailure(this.errMessage);
}

