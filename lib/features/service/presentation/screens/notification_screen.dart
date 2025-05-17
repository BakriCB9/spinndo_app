import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/features/service/presentation/widgets/section_card_of_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const String routeName = '/notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  final _serviceCubit = serviceLocator.get<ServiceSettingCubit>();
  @override
  void initState() {
    super.initState();
    _serviceCubit.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child:
                    SvgPicture.asset(
                      'asset/icons/back.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        ColorManager.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Directionality.of(context) == TextDirection.rtl
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      localization.notifications,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
                SizedBox(height: 40.h),
            BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
              bloc: _serviceCubit,
              builder: (context, state) {
                if (state.getAllNotificationState is BaseLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: LoadingIndicator(ColorManager.primary),
                    ),
                  );
                } else if (state.getAllNotificationState is BaseErrorState) {
                  return Expanded(
                    child: ErrorNetworkWidget(
                      message: (state.getAllNotificationState as BaseErrorState).error!,
                      onTap: () {
                        _serviceCubit.getAllNotification();
                      },
                    ),
                  );
                } else if (state.getAllNotificationState is BaseSuccessState) {
                  final listNotification = (state.getAllNotificationState
                  as BaseSuccessState<List<Notifications>>)
                      .data;

                  if (listNotification == null || listNotification.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(localization.noNotificationRecived),
                            SizedBox(width: 10.w),
                            const Icon(Icons.error_outline),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: listNotification.length,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        itemBuilder: (context, index) {
                          final item = listNotification[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
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
                                EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
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
                                    item.title ?? '',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.textColor,
                                      fontSize: 30.sp,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  item.description?? '',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey.shade600,
                                    fontSize: 28.sp,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )

            ],
            ),
          ),
        ),
      ),
    );
  }
}



// AnimationConfiguration.staggeredList(
//                                           position: index,
//                                           delay:const  Duration(milliseconds: 200),
//                                           child: SlideAnimation(
//                                             duration:
//                                                const  Duration(milliseconds: 2500),
//                                             curve:
//                                                 Curves.fastLinearToSlowEaseIn,
//                                             child: FadeInAnimation(
//                                               curve:
//                                                   Curves.fastLinearToSlowEaseIn,
//                                               duration: const Duration(
//                                                   milliseconds: 3000),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20.w,
//                                                     vertical: 10.h),
//                                                 child: Card(
//                                                   child: Container(
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal: 20.w,
//                                                             vertical: 20.h),
//                                                     child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                             child: Container(
//                                                                 width: 100.w,
//                                                                 height: 100.h,
//                                                                 decoration: BoxDecoration(
//                                                                     shape: BoxShape
//                                                                         .circle,
//                                                                     border: Border.all(
//                                                                         color: ColorManager
//                                                                             .primary,
//                                                                         width:
//                                                                             2)),
//                                                                 child: Icon(
//                                                                   Icons
//                                                                       .notifications_none,
//                                                                   color: Theme.of(
//                                                                           context)
//                                                                       .primaryColorLight,
//                                                                 ))),
//                                                         Expanded(
//                                                             flex: 4,
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 Text(
//                                                                   listNotification[
//                                                                               index]
//                                                                           .title ??
//                                                                       '',
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .labelLarge,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 10.h,
//                                                                 ),
//                                                                 Text(
//                                                                   listNotification[
//                                                                               index]
//                                                                           .description ??
//                                                                       '',
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .labelMedium,
//                                                                 ),
//                                                                 SizedBox(
//                                                                     height:
//                                                                         10.h),
//                                                               ],
//                                                             ))
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ));