import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth/login_cubit/login_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth/login_cubit/register_cubit/register_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiServices(getIt<Dio>()));
  getIt.registerLazySingleton(() => AuthRepo(getIt<ApiServices>()));
  getIt.registerLazySingleton(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(() => RegisterCubit(getIt<AuthRepo>()));

  // getIt.registerLazySingleton(() => AppRouter());
  // getIt.registerLazySingleton(() => AuthBloc(getIt<AuthRepo>()));
}
