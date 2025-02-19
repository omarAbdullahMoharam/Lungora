import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/Auth/Presentation/widgets/auth_view_body.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

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
      body: BlocProvider(
        create: (context) => AuthCubit(getIt<AuthRepo>()),
        child: AuthViewBody(
          isLogin: isLogin,
          toggleAuthBody: toggleAuthBody,
        ),
      ),
    );
  }
}
