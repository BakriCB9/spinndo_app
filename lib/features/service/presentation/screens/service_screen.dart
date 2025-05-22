import 'package:app/core/routes/routes.dart';
import 'package:app/core/utils/error_location_widget.dart';
import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/features/service/presentation/screens/get_main_category_screen.dart';
import 'package:app/features/service/presentation/screens/notification_screen.dart';
import 'package:app/features/service/presentation/widgets/section_header_service_screen.dart';
import 'package:app/features/service/presentation/widgets/section_search_auto_complete.dart';
import 'package:app/features/service/presentation/widgets/section_select_country.dart';
import 'package:app/test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/screens/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServiceScreen extends StatefulWidget {
  static const String routeName = '/service';

  const ServiceScreen({super.key});

  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _serviceSettingCubit = serviceLocator.get<ServiceSettingCubit>();

  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.of(context).pushNamed(NotificationScreen.routeName);
    }
  }

  @override
  void initState() {
    _serviceSettingCubit.getCurrentLocationFilter();
    initalMessage();
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.notification?.body != null ||
          event.notification?.title != null) {
        Navigator.of(context).pushNamed(NotificationScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
          drawer: CustomDrawer(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SectionHeaderServiceScreen(),
                  SizedBox(height: 40.h),
                  Expanded(
                    child:
                        BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
                      bloc: _serviceSettingCubit,
                      buildWhen: (pre, cur) {
                        if (pre.getCurrentLocation != cur.getCurrentLocation) {
                          return true;
                        }

                        return false;
                      },
                      builder: (context, state) {
                        if (state.getCurrentLocation is BaseLoadingState) {
                          return _dummyScreen(theme, localization);
                        } else if (state.getCurrentLocation
                            is BaseSuccessState) {
                          return BlocBuilder<ServiceSettingCubit,
                              ServiceSettingState>(
                            bloc: _serviceSettingCubit,
                            buildWhen: (pre, cur) {
                              if (pre.getCountryAndCategory !=
                                  cur.getCountryAndCategory || pre.resetData!=cur.resetData) {
                                return true;
                              }
                              return false;
                            },
                            builder: (context, state) {
                              if (state.getCountryAndCategory
                                  is BaseLoadingState) {
                                return _dummyScreen(theme, localization);
                              }
                              //
                              //Error connection country and category
                              //
                              else if (state.getCountryAndCategory
                                  is BaseErrorState) {
                                final message = state.getCountryAndCategory
                                    as BaseErrorState;
                                return ErrorNetworkWidget(
                                    message: message.error.toString(),
                                    onTap: () => _serviceSettingCubit
                                        .getCountriesAndCategories());
                              }
                              //
                              //Success Conection country and category
                              //
                              else if (state.getCountryAndCategory
                                  is BaseSuccessState) {
                                return _serviceSettingCubit.categoriesList ==
                                            null ||
                                        _serviceSettingCubit.countriesList ==
                                            null
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              // Text(state.message,
                                              //     style: Theme.of(context).textTheme.bodySmall),
                                              const Icon(
                                                Icons.replay_outlined,
                                                color: ColorManager.primary,
                                              ),

                                              TextButton(
                                                onPressed: () {
                                                  _serviceSettingCubit
                                                      .getCountriesAndCategories();
                                                },
                                                child: Text(
                                                  localization.reload,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          fontSize: 30.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SectionSearchAutoComplete(serviceSettingCubit:_serviceSettingCubit),
                                              SizedBox(height: 30.h),
                                              SectionSelectCountry(
                                                  serviceCubit:
                                                      _serviceSettingCubit),
                                              Text(
                                                localization.chooseCategory,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(fontSize: 36.sp),
                                              ),
                                              SizedBox(height: 8.h),
                                              CascadingDropdowns(
                                                categories: _serviceSettingCubit
                                                    .categoriesList,
                                                isService: true,
                                              ),
                                              SizedBox(height: 10.h),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 8.h),
                                                  child: InkWell(
                                                      onTap: () {
                                                        _serviceSettingCubit
                                                            .resetAllData();
                                                      },
                                                      child: Text(
                                                          localization.resetAll,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: ColorManager
                                                                      .primary))),
                                                ),
                                              ),
                                              SizedBox(height: 60.h),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (_serviceSettingCubit.selectedCountry == null &&
                                                      _serviceSettingCubit
                                                              .selectedCategory ==
                                                          null &&
                                                      _serviceSettingCubit
                                                              .isCurrent ==
                                                          false) {
                                                    _showSnack(localization
                                                        .filterOnlocationOrCategory);
                                                    return;
                                                  }

                                                  if (_serviceSettingCubit
                                                          .selectedCategory
                                                          ?.id ==
                                                      -1) {
                                                    Navigator.of(context)
                                                        .pushNamed(Routes
                                                            .getMainCategoryScreen);
                                                    // _serviceSettingCubit
                                                    //     .getAllMainCategory();
                                                  } else {
                                                    _serviceSettingCubit
                                                        .getServiceAndDiscount();
                                                    Navigator.of(context).pushNamed(
                                                        Routes
                                                            .serviceFilterScreen,
                                                        arguments:
                                                            _serviceSettingCubit);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: const Size(
                                                      double.infinity, 48),
                                                ),
                                                child: Text(
                                                    localization.startSearch,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge),
                                              ),
                                            ],
                                          ),
                                        ));
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        }
                        //Error get Current Location
                        else if (state.getCurrentLocation is BaseErrorState) {
                          return ErrorLocationWidget(getCurrentLocation: () {
                            _serviceSettingCubit.getCurrentLocationFilter();
                          });
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _showSnack(String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        text,
        style: TextStyle(fontSize: 28.sp, color: Colors.white),
      )),
    );
  }
}

Widget _dummyScreen(ThemeData theme, AppLocalizations localizations) {
  return Skeletonizer(
    enabled: true,
    // containersColor: Colors.grey.shade400,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(),
          SizedBox(height: 30.h),
          Text(
            localizations.chooseCountry,
            style: theme.textTheme.titleMedium!
                .copyWith(fontSize: 36.sp, color: Colors.grey.shade400),
          ),
          const SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: null, child: Text('Search'))),
          SizedBox(height: 30.h),
          Row(children: [
            Text(
              localizations.currentLocation,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontSize: 30.sp, color: Colors.grey.shade400),
            ),
            const SizedBox(width: 10),
            Container(width: 20, height: 20, color: Colors.grey)
          ]),
          SizedBox(height: 30.h),
          Text(
            localizations.chooseCategory,
            style: theme.textTheme.titleMedium!
                .copyWith(fontSize: 36.sp, color: Colors.grey.shade400),
          ),
          const SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: null, child: Text('Search'))),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: InkWell(
                  onTap: null,
                  child: Text(localizations.resetAll,
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: ColorManager.primary))),
            ),
          ),
          SizedBox(height: 60.h),
          const SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: null, child: Text('Search')))
        ],
      ),
    ),
  );
}
