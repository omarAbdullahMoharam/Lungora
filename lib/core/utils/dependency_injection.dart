import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lungora/core/utils/api_services.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

GetIt getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => ApiServices(getIt<Dio>()));
  getIt.registerLazySingleton(() => AuthRepo(getIt<ApiServices>()));
  // getIt.registerLazySingleton(() => AuthCubit(getIt<AuthRepo>()));
  // getIt.registerLazySingleton(() => AppRouter());
  // getIt.registerLazySingleton(() => AuthBloc(getIt<AuthRepo>()));
}
