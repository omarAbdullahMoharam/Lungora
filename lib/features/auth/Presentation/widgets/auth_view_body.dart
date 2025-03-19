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
            SizedBox(height: 55.h),
             Center(
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey.shade100,
                      
                      child: ClipRRect(borderRadius: BorderRadius.circular(100.r),
                      child: FittedBox(
                        child: Image.asset(
                          'assets/icon/lung app OUT FONT PNG.png',
                          fit: BoxFit.cover,
                          
                        ),
                      ),),),
                  ),
            SizedBox(height: 16.h),
            Text(
              'Lungora',
              style: Styles.textStyle32.copyWith(
                fontFamily: 'Inter',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.055),
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
