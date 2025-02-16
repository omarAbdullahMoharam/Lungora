import 'package:flutter/material.dart';
import 'package:lungora/features/Auth/Presentation/widgets/auth_view_body.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

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
      body: AuthViewBody(
        isLogin: isLogin,
        toggleAuthBody: toggleAuthBody,
      ),
    );
  }
}
