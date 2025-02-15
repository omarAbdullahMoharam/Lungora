import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  //🫵🫵🫵will change fontFamily with copywith Inter || Montserrat
  static var textStyle32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontFamily: 'DMSans',
  );

  static var textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'DMSans',
  );

  static var textStyle20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'DMSans',
  );

  static var textStyle16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700, //sometimes  400 || 500
    fontFamily: 'DMSans',
  );

  static var textStyle14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700, //sometimes  600
    fontFamily: 'DMSans',
  );
  static var textStyle12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'DMSans',
  );
}
