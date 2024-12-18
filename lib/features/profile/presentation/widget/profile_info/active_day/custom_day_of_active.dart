import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
//import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_priofile_workingday.dart';
import 'package:app/features/profile/presentation/screens/edit_date_time.dart';
import 'package:app/main.dart';
// import 'package:app/core/const_variable.dart';

import 'box_of_from_to.dart';

class CustomDayActive extends StatelessWidget {
  final int userId;
  final int issAprrovid;
  final List<ProviderPriofileWorkingday> listOfworkday;
  const CustomDayActive(
      {required this.listOfworkday,
      required this.userId,
      required this.issAprrovid,
      super.key});

  @override
  Widget build(BuildContext context) {
    //final _authCubit = serviceLocator.get<AuthCubit>();
    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Active Days', style: Theme.of(context).textTheme.labelLarge),
            myId == userId
                ? IconButton(
                    onPressed: issAprrovid == 0
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WorkingSchedulePage(listOfworkday: listOfworkday,)));
                          }
                        : () {
                            UIUtils.showMessage(
                                "You Have to wait to Accept your Informations");
                          },
                    icon: Icon(
                      Icons.edit_calendar_outlined,
                      color: Theme.of(context).primaryColorLight,
                    ))
                : const SizedBox()
          ],
        ),
        Column(
          children: listOfworkday
              .map((e) => Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(e.day!,
                                style: Theme.of(context).textTheme.labelMedium),
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
                                time: 'From ${e.start} Am',
                                type: 1,
                              )),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                  child: BoxFromDateToDate(
                                time: 'To ${e.end} Pm',
                                type: 2,
                              ))
                            ],
                          ))
                    ],
                  )))
              .toList(),
        ),
        //    days
        //       .map((e) => Padding(
        //             padding: EdgeInsets.only(top: 10.h),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   child: Align(
        //                     alignment: Alignment.topLeft,
        //                     child: FittedBox(
        //                       fit: BoxFit.scaleDown,
        //                       child: Text(
        //                         e,
        //                         style: TextStyle(
        //                             fontSize: 25.sp, color: Colors.grey),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(width: 10.w),
        //                 Expanded(
        //                     flex: 4,
        //                     child: Row(
        //                       children: [
        //                         Expanded(
        //                             child: BoxFromDateToDate(
        //                                 time: 'From 9:00 Am', dateSelect: DateSelect(day: "day", start: "start", end: "end"), type: 1,)),
        //                         SizedBox(
        //                           width: 10.w,
        //                         ),
        //                         Expanded(
        //                             child:
        //                                 BoxFromDateToDate(time: 'To 6:00 Pm', dateSelect: DateSelect(day: "day", start: "start", end: "end"), type: 2,))
        //                       ],
        //                     ))
        //               ],
        //             ),
        //           ))
        //       .toList(),
        // ),
      ],
    );
  }
}
// List<String> days = [

// 'Thursday',
// 'Friday'
// ];
