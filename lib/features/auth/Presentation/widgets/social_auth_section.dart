import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/auth/Presentation/widgets/sign_in_with.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 38.5.w,
        right: 46.5.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomSignInWith(
            signInWith: () {},
            imagePath: 'assets/images/FaceIcon.png',
          ),
          SizedBox(width: 20.w),
          CustomSignInWith(
            signInWith: () {},
            imagePath: 'assets/images/GoogleIcon.png',
          ),
          SizedBox(width: 20.w),
          CustomSignInWith(
            signInWith: () {},
            imagePath: 'assets/images/TwiterIcon.png',
          ),
          SizedBox(width: 20.w),
          CustomSignInWith(
            signInWith: () {},
            imagePath: 'assets/images/Instagram.png',
          ),
        ],
      ),
    );
  }
}
