import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';

class SuccessDialog {
  static void show(BuildContext context, {void Function()? onPressed}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 5), () {
          if (context.mounted) {
            if (onPressed != null) {
              onPressed();
            } else {
              GoRouter.of(context).go(AppRouter.kAuthView);
            }
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.h),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(51, 0, 0, 0),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icon/Success.svg'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    "Congratulation",
                    textAlign: TextAlign.center,
                    style: Styles.textStyle20,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    "Successfully Completed the Process",
                    textAlign: TextAlign.center,
                    style: Styles.textStyle14.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// SuccessDialog.show(context);
