import 'package:flutter/material.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_button.dart';

class CustomAuthNavigatorButton extends StatelessWidget {
  const CustomAuthNavigatorButton({
    super.key,
    required this.isLogin,
    required this.toggleAuthBody,
  });
  final VoidCallback toggleAuthBody;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (isLogin) ...[
          Text('Don\'t have an account?'),
          CustomTextButton(
            text: 'Sign Up',
            onPressed: toggleAuthBody,
          ),
        ],
        if (!isLogin) ...[
          Text('Already have an account?'),
          CustomTextButton(
            text: 'Login',
            onPressed: toggleAuthBody,
          ),
        ],
      ],
    );
  }
}
