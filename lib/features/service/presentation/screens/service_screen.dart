import 'package:app/core/widgets/custom_text_form_field.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:app/features/service/presentation/screens/notification_screen.dart';
import 'package:app/test.dart';
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
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';
import 'package:app/features/service/presentation/screens/filter_result_screen.dart';
import 'package:app/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  // bool val=false;
  @override
  void initState() {
    _serviceCubit.getCountriesAndCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    final String? token = sharedPref.getString(CacheConstant.tokenKey);
    //  double _distance = _serviceCubit.selectedDistance ?? 10.0;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ?const  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
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
                                        fontSize: 36.sp, color: Colors.red),
                              ),
                              content: Text(
                                localization.youdonthaveaccountyouhavetosignin,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      localization.cancel,
                                      style: TextStyle(
                                          fontSize: 25.sp, color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      localization.ok,
                                      style: TextStyle(
                                          fontSize: 25.sp, color: Colors.green),
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
            actions: [
             token!=null? IconButton(
                  onPressed: () {Navigator.of(context).pushNamed(NotificationScreen.routeName);},
                  icon: const Icon(Icons.notifications_none_outlined)):const  SizedBox()
            ],
            title: Text(
              localization.searchSetting,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<ServiceCubit, ServiceStates>(
                  buildWhen: (previous, current) {
                    if (current is ServiceLoading ||
                        current is ResetSettingsState ||
                        current is ServiceError ||
                        current is ServiceSuccess ||
                        current is CountryCategoryLoading ||
                        current is CountryCategoryError ||
                        current is CountryCategorySuccess) return true;
                    return false;
                  },
                  listener: (context, state) {
                    if (state is ServiceLoading) {
                      UIUtils.showLoading(context);
                    } else if (state is ServiceError) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    } else if (state is ServiceSuccess) {
                      UIUtils.hideLoading(context);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FilterResultScreen(
                            services: state.services,
                          );
                        },
                      ));
                    }
                  },
                  bloc: _serviceCubit,
                  builder: (context, state) {
                    if (state is CountryCategoryLoading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child:
                              LoadingIndicator(Theme.of(context).primaryColor),
                        ),
                      );
                    } else if (state is CountryCategoryError) {
                      return Center(
                        child: Text(state.message,
                            style: Theme.of(context).textTheme.bodySmall),
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                icon: Icons.search,
                                controller: _serviceCubit.searchController,
                                hintText: 'service or provider name',
                                padding: 20.w,
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              BlocBuilder<ServiceCubit, ServiceStates>(
                                bloc: _serviceCubit,
                                buildWhen: (previous, current) {
                                  if (current is IsCurrentLocation ||
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
                                        localization.chooseCountry,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontSize: 36.sp),
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField<
                                                Countries>(
                                              dropdownColor: Theme.of(context)
                                                  .primaryColorDark,
                                              hint: Text(localization.country,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              menuMaxHeight: 200,
                                              decoration: const InputDecoration(
                                                  errorBorder:
                                                      InputBorder.none),
                                              value:
                                                  _serviceCubit.selectedCountry,
                                              items: _serviceCubit
                                                  .countriesList!
                                                  .map((e) => DropdownMenuItem<
                                                          Countries>(
                                                        value: e,
                                                        child: Text(
                                                          e.name,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                _serviceCubit.selectedDistance =
                                                    null;
                                                _serviceCubit.isCity = false;
                                                _serviceCubit.isCurrent = false;
                                                _serviceCubit.selectedCity =
                                                    null; // Reset the selected city
                                                _serviceCubit.citiesList
                                                    ?.clear(); // Clear the cities list
                                                _serviceCubit
                                                    .selectedCountryService(
                                                        value!); // Update with the new country
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _serviceCubit.selectedCountryId != null &&
                                              _serviceCubit.selectedCountryId !=
                                                  -1
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 30.h),
                                                Text(
                                                  localization.chooseCity,
                                                  textAlign: TextAlign.start,
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
                                                          DropdownButtonFormField<
                                                              Cities>(
                                                        dropdownColor: Theme.of(
                                                                context)
                                                            .primaryColorDark,
                                                        hint: Text(
                                                            _serviceCubit
                                                                .addAllCities
                                                                .name,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium),
                                                        value: _serviceCubit
                                                            .selectedCity,
                                                        menuMaxHeight: 200,
                                                        decoration:
                                                            const InputDecoration(
                                                                errorBorder:
                                                                    InputBorder
                                                                        .none),
                                                        items: _serviceCubit
                                                            .citiesList
                                                            ?.map((e) =>
                                                                DropdownMenuItem<
                                                                    Cities>(
                                                                  value: e,
                                                                  child: Text(
                                                                    e.name,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                ))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          _serviceCubit.isCity =
                                                              true;

                                                          _serviceCubit
                                                              .selectedCityService(
                                                                  value!);
                                                        },
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
                              Row(
                                children: [
                                  BlocBuilder<ServiceCubit, ServiceStates>(
                                      bloc: _serviceCubit,
                                      buildWhen: (previous, current) {
                                        if (current
                                                is SelectedCountryCityServiceState ||
                                            current is IsCurrentLocation) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      builder: (context, state) {
                                        return Checkbox(
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            value: _serviceCubit.isCurrent,
                                            onChanged: (value) {
                                              _serviceCubit
                                                  .chooseCurrentLocation(
                                                      value!);
                                              _serviceCubit.selectedDistance =
                                                  10;
                                              _serviceCubit.isCity = true;

                                              _serviceCubit
                                                  .selectedCountryName = null;
                                              _serviceCubit.selectedCountryId =
                                                  null;
                                              _serviceCubit.selectedCountry =
                                                  null;
                                              _serviceCubit.selectedCityName =
                                                  null;
                                              _serviceCubit.selectedCityId =
                                                  null;
                                            });
                                      }),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    localization.currentLocation,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  )
                                ],
                              ),
                              SizedBox(height: 30.h),
                              AnimatedSize(
                                alignment: Alignment.topCenter,
                                duration: const Duration(milliseconds: 500),
                                child: BlocBuilder<ServiceCubit, ServiceStates>(
                                  bloc: _serviceCubit,
                                  buildWhen: (previous, current) {
                                    if (current is DistanceSelectUpdate ||
                                        // current
                                        //     is GetCurrentLocationFilterSuccess ||
                                        current is IsCurrentLocation ||
                                        current
                                            is SelectedCountryCityServiceState)
                                      return true;
                                    return false;
                                  },
                                  builder: (context, state) {
                                    return (_serviceCubit.isCurrent != false &&
                                            _serviceCubit.selectedCountryId ==
                                                null)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(localization.distance,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Slider(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                inactiveColor:
                                                    _drawerCubit.themeMode ==
                                                            ThemeMode.dark
                                                        ? Theme.of(context)
                                                            .primaryColorLight
                                                        : Colors.grey.shade300,
                                                value: _serviceCubit
                                                    .selectedDistance!,
                                                min: 0,
                                                max: 25,
                                                divisions: 5,
                                                label:
                                                    "${_serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                                                onChanged: (value) {
                                                  _serviceCubit
                                                      .distanceSelect(value);
                                                },
                                              ),
                                              Text(
                                                  "${_serviceCubit.selectedDistance?.toInt() ?? 10} ${localization.km}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              SizedBox(height: 16.h),
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
                              BlocBuilder<ServiceCubit, ServiceStates>(
                                bloc: _serviceCubit,
                                buildWhen: (previous, current) {
                                  if (current is SelectedCategoryServiceState)
                                    return true;
                                  else
                                    return false;
                                },
                                builder: (context, state) {
                                  return CascadingDropdowns(categories: _serviceCubit.categoriesList,);
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  child: InkWell(
                                      onTap: () {
                                        _serviceCubit.resetSetting();
                                      },
                                      child: Text(localization.resetAll,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color:
                                                      ColorManager.primary))),
                                ),
                              ),
                              SizedBox(height: 60.h),
                              ElevatedButton(
                                onPressed: () {
                                  if ((_serviceCubit.selectedCountryId ==
                                              null ||
                                          _serviceCubit.selectedCountryId ==
                                              -1) &&
                                      _serviceCubit.isCurrent == false &&
                                      (_serviceCubit.selectedCategory == null ||
                                          _serviceCubit.selectedCategory?.id ==
                                              -1)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'Filter on Location or Category',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white),
                                      )),
                                    );
                                    return;
                                  }
                                  _serviceCubit.getServices(GetServicesRequest(
                                      categoryId: _serviceCubit.selectedCategory?.id !=
                                              null
                                          ? _serviceCubit.selectedSubCategory?.id ==
                                                  null
                                              ? _serviceCubit.selectedCategory?.id ==
                                                      -1
                                                  ? null
                                                  : _serviceCubit
                                                      .selectedCategory!.id
                                              : _serviceCubit
                                                          .selectedSubCategory
                                                          ?.id ==
                                                      -1
                                                  ? null
                                                  : _serviceCubit
                                                      .selectedSubCategory!.id
                                          : null,
                                      cityId: _serviceCubit.selectedCityId == -1
                                          ? null
                                          : _serviceCubit.selectedCityId,
                                      countryId:
                                          _serviceCubit.selectedCountryId == -1
                                              ? null
                                              : _serviceCubit.selectedCountryId,
                                      latitude: _serviceCubit
                                          .getCurrentLocation?.latitude,
                                      longitude: _serviceCubit
                                          .getCurrentLocation?.longitude,
                                      radius: _serviceCubit.isCurrent == true
                                          ? _serviceCubit.selectedDistance
                                              ?.toInt()
                                          : null,
                                      search: _serviceCubit
                                              .searchController.text.isEmpty
                                          ? null
                                          : _serviceCubit.searchController.text));
                                  print(
                                      'the value of distance is ${_serviceCubit.searchController.text}');
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text(localization.startSearch,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          ));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
