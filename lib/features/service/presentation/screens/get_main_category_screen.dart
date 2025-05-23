import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/main_category/data_of_item_main_category.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GetMainCategoryScreen extends StatefulWidget {
  const GetMainCategoryScreen({super.key});

  @override
  State<GetMainCategoryScreen> createState() => _GetMainCategoryScreenState();
}

class _GetMainCategoryScreenState extends State<GetMainCategoryScreen> {
  late ServiceSettingCubit _serviceCubit;
  late DrawerCubit drawerCubit;
  @override
  void initState() {
    _serviceCubit = serviceLocator.get<ServiceSettingCubit>()
      ..getAllMainCategory();
    drawerCubit = serviceLocator.get<DrawerCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
     decoration: drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
        color: ColorManager.darkBg,)
          : null,
      child: Scaffold(
        body: BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
          bloc: _serviceCubit,
          buildWhen: (pre, cur) {
            if (pre.getMainCategoryState != cur.getMainCategoryState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state.getMainCategoryState is BaseLoadingState) {
              return _dummy(theme);
            } else if (state.getMainCategoryState is BaseErrorState) {
              final message = state.getMainCategoryState as BaseErrorState;
              return ErrorNetworkWidget(
                message: message.error!,
                onTap: () {
                  _serviceCubit.getAllMainCategory();
                },
              );
            } else if (state.getMainCategoryState is BaseSuccessState) {
              final listOfMainCategory = (state.getMainCategoryState
                      as BaseSuccessState<List<DataOfItemMainCategoryEntity>>)
                  .data;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                    itemCount: listOfMainCategory!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              Routes.serviceFilterScreen,
                              arguments: _serviceCubit);
                          _serviceCubit.getServiceAndDiscount(
                              idOfCategory: listOfMainCategory[index].id);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading:
                                  listOfMainCategory[index].iconPath == null
                                      ? SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.r),
                                              child: Image.asset(
                                                  'asset/images/aaaa.png')))
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                            child: CashImage(
                                                path: listOfMainCategory[index]
                                                    .iconPath!),
                                          ),
                                        ),
                              title: Text(
                                '${listOfMainCategory[index].name}' ?? '',
                                style: theme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

Widget _dummy(TextTheme theme) {
  return Skeletonizer(
    enabled: true,
    enableSwitchAnimation: true,
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
            itemCount: 7,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: null,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.asset('asset/images/aaaa.png'))),
                      title: Text(
                        'test dymmy data test test test',
                        style: theme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              );
            })),
  );
}
