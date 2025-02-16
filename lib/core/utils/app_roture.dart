import 'package:go_router/go_router.dart';
import 'package:lungora/features/auth/Presentation/views/forget_password_view.dart';

import '../../features/auth/Presentation/views/auth_view.dart' show AuthView;

abstract class AppRoture {
  static const kOTP = '/OTP';
  static const kForgetPassView = '/forgetPasswordView';
  static const kAuthView = '/';
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
      //  GoRoute(
      //   path: kOTP,
      //   builder: (context, state) => OTP(email: state.extra.toString(),),
      // ),
    ],
  );
}
