import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/Presentation/views/auth_view.dart';
import 'package:lungora/features/Auth/Presentation/views/forget_password_view.dart';
import 'package:lungora/features/Auth/Presentation/widgets/reset_password_params.dart';
import 'package:lungora/features/Chat/presentation/view/chat_view.dart';
import 'package:lungora/features/Home/presentation/views/home_view.dart';
import 'package:lungora/features/Settings/presentation/view/about_us/presentation/views/about_us_view_.dart';
import 'package:lungora/features/Settings/presentation/view/change_password/views/change_password_view.dart';
import 'package:lungora/features/Settings/presentation/view/contact_us/presentation/views/contact_us_view.dart';
import 'package:lungora/features/Settings/presentation/view/edit_profile/presentation/views/edit_profile_view.dart';
import 'package:lungora/features/Settings/presentation/view/privacy/presentation/view/privacy_view.dart';
import 'package:lungora/features/Settings/presentation/view/terms_conditions/views/terms_conditions_view.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/auth/Presentation/views/reset_password_view.dart';

import 'package:lungora/features/Home/presentation/views/main_view.dart';
import 'package:lungora/features/Scan/presentation/view/scan_view.dart';
import 'package:lungora/features/Settings/presentation/view/settings_view.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import '../../features/Auth/Presentation/views/auth_view.dart' show AuthView;

abstract class AppRoture {
  static const kAuthView = '/';
  static const kHomeView = '/homeView';
  static const kScanView = '/cameraView';
  static const kSettingsView = '/settingsView';
  static const kForgetPassView = '/forgetPasswordView';
  static const kResetPassView = '/resetPassView';
  static const kEditProfile = '/editProfile';
  static const kPrivacyView = '/privacyView';
  static const kTermsConditionsView = '/termsConditionsView';
  static const kContactUsView = '/contactUsView';
  static const kAboutUsView = '/aboutUsView';
  static const kChangePasswordView = '/changePasswordView';
  static const kChatView = '/chatView';
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
      ),

      GoRoute(
        path: kAuthView,
        builder: (context, state) => AuthView(
          isLogin: true,
        ),
      ),
      GoRoute(
        path: kAuthView,
        builder: (context, state) => AuthView(
          isLogin: false,
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: kChatView,
        builder: (context, state) => const ChatView(),
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
      ),
      GoRoute(
        path: kEditProfile,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: kPrivacyView,
        builder: (context, state) => const PrivacyView(),
      ),
      GoRoute(
        path: kChangePasswordView,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(getIt<AuthRepo>()),
          child: const ChangePasswordView(),
        ),
      ),
      GoRoute(
        path: kTermsConditionsView,
        builder: (context, state) => const TermsConditionsView(),
      ),
      GoRoute(
        path: kContactUsView,
        builder: (context, state) => const ContactUsView(),
      ),
      GoRoute(
        path: kAboutUsView,
        builder: (context, state) => const AboutUsView(),
      ),
    ],
  );
}
