import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/working_hour_formatter.dart';
import 'package:lungora/core/utils/styles.dart';

class WorkingTimeItem extends StatelessWidget {
  final String day;
  final String from;
  final String to;

  const WorkingTimeItem({
    super.key,
    required this.day,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, top: 15.h),
      child: Container(
        width: 130.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : const Color.fromARGB(255, 249, 243, 243),
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 130.w,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.w),
                  topRight: Radius.circular(12.w),
                ),
              ),
              child: Center(
                child: Text(
                  day,
                  style: Styles.textStyle14.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From:',
                        style: Styles.textStyle12.copyWith(
                          color: Color(0XFF8C95A3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'To:',
                        style: Styles.textStyle12.copyWith(
                          color: Color(0XFF8C95A3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatTimeTo12Hour(timeString: from),
                        style: Styles.textStyle12.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        formatTimeTo12Hour(timeString: to),
                        style: Styles.textStyle12.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
