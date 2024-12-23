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
        appBar: AppBar(
          title: Text(localization.notifications),
        ),
        body:
            BlocBuilder<ServiceCubit, ServiceStates>(
              bloc: _serviceCubit,
              buildWhen: (pre,cur){if(cur is GetNotificationError || cur is GetNotificationLoading|| cur is GetNotificationSuccess){return true;}
              return false;
              },
              builder: (context, state) {
          if (state is GetNotificationLoading) {
            return const  Center(
              child: LoadingIndicator(ColorManager.primary),
            );
          }
          else if(state is GetNotificationError){
            return Center(child: Text(state.message),);
          }
          else {
            return ListView.builder(
              itemCount: _serviceCubit.listNotification.length,
              itemBuilder: (context, index) {
                return _serviceCubit.listNotification.isEmpty?
                Center(child: Row(children: [Text(localization.noNotificationRecived),SizedBox(width: 10.w,),Icon(Icons.error_outline)],),):
                 Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorManager.grey)),
                                  child: const Icon(
                                    Icons.notifications_none,
                                    color: ColorManager.grey,
                                  ))),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _serviceCubit.listNotification[index].title??'',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    _serviceCubit.listNotification[index].description??'',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                );
              });
          }
          
        }),
      ),
    );
  }
}
