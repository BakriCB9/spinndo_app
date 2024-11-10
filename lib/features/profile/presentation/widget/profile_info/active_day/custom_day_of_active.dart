import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/features/auth/data/models/register_service_provider_request.dart';
import 'package:snipp/features/profile/presentation/screens/edit_date_time.dart';
import 'package:snipp/core/const_variable.dart';

import 'box_of_from_to.dart';

class CustomDayActive extends StatelessWidget {
  const CustomDayActive({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Days',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WorkingSchedulePage()));
                },
                icon: Icon(Icons.edit_calendar_outlined))
          ],
        ),
        Column(
          children: days
              .map((e) => Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                    child: BoxFromDateToDate(
                                        time: 'From 9:00 Am', dateSelect: DateSelect(day: "day", start: "start", end: "end"), type: 1,)),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                    child:
                                        BoxFromDateToDate(time: 'To 6:00 Pm', dateSelect: DateSelect(day: "day", start: "start", end: "end"), type: 2,))
                              ],
                            ))
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
// List<String> days = [

// 'Thursday',
// 'Friday'
// ];
