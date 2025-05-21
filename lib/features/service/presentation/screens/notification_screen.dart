import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
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
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  final drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  void initState() {
    super.initState();
    _serviceCubit.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final isDarkMode = drawerCubit.themeMode == ThemeMode.dark;

    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: Scaffold(

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                CustomAppbar(appBarText: localization.notifications,),
                SizedBox(height: 40.h),
            BlocBuilder<ServiceCubit, ServiceStates>(
              bloc: _serviceCubit,
              buildWhen: (pre, cur) {
                if (cur is GetNotificationError ||
                    cur is GetNotificationLoading ||
                    cur is GetNotificationSuccess) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is GetNotificationLoading) {
                  return const Expanded(
                    child: Center(
                      child: LoadingIndicator(ColorManager.primary),
                    ),
                  );
                } else if (state is GetNotificationError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.replay_outlined,
                          color: ColorManager.primary,
                        ),
                        TextButton(
                            onPressed: () {
                              _serviceCubit.getAllNotification();
                            },
                            child: Text(
                              localization.reload,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 30.sp),
                            )),
                      ],
                    ),
                  );
                } else
                  {
                    return Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount:
                            _serviceCubit.listNotification.length,
                            itemBuilder: (context, index) {
                              return _serviceCubit.listNotification.isEmpty
                                  ? Center(
                                child: Row(
                                  children: [
                                    Text(localization
                                        .noNotificationRecived),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Icon(Icons.error_outline)
                                  ],
                                ),
                              )
                                  : AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 200),
                                  child: SlideAnimation(
                                    duration:
                                    Duration(milliseconds: 2500),
                                    curve:
                                    Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                      curve:
                                      Curves.fastLinearToSlowEaseIn,
                                      duration:
                                      Duration(milliseconds: 3000),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w,
                                            vertical: 10.h),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:isDarkMode?ColorManager.darkTextFieldBg:ColorManager.white,
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
                                                _serviceCubit
                                                    .listNotification[
                                                index].title ?? '',
                                                style: Theme.of(context).listTileTheme.titleTextStyle,                                   ),
                                            ),
                                            subtitle: Text(
                                              _serviceCubit
                                                  .listNotification[
                                              index].description?? '',
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
                            }),
                      ),
                    );
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