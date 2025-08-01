import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/login_cubit/login_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/register_cubit/register_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';
import 'package:lungora/features/diseases/data/repo/disease_repo.dart';
import 'package:lungora/features/doctor/data/repo/doctors_repo.dart';

GetIt getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiServices(getIt<Dio>()));
  getIt.registerLazySingleton(() => AuthRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(() => RegisterCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(
      () => DoctorsRepo(apiServices: getIt<ApiServices>()));
  getIt.registerLazySingleton(() => SettingsCubit(getIt<ApiServices>()));
  getIt.registerLazySingleton(() => DiseaseRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton(() => SecureStorageService());
}
