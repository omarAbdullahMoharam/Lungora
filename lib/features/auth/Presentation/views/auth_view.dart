import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/Presentation/widgets/auth_view_body.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/login_cubit/login_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/register_cubit/register_cubit.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key, isLogin = true});
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;

  void toggleAuthBody() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(getIt<AuthRepo>()),
          ),
          BlocProvider(
            create: (context) => LoginCubit(getIt<AuthRepo>()),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(getIt<AuthRepo>()),
          ),
        ],
        child: AuthViewBody(
          isLogin: isLogin,
          toggleAuthBody: toggleAuthBody,
        ),
      ),
    );
  }
}
