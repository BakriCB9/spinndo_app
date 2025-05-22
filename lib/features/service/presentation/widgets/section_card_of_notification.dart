import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SectionCardOfNotification extends StatelessWidget {
  final int index;
  final Notifications notificationItem;
  const SectionCardOfNotification(
      {required this.index, required this.notificationItem, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: index,
        delay: const Duration(milliseconds: 200),
        child: SlideAnimation(
          duration: const Duration(milliseconds: 2500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: FadeInAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 3000),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Card(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ColorManager.primary, width: 2)),
                              child: Icon(
                                Icons.notifications_none,
                                color: Theme.of(context).primaryColorLight,
                              ))),
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationItem.title ?? '',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                notificationItem.description ?? '',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
