import 'package:go_router/go_router.dart';
import 'package:lungora/features/Auth/Presentation/views/forget_password_view.dart';
import 'package:lungora/features/Home/presentation/views/home_view.dart';

import '../../features/Auth/Presentation/views/auth_view.dart' show AuthView;

abstract class AppRoture {
  static const kForgetPassView = '/forgetPasswordView';
  static const kAuthView = '/';
  static const kHomeView = '/homeView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kResetPassView = '/resetPassword';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kAuthView,
        builder: (context, state) => AuthView(),
      ),
      GoRoute(
        path: kForgetPassView,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => AuthView(
          isLogin: true,
        ),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => AuthView(
          isLogin: false,
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: kResetPassView,
        builder: (context, state) => HomeView(),
      ),
    ],
  );
}
