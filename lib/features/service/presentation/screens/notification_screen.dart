import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/core/widgets/custom_appbar.dart';
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
  final drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [

              CustomAppbar(appBarText: localization.notifications,),
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
                    } else if (state.getAllNotificationState
                        is BaseErrorState) {
                      return Expanded(
                        child: ErrorNetworkWidget(
                            message: (state.getAllNotificationState
                                    as BaseErrorState)
                                .error!,
                            onTap: () {
                              _serviceCubit.getAllNotification();
                            }),
                      );
                    } else if (state.getAllNotificationState
                        is BaseSuccessState) {
                      final listNotification = (state.getAllNotificationState
                              as BaseSuccessState<List<Notifications>>)
                          .data;
                      return Expanded(
                        child: AnimationLimiter(
                          child: ListView.builder(
                              itemCount: listNotification!.length,
                              itemBuilder: (context, index) {
                                return listNotification.isEmpty
                                    ? Center(
                                        child: Row(
                                          children: [
                                            Text(localization
                                                .noNotificationRecived),
                                            SizedBox(width: 10.w),
                                            const Icon(Icons.error_outline)
                                          ],
                                        ),
                                      )
                                    : SectionCardOfNotification(
                                        index: index,
                                        notificationItem:
                                            listNotification[index],
                                      );
                              }),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

