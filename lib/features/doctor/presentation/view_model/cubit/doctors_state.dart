part of 'doctors_cubit.dart';

abstract class GetDoctorsState extends Equatable {
  const GetDoctorsState();

  @override
  List<Object?> get props => [];
}

class GetDoctorsInitial extends GetDoctorsState {}

class GetDoctorsLoading extends GetDoctorsState {}

class GetDoctorsSuccess extends GetDoctorsState {
  final List<DoctorModel> doctorsList;
  final bool isLocationBased;

  const GetDoctorsSuccess({
    required this.doctorsList,
    this.isLocationBased = false,
  });

  @override
  List<Object?> get props => [doctorsList, isLocationBased];
}

class GetDoctorsLocationSuccess extends GetDoctorsState {
  final List<DoctorModel> doctorsList;
  final ({double latitude, double longitude}) userLocation;
  final bool isLocationBased;

  const GetDoctorsLocationSuccess({
    required this.doctorsList,
    required this.userLocation,
    this.isLocationBased = true,
  });

  @override
  List<Object?> get props => [doctorsList, userLocation, isLocationBased];
}

class GetDoctorsEmpty extends GetDoctorsState {}

class GetDoctorsFailure extends GetDoctorsState {
  final String errMessage;

  const GetDoctorsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class GetDoctorDetailsSuccess extends GetDoctorsState {
  final DoctorDetailsModel doctorDetails;

  const GetDoctorDetailsSuccess({required this.doctorDetails});

  @override
  List<Object?> get props => [doctorDetails];
}

class GetDoctorDetailsFailure extends GetDoctorsState {
  final String errMessage;

  const GetDoctorDetailsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
// class GetDoctorsNoInternet extends GetDoctorsState {
//   final String errMessage;

//   const GetDoctorsNoInternet({required this.errMessage});

//   @override
//   List<Object?> get props => [errMessage];
// }
