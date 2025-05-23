import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_priofile_workingday.dart';
import 'package:app/features/profile/presentation/screens/edit_date_time.dart';
import 'package:app/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'box_of_from_to.dart';

class CustomDayActive extends StatelessWidget {
  final int userId;
  final bool issAprrovid;
  final List<ProviderPriofileWorkingday> listOfworkday;
  const CustomDayActive(
      {required this.listOfworkday,
      required this.userId,
      required this.issAprrovid,
      super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final drawerCubit = serviceLocator.get<DrawerCubit>();

    final myId = sharedPref.getInt(CacheConstant.userId);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(localization.activeDay,
                style: Theme.of(context).textTheme.labelLarge),
            myId == userId
                ? IconButton(
                    onPressed: issAprrovid == false
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WorkingSchedulePage(
                                      listOfworkday: listOfworkday,
                                    )));
                          }
                        : () {
                            UIUtils.showMessage(
                                "You Have to wait to Accept your Informations");
                          },
                    icon: Icon(
                      Icons.edit_calendar_outlined,
                      color:issAprrovid == false? ColorManager.grey:ColorManager.primary,
                    ))
                : const SizedBox()
          ],
        ),
        SizedBox(width: 30.h),

        Column(
          children: listOfworkday
              .map((e) => Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: drawerCubit.languageCode == 'en'
                  ? Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(e.day!,
                            style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorLight)),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text('From',style: Theme.of(context).textTheme.labelMedium),

                          BoxFromDateToDate(
                            time: ' ${e.start} ',
                            type: 1,
                          ),
                          Text('AM',style: Theme.of(context).textTheme.labelMedium),

                          SizedBox(
                            width: 50.w,
                          ),
                          Text('To',style: Theme.of(context).textTheme.labelMedium),

                          BoxFromDateToDate(
                            time: ' ${e.end} ',
                            type: 1,
                          ),
                          Text('PM',style: Theme.of(context).textTheme.labelMedium),

                        ],
                      )
                  )
                ],
              )
                  : Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                              child: BoxFromDateToDate(
                                time: 'To ${e.end} Pm',
                                type: 2,
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                              child: BoxFromDateToDate(
                                time: 'From ${e.start} Am',
                                type: 1,
                              )),
                        ],
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(e.day!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Divider(color: Colors.grey, thickness: 0.2)
                ],
              )))
              .toList(),
        ),
        SizedBox(height: 50.h),
        Divider(color: Colors.grey, thickness: 0.2)
      ],
    );
  }
}
// List<String> days = [

// 'Thursday',
// 'Friday'
// ];
