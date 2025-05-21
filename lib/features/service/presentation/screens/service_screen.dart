import 'package:app/core/resources/font_manager.dart';
import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:app/features/service/domain/entities/main_category/all_category_main_entity.dart';
import 'package:app/features/service/presentation/screens/get_main_category_screen.dart';
import 'package:app/features/service/presentation/screens/notification_screen.dart';
import 'package:app/test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/loading_indicator.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/drawer/presentation/screens/drawer.dart';
import 'package:app/features/service/data/models/get_services_request.dart';

import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:app/features/service/presentation/screens/filter_result_screen.dart';
import 'package:app/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/section_search_auto_complete.dart';

class ServiceScreen extends StatefulWidget {
  static const String routeName = '/service';

  const ServiceScreen({super.key});

  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  //final _drawerCubit = serviceLocator.get<DrawerCubit>();
  int indexCategory = 0;
  List<ChildCategory> lisChild = [];
  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      Navigator.of(context).pushNamed(NotificationScreen.routeName);
    }
  }

  // bool val=false;
  @override
  void initState() {
    initalMessage();
    _serviceCubit.getCountriesAndCategories();
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
    final String? token = sharedPref.getString(CacheConstant.tokenKey);
    final isDarkMode = _drawerCubit.themeMode == ThemeMode.dark;
    //  double _distance = _serviceCubit.selectedDistance ?? 10.0;

    return Container(
      decoration: isDarkMode
          ? const BoxDecoration(
          color: ColorManager.darkBg
      )
          : null,
      child: Scaffold(
          drawer: CustomDrawer(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Theme.of(context).primaryColorLight,
                              size: 50.sp,
                            ),
                            onPressed: () {
                              // Replace this with your shared preference or token-check logic

                              if (token == null) {
                                // UIUtils.showMessage("You have to Sign in first");
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                        title: Text(
                                          localization.note,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                              fontSize: 36.sp,
                                              color: ColorManager.greyWhite),
                                        ),
                                        content: Text(
                                          localization
                                              .youdonthaveaccountyouhavetosignin,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                localization.cancel,
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    color: ColorManager.grey2),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                localization.ok,
                                                style: TextStyle(
                                                    fontSize: 25.sp,
                                                    color: ColorManager.primary),
                                              )),
                                        ],
                                      );
                                    });
                              } else {
                                Scaffold.of(context).openDrawer();
                              }
                            },
                          );
                        },
                      ),
                      // SizedBox(width: 40.w),
                      Expanded(
                        child: FittedBox(
                          alignment: Directionality.of(context) == TextDirection.rtl
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(localization.homePage,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: FontSize.s22,fontWeight: FontWeight.w600)),
                        ),
                      ),
                      token != null
                          ? IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              SizeTransition4(
                                  const NotificationScreen()));                        },
                        icon: SvgPicture.asset(
                          'asset/icons/bell.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColorLight,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocConsumer<ServiceCubit, ServiceStates>(
                            buildWhen: (previous, current) {
                              print(
                                  'the state now from service screen is $current');
                              if (current is GetMainCategoryLoading ||
                                  current is GetMainCategoryError ||
                                  current is GetMainCategorySuccess ||
                                  current is ServiceLoading ||
                                  current is ResetSettingsState ||
                                  current is ServiceError ||
                                  current is ServiceSuccess ||
                                  current is CountryCategoryLoading ||
                                  current is CountryCategoryError ||
                                  current is CountryCategorySuccess)
                                return true;
                              return false;
                            },
                            listener: (context, state) {
                              if (state is ServiceLoading ||
                                  state is GetMainCategoryLoading) {
                                UIUtils.showLoading(context);
                              } else if (state is ServiceError ||
                                  state is GetMainCategoryError) {
                                UIUtils.hideLoading(context);
                                if (state is ServiceError) {
                                  UIUtils.showMessage(state.message);
                                } else if (state is GetMainCategoryError) {
                                  UIUtils.showMessage(state.message);
                                }
                              } else if (state is ServiceSuccess ||
                                  state is GetMainCategorySuccess) {
                                UIUtils.hideLoading(context);
                                if (state is GetMainCategorySuccess) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          GetMainCategoryScreen()));
                                } else if (state is ServiceSuccess) {
                                  // print('we jump in service Screen now ###################################');
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return FilterResultScreen(
                                        services: state.services,
                                      );
                                    },
                                  ));
                                }
                              }
                            },
                            bloc: _serviceCubit,
                            builder: (context, state) {
                              if (state is CountryCategoryLoading) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: LoadingIndicator(
                                        Theme.of(context).primaryColor),
                                  ),
                                );
                              } else if (state is CountryCategoryError) {
                                return SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height / 1.2,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        // Text(state.message,
                                        //     style: Theme.of(context).textTheme.bodySmall),
                                        const Icon(
                                          Icons.replay_outlined,
                                          color: ColorManager.primary,
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            _serviceCubit
                                                .getCountriesAndCategories();
                                          },
                                          child: Text(
                                            localization.reload,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(fontSize: 30.sp),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return _serviceCubit.categoriesList == null ||
                                    _serviceCubit.countriesList == null
                                    ? SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      1.2,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        // Text(state.message,
                                        //     style: Theme.of(context).textTheme.bodySmall),
                                        const Icon(
                                          Icons.replay_outlined,
                                          color: ColorManager.primary,
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            _serviceCubit
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
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SectionSearchAutoComplete(),
                                        // CustomTextFormField(
                                        //   icon: Icons.search,
                                        //   controller: _serviceCubit
                                        //       .searchController,
                                        //   hintText: localization
                                        //       .serviceOrProviderName,
                                        //   padding: 20.w,
                                        // ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        BlocBuilder<ServiceCubit,
                                            ServiceStates>(
                                          bloc: _serviceCubit,
                                          buildWhen: (previous, current) {
                                            if (current
                                            is IsCurrentLocation ||
                                                current
                                                is SelectedCountryCityServiceState)
                                              return true;
                                            return false;
                                          },
                                          builder: (context, state) {
                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  localization
                                                      .chooseCountry,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                      fontSize: 36.sp),
                                                ),
                                                SizedBox(height: 8.h),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 8,
                                                              offset: Offset(0, 4),
                                                            ),
                                                          ],
                                                        ),
                                                        child: DropdownButtonFormField<Countries>(
                                                          icon: SvgPicture.asset(
                                                            'asset/icons/drop_down.svg',
                                                            width: 24,
                                                            height: 24,
                                                            colorFilter: ColorFilter.mode(
                                                              _serviceCubit.selectedCountry != null
                                                                  ? (theme.textTheme.labelMedium?.color ?? ColorManager.textColorLight)
                                                                  : Colors.amber, // قبل الاختيار
                                                              BlendMode.srcIn,
                                                            ),
                                                          ),
                                                          dropdownColor: Theme.of(context).primaryColorDark,
                                                          hint: Text(
                                                            localization.country,
                                                            style: Theme.of(context).textTheme.labelMedium,
                                                          ),
                                                          menuMaxHeight: 200,
                                                          decoration: const InputDecoration(
                                                            errorBorder: InputBorder.none,
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                          ),
                                                          value: _serviceCubit.selectedCountry,
                                                          items: _serviceCubit.countriesList!
                                                              .map((e) => DropdownMenuItem<Countries>(
                                                            value: e,
                                                            child: Text(
                                                              e.name,
                                                              style: Theme.of(context).textTheme.displayMedium,
                                                            ),
                                                          ))
                                                              .toList(),
                                                          onChanged: (value) {
                                                            _serviceCubit.selectedDistance = null;
                                                            _serviceCubit.isCity = false;
                                                            _serviceCubit.isCurrent = false;
                                                            _serviceCubit.selectedCity = null;
                                                            _serviceCubit.citiesList?.clear();
                                                            _serviceCubit.selectedCountryService(value!);
                                                          },
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                _serviceCubit.selectedCountryId !=
                                                    null &&
                                                    _serviceCubit
                                                        .selectedCountryId !=
                                                        -1
                                                    ? Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    SizedBox(
                                                        height: 30.h),
                                                    Text(
                                                      localization
                                                          .chooseCity,
                                                      textAlign:
                                                      TextAlign
                                                          .start,
                                                      style:
                                                      theme.textTheme.titleMedium!.copyWith(fontSize: 32.sp),
                                                    ),
                                                    SizedBox(
                                                        height: 8.h),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(12),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.black.withOpacity(0.1),
                                                                  blurRadius: 8,
                                                                  offset: Offset(0, 4),
                                                                ),
                                                              ],
                                                            ),
                                                            child: DropdownButtonFormField<Cities>(
                                                              dropdownColor: Theme.of(context).primaryColorDark,
                                                              hint: Text(
                                                                localization.city,
                                                                style: theme.textTheme.labelMedium,
                                                              ),
                                                              icon: SvgPicture.asset(
                                                                'asset/icons/drop_down.svg',
                                                                width: 24,
                                                                height: 24,
                                                                colorFilter: ColorFilter.mode(
                                                                  _serviceCubit.selectedCity == null
                                                                      ? Colors.amber // قبل اختيار المدينة
                                                                      : Colors.black, // بعد اختيار المدينة
                                                                  BlendMode.srcIn,
                                                                ),
                                                              ),
                                                              value: _serviceCubit.selectedCity,
                                                              menuMaxHeight: 200,
                                                              decoration: const InputDecoration(
                                                                errorBorder: InputBorder.none,
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                              ),
                                                              items: _serviceCubit.citiesList
                                                                  ?.map((e) => DropdownMenuItem<Cities>(
                                                                value: e,
                                                                child: Text(
                                                                  e.name,
                                                                  style: Theme.of(context).textTheme.displayMedium,
                                                                ),
                                                              ))
                                                                  .toList(),
                                                              onChanged: (value) {
                                                                _serviceCubit.isCity = true;
                                                                _serviceCubit.selectedCityService(value!);
                                                              },
                                                            )

                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                                    : const SizedBox()
                                              ],
                                            );
                                          },
                                        ),
                                        SizedBox(height: 30.h),
                                        BlocBuilder<ServiceCubit, ServiceStates>(
                                          bloc: _serviceCubit,
                                          buildWhen: (previous, current) {
                                            return current is SelectedCountryCityServiceState || current is IsCurrentLocation;
                                          },
                                          builder: (context, state) {
                                            return GestureDetector(
                                              onTap: () {
                                                final newValue = !_serviceCubit.isCurrent;
                                                _serviceCubit.chooseCurrentLocation(newValue);
                                                _serviceCubit.selectedDistance = 10;
                                                _serviceCubit.isCity = true;
                                                _serviceCubit.selectedCountryName = null;
                                                _serviceCubit.selectedCountryId = null;
                                                _serviceCubit.selectedCountry = null;
                                                _serviceCubit.selectedCityName = null;
                                                _serviceCubit.selectedCityId = null;
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(milliseconds: 300),
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                decoration: BoxDecoration(
                                                  color: _serviceCubit.isCurrent
                                                      ? Colors.amber.shade100
                                                      : isDarkMode ? ColorManager.darkTextFieldBg : Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: _serviceCubit.isCurrent
                                                        ? Colors.amber
                                                        : isDarkMode ? ColorManager.textColorLight : Colors.grey.shade300,
                                                    width: 1.5,
                                                  ),
                                                  boxShadow: _serviceCubit.isCurrent
                                                      ? [
                                                    BoxShadow(
                                                      color: Colors.amber.withOpacity(0.3),
                                                      blurRadius: 6,
                                                      offset: Offset(0, 3),
                                                    )
                                                  ]
                                                      : [],
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      _serviceCubit.isCurrent ? Icons.check_circle : Icons.location_on_outlined,
                                                      color: _serviceCubit.isCurrent ? Colors.amber : Colors.grey,
                                                    ),
                                                    SizedBox(width: 12),
                                                    Text(
                                                      localization.currentLocation,
                                                      style: theme.textTheme.labelMedium?.copyWith(
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 30.h),
                                        AnimatedSize(
                                          alignment: Alignment.topCenter,
                                          duration: const Duration(
                                              milliseconds: 500),
                                          child: BlocBuilder<ServiceCubit,
                                              ServiceStates>(
                                            bloc: _serviceCubit,
                                            buildWhen: (previous, current) {
                                              if (current
                                              is DistanceSelectUpdate ||
                                                  // current
                                                  //     is GetCurrentLocationFilterSuccess ||
                                                  current
                                                  is IsCurrentLocation ||
                                                  current
                                                  is SelectedCountryCityServiceState)
                                                return true;
                                              return false;
                                            },
                                            builder: (context, state) {
                                              return (_serviceCubit
                                                  .isCurrent !=
                                                  false &&
                                                  _serviceCubit
                                                      .selectedCountryId ==
                                                      null)
                                                  ? Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                      localization
                                                          .distance,
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .displayMedium),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Slider(
                                                    activeColor: Theme
                                                        .of(context)
                                                        .primaryColor,
                                                    inactiveColor: _drawerCubit
                                                        .themeMode ==
                                                        ThemeMode
                                                            .dark
                                                        ? Theme.of(
                                                        context)
                                                        .primaryColorLight
                                                        : Colors.grey
                                                        .shade300,
                                                    value: _serviceCubit
                                                        .selectedDistance!,
                                                    min: 0,
                                                    max: 25,
                                                    divisions: 5,
                                                    label:
                                                    "${_serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                                                    onChanged:
                                                        (value) {
                                                      _serviceCubit
                                                          .distanceSelect(
                                                          value);
                                                    },
                                                  ),
                                                  Text(
                                                      "${_serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .displayMedium),
                                                  SizedBox(
                                                      height: 16.h),
                                                ],
                                              )
                                                  : const SizedBox();
                                            },
                                          ),
                                        ),
                                        Text(
                                          localization.chooseCategory,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 36.sp),
                                        ),
                                        SizedBox(height: 8.h),
                                        BlocBuilder<ServiceCubit,
                                            ServiceStates>(
                                          bloc: _serviceCubit,
                                          buildWhen: (previous, current) {
                                            if (current
                                            is SelectedCategoryServiceState)
                                              return true;
                                            else
                                              return false;
                                          },
                                          builder: (context, state) {
                                            return CascadingDropdowns(
                                              categories: _serviceCubit
                                                  .categoriesList,
                                              isService: true,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional
                                              .centerEnd,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 8.h),
                                            child: InkWell(
                                                onTap: () {
                                                  _serviceCubit
                                                      .resetSetting();
                                                },
                                                child: Text(
                                                    localization.resetAll,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                        color: ColorManager
                                                            .primary,fontSize: FontSize.s16))),
                                          ),
                                        ),
                                        SizedBox(height: 60.h),
                                        ElevatedButton(
                                          onPressed: () {
                                            if ((_serviceCubit.selectedCountryId ==
                                                null ||
                                                _serviceCubit
                                                    .selectedCountryId ==
                                                    -1) &&
                                                _serviceCubit.isCurrent ==
                                                    false &&
                                                (_serviceCubit
                                                    .selectedCategory ==
                                                    null ||
                                                    _serviceCubit
                                                        .selectedCategory
                                                        ?.id ==
                                                        -1)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                      localization
                                                          .filterOnlocationOrCategory,
                                                      style: TextStyle(
                                                          fontSize: 28.sp,
                                                          color: Colors.white),
                                                    )),
                                              );
                                              return;
                                            }
                                            if (_serviceCubit
                                                .selectedCategory?.id ==
                                                -1) {
                                              _serviceCubit
                                                  .getAllMainCategory();
                                            } else {
                                              _serviceCubit.getServiceAndDiscount(GetServicesRequest(
                                                  categoryId: _serviceCubit.selectedCategory?.id == -1
                                                      ? null
                                                      : _serviceCubit
                                                      .selectedCategory
                                                      ?.id,
                                                  cityId: _serviceCubit.selectedCityId == -1
                                                      ? null
                                                      : _serviceCubit
                                                      .selectedCityId,
                                                  countryId: _serviceCubit.selectedCountryId == -1
                                                      ? null
                                                      : _serviceCubit
                                                      .selectedCountryId,
                                                  latitude: _serviceCubit
                                                      .getCurrentLocation
                                                      ?.latitude,
                                                  longitude: _serviceCubit
                                                      .getCurrentLocation
                                                      ?.longitude,
                                                  radius: _serviceCubit.isCurrent == true
                                                      ? _serviceCubit
                                                      .selectedDistance
                                                      ?.toInt()
                                                      : null,
                                                  search: _serviceCubit.searchController.text.isEmpty
                                                      ? null
                                                      : _serviceCubit.searchController.text));
                                              // print(
                                              //     'the id of selected category is ${_serviceCubit.selectedCategory!.id}');
                                              // print(
                                              //     'the value of distance is ${_serviceCubit.searchController.text}');
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(double.infinity, 48),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(36),
                                          ),                                          ),
                                          child: Text(
                                              localization.startSearch,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                        ),
                                      ],
                                    ));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class SizeTransition4 extends PageRouteBuilder {
  final Widget page;
  SizeTransition4(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      final _drawerCubit = serviceLocator.get<DrawerCubit>();

      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return Align(
        alignment: _drawerCubit.languageCode == 'en' ||
            _drawerCubit.languageCode == 'de'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}
