import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/features/auth/Presentation/widgets/auth_form.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_auth_navigator_button.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.isLogin,
    required this.toggleAuthBody,
  });
  final bool isLogin;
  final VoidCallback toggleAuthBody;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lungora',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 56.h),
          AuthForm(isLogin: isLogin),
          CustomAuthNavigatorButton(
            isLogin: isLogin,
            toggleAuthBody: toggleAuthBody,
          ),
        ],
      ),
    );
  }
}
