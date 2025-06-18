part of 'get_doctors_cubit.dart';

sealed class GetDoctorsState extends Equatable {
  const GetDoctorsState();

  @override
  List<Object> get props => [];
}

final class GetDoctorsInitial extends GetDoctorsState {}

final class GetDoctorsLoading extends GetDoctorsState {}

final class GetDoctorsSuccess extends GetDoctorsState {
  final List<DoctorModel> doctorsList;

  const GetDoctorsSuccess({required this.doctorsList});

  @override
  List<Object> get props => [doctorsList];
}

final class GetDoctorsFailure extends GetDoctorsState {
  final String errMessage;

  const GetDoctorsFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

final class GetDoctorsEmpty extends GetDoctorsState {
  const GetDoctorsEmpty();
}
