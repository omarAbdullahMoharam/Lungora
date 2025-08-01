import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/working_time_model.dart';
import 'working_time_item.dart';

class WorkingTimeList extends StatelessWidget {
  final List<WorkingHours> workingTime;
  // Time
  // final List<WorkingTime> workingTime;

  const WorkingTimeList({
    super.key,
    required this.workingTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: workingTime.length,
        itemBuilder: (context, index) {
          final item = workingTime[index];
          return WorkingTimeItem(
            day: item.dayOfWeek,
            from: item.startTime,
            to: item.endTime,
          );
        },
      ),
    );
  }
}
