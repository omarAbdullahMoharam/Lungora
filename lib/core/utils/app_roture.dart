import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/features/Auth/Presentation/views/auth_view.dart';
import 'package:lungora/features/Auth/Presentation/views/forget_password_view.dart';
import 'package:lungora/features/Home/presentation/views/home_view.dart';
<<<<<<< HEAD
import 'package:lungora/features/Home/presentation/views/main_view.dart';
import 'package:lungora/features/Scan/presentation/view/scan_view.dart';
import 'package:lungora/features/Settings/presentation/view/settings_view.dart';
=======
import 'package:lungora/features/auth/Presentation/views/reset_password_view.dart';
import 'package:lungora/features/auth/Presentation/widgets/reset_password_params.dart';

import '../../features/Auth/Presentation/views/auth_view.dart' show AuthView;
>>>>>>> 63f099d5ceb36a2f543baa08186343571ad1a44d

abstract class AppRoture {
  static const kAuthView = '/';
  static const kHomeView = '/homeView';
  static const kScanView = '/cameraView';
  static const kSettingsView = '/settingsView';
  static const kForgetPassView = '/forgetPasswordView';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: kAuthView,
    routes: [
      // Auth routes
      GoRoute(
        path: kAuthView,
        builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        path: kForgetPassView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
<<<<<<< HEAD

      // Main app routes
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainView(child: child);
        },
        routes: [
          GoRoute(
            path: kHomeView,
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: kScanView,
            builder: (context, state) => const ScanView(),
          ),
          GoRoute(
            path: kSettingsView,
            builder: (context, state) => const SettingsView(),
          ),
        ],
=======
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
        builder: (context, state) {
          final params = state.extra as ResetPasswordParams;
          return ResetPasswordView(
            email: params.email,
            otp: params.otp,
          );
        },
>>>>>>> 63f099d5ceb36a2f543baa08186343571ad1a44d
      ),
    ],
  );
}
