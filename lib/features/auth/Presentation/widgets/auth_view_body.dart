import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Auth/Presentation/widgets/auth_form.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_auth_navigator_button.dart';

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
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lungora',
              style: Styles.textStyle32.copyWith(
                fontFamily: 'Inter',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
