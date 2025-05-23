import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SectionCardOfNotification extends StatefulWidget {
  final int index;
  final Notifications notificationItem;
  const SectionCardOfNotification(
      {required this.index, required this.notificationItem, super.key});

  @override
  State<SectionCardOfNotification> createState() => _SectionCardOfNotificationState();
}

class _SectionCardOfNotificationState extends State<SectionCardOfNotification> {
  final drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: widget.index,
        delay: const Duration(milliseconds: 200),
        child: SlideAnimation(
          duration: const Duration(milliseconds: 2500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: FadeInAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 3000),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Container(
                decoration: BoxDecoration(
                  color:drawerCubit.themeMode == ThemeMode.dark?ColorManager.darkTextFieldBg:ColorManager.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 36.h),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        color: ColorManager.primary,
                        size: 48.sp,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.notificationItem.title ?? '',
                      style: Theme.of(context).listTileTheme.titleTextStyle,                                   ),
                  ),
                  subtitle: Text(
                    widget.notificationItem.description?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorManager.grey,
                      fontSize: 28.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
              ),
            ),
          ),
        ));
  }
}
