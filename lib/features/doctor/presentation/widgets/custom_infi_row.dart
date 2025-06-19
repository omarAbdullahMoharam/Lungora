import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/url_luncher_url.dart';

class CustomInfoRow extends StatelessWidget {
  final String iconPath;
  final bool? isEmail;
  final String text;

  const CustomInfoRow({
    super.key,
    this.isEmail = false,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () {
            if (isEmail == false) {
              UrlLauncher.launchPhoneDialer(text);
            } else if (isEmail == true) {
              UrlLauncher.launchEmail(text);
            } else if (isEmail == false) {
              UrlLauncher.launchPhoneDialer(text);
            }
          },
          child: Text(
            text,
            style: Styles.textStyle14.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? kSecondaryColor
                  : kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
