import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const String routeName = '/notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _drawerCubit = serviceLocator.get<DrawerCubit>();
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
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
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_sharp,
                          color: Theme.of(context).primaryColorLight,
                          size: 45.sp,
                        )),
                    SizedBox(
                      width: 40.w,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        localization.notifications,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
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
                      } else {
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
                                                child: Card(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 20.h),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Container(
                                                                width: 100.w,
                                                                height: 100.h,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: ColorManager
                                                                            .primary,
                                                                        width:
                                                                            2)),
                                                                child: Icon(
                                                                  Icons
                                                                      .notifications_none,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight,
                                                                ))),
                                                        Expanded(
                                                            flex: 4,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  _serviceCubit
                                                                          .listNotification[
                                                                              index]
                                                                          .title ??
                                                                      '',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                                Text(
                                                                  _serviceCubit
                                                                          .listNotification[
                                                                              index]
                                                                          .description ??
                                                                      '',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelMedium,
                                                                ),
                                                                SizedBox(
                                                                  height: 10.h,
                                                                ),
                                                              ],
                                                            ))
                                                      ],
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
