import 'package:app/core/widgets/custom_text_form_field.dart';
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

class ServiceScreen extends StatefulWidget {
  static const String routeName = '/service';

  const ServiceScreen({super.key});

  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _serviceCubit = serviceLocator.get<ServiceCubit>();
  final _drawerCubit = serviceLocator.get<DrawerCubit>();

  @override
  void initState() {
    _serviceCubit.getCountriesAndCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _drawerCubit = serviceLocator.get<DrawerCubit>();
    double _distance = _serviceCubit.selectedDistance ?? 10.0;
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
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
                    final String? token =
                        sharedPref.getString(CacheConstant.tokenKey);

                    if (token == null) {
                      UIUtils.showMessage("You have to Sign in first");
                    } else {
                      // Open the drawer
                      Scaffold.of(context).openDrawer();
                    }
                  },
                );
              },
            ),
            actions: [
              // IconButton(
              //   icon: Icon(
              //     Icons.arrow_back,
              //     size: 1.sp,
              //   ),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              // ),

              // Transform.scale(
              //   scale: 0.8,
              //   child: Switch(
              //     activeColor: ColorManager.primary,
              //     inactiveTrackColor: ColorManager.white,
              //     inactiveThumbColor: Theme.of(context).primaryColor,
              //     activeTrackColor: Theme.of(context).primaryColor,
              //     value: _drawerCubit.themeMode == ThemeMode.dark,
              //     onChanged: (value) {
              //       if (value) {
              //         _drawerCubit.changeTheme(ThemeMode.dark);
              //       } else {
              //         _drawerCubit.changeTheme(ThemeMode.light);
              //       }
              //     },
              //   ),
              // ),
            ],
            title: Text(
              'Search Settings',
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
                    } else if (state is CountryCategorySuccess ||
                        state is GetCurrentLocationFilterSuccess ||
                        state is SelectedCountryCityServiceState ||
                        state is ServiceSuccess ||
                        state is ServiceLoading ||
                        state is ServiceInitial ||
                        state is ServiceError) {
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                        'Choose Country',
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
                                              hint: Text("Country",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              menuMaxHeight: 200,
                                              decoration: const InputDecoration(
                                                  errorBorder:
                                                      InputBorder.none),
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
                                                _serviceCubit.isCurrent = false;

                                                _serviceCubit
                                                    .selectedCountryService(
                                                        value!);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          _serviceCubit.selectedCountryId !=
                                                  null
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 50.sp,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                      _serviceCubit.selectedCountryId != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 30.h),
                                                Text(
                                                  'Choose City',
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
                                                        hint: Text("City",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium),
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
                                                          _serviceCubit
                                                              .selectedCityService(
                                                                  value!);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    _serviceCubit
                                                                .selectedCityId !=
                                                            null
                                                        ? Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 50.sp,
                                                          )
                                                        : const SizedBox()
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
                                              _serviceCubit
                                                  .selectedCountryName = null;
                                              _serviceCubit.selectedCountryId =
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
                                    'Current Location',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  )
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     ElevatedButton(
                              //       onPressed: () {
                              //         _serviceCubit.getCurrentLocationFilter();
                              //         _serviceCubit.selectedCountryName = null;
                              //         _serviceCubit.selectedCountryId = null;
                              //         _serviceCubit.selectedCityName = null;
                              //         _serviceCubit.selectedCityId = null;
                              //         _serviceCubit.selectedDistance = 10;
                              //       },
                              //       child: BlocBuilder<ServiceCubit,
                              //           ServiceStates>(
                              //         bloc: _serviceCubit,
                              //         buildWhen: (previous, current) {
                              //           if (current is GetCurrentLocationFilterLoading ||
                              //               current
                              //                   is GetCurrentLocationFilterErrorr ||
                              //               current
                              //                   is GetCurrentLocationFilterSuccess ||
                              //               current
                              //                   is SelectedCountryCityServiceState)
                              //             return true;
                              //           return false;
                              //         },
                              //         builder: (context, state) {
                              //           if (state
                              //               is GetCurrentLocationFilterLoading) {
                              //             return SizedBox(
                              //                 width: 300.w,
                              //                 child: LoadingIndicator(
                              //                     Colors.white));
                              //           } else if (state
                              //               is GetCurrentLocationFilterErrorr) {
                              //             return Text(
                              //               state.message,
                              //               style: Theme.of(context)
                              //                   .textTheme
                              //                   .bodySmall,
                              //             );
                              //           } else if (state
                              //               is GetCurrentLocationFilterSuccess) {
                              //             return Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: 20.0.w),
                              //               child: Text(
                              //                 "current Location",
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .bodyLarge,
                              //               ),
                              //             );
                              //           } else {
                              //             return Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: 20.0.w),
                              //               child: Text("current Location",
                              //                   style: Theme.of(context)
                              //                       .textTheme
                              //                       .bodyLarge),
                              //             );
                              //           }
                              //         },
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10.w,
                              //     ),
                              //     BlocBuilder<ServiceCubit, ServiceStates>(
                              //       bloc: _serviceCubit,
                              //       builder: (context, state) {
                              //         return _serviceCubit.isUpdat == true
                              //             ? Icon(
                              //                 Icons.check,
                              //                 color: Colors.green,
                              //                 size: 50.sp,
                              //               )
                              //             : SizedBox();
                              //       },
                              //     )
                              //   ],
                              // ),
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
                                              Text("Distance",
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
                                                    "${_serviceCubit.selectedDistance?.toInt() ?? 10} km",
                                                onChanged: (value) {
                                                  _serviceCubit
                                                      .distanceSelect(value);
                                                },
                                              ),
                                              Text(
                                                  "${_serviceCubit.selectedDistance?.toInt() ?? 10} km",
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
                                'Choose Category',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 36.sp),
                              ),
                              SizedBox(height: 8),
                              BlocBuilder<ServiceCubit, ServiceStates>(
                                bloc: _serviceCubit,
                                buildWhen: (previous, current) {
                                  if (current is SelectedCategoryServiceState)
                                    return true;
                                  else
                                    return false;
                                },
                                builder: (context, state) {
                                  return DropdownButtonFormField<Categories>(
                                    dropdownColor:
                                        Theme.of(context).primaryColorDark,
                                    hint: Text("Cateory",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                    menuMaxHeight: 200,
                                    decoration: const InputDecoration(
                                        errorBorder: InputBorder.none),
                                    items: _serviceCubit.categoriesList!
                                        .map(
                                            (e) => DropdownMenuItem<Categories>(
                                                  value: e,
                                                  child: Text(e.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium),
                                                ))
                                        .toList(),
                                    onChanged: (value) {
                                      _serviceCubit
                                          .selectedCategoryService(value!);
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                'Search by useing service or provider name',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 36.sp),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomTextFormField(
                                controller: _serviceCubit.searchController,
                                hintText: 'service or provider name',
                                padding: 20.w,
                              ),
                              SizedBox(height: 80.h),
                              ElevatedButton(
                                onPressed: () {
                                  if (_serviceCubit.selectedCountryName ==
                                          null &&
                                      _serviceCubit.getCurrentLocation ==
                                          null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'choose country or your current location',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white),
                                      )),
                                    );
                                    return;
                                  }
                                  _serviceCubit.getServices(GetServicesRequest(
                                      categoryId:
                                          _serviceCubit.selectedCategoryId,
                                      cityId: _serviceCubit.selectedCityId,
                                      countryId:
                                          _serviceCubit.selectedCountryId,
                                      latitude: _serviceCubit
                                          .getCurrentLocation?.latitude,
                                      longitude: _serviceCubit
                                          .getCurrentLocation?.longitude,
                                      radius: _serviceCubit.selectedDistance
                                          ?.toInt(),
                                      search: _serviceCubit
                                              .searchController.text.isEmpty
                                          ? null
                                          : _serviceCubit
                                              .searchController.text));
                                  print(
                                      'the value of distance is ${_serviceCubit.selectedDistance}');
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text("Start Search",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          ));
                    } else {
                      print("dddddddddddddddddddddddddddddd");
                      print(state);
                      return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<ServiceCubit, ServiceStates>(
                                bloc: _serviceCubit,
                                buildWhen: (previous, current) {
                                  if (current
                                          is GetCurrentLocationFilterSuccess ||
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
                                        'Choose Country',
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
                                              hint: Text("Country",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              menuMaxHeight: 200,
                                              decoration: const InputDecoration(
                                                  errorBorder:
                                                      InputBorder.none),
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
                                                _serviceCubit
                                                    .getCurrentLocation = null;
                                                _serviceCubit
                                                    .selectedCountryService(
                                                        value!);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          _serviceCubit.selectedCountryId !=
                                                  null
                                              ? Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 50.sp,
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                      _serviceCubit.selectedCountryId != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 30.h),
                                                Text(
                                                  'Choose City',
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
                                                        hint: Text("City",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium),
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
                                                          _serviceCubit
                                                                  .getCurrentLocation =
                                                              null;

                                                          _serviceCubit
                                                              .selectedCityService(
                                                                  value!);
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    _serviceCubit
                                                                .selectedCityId !=
                                                            null
                                                        ? Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 50.sp,
                                                          )
                                                        : const SizedBox()
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
                                  ElevatedButton(
                                    onPressed: () {
                                      _serviceCubit.getCurrentLocationFilter();
                                      _serviceCubit.selectedCountryName = null;
                                      _serviceCubit.selectedCountryId = null;
                                      _serviceCubit.selectedCityName = null;
                                      _serviceCubit.selectedCityId = null;
                                    },
                                    child: BlocBuilder<ServiceCubit,
                                        ServiceStates>(
                                      bloc: _serviceCubit,
                                      buildWhen: (previous, current) {
                                        if (current is GetCurrentLocationFilterLoading ||
                                            current
                                                is GetCurrentLocationFilterErrorr ||
                                            current
                                                is GetCurrentLocationFilterSuccess ||
                                            current
                                                is SelectedCountryCityServiceState)
                                          return true;
                                        return false;
                                      },
                                      builder: (context, state) {
                                        if (state
                                            is GetCurrentLocationFilterLoading) {
                                          return SizedBox(
                                              width: 300.w,
                                              child: LoadingIndicator(
                                                  Colors.white));
                                        } else if (state
                                            is GetCurrentLocationFilterErrorr) {
                                          return Text(
                                            state.message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          );
                                        } else if (state
                                            is GetCurrentLocationFilterSuccess) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0.w),
                                            child: Text(
                                              "current Location",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0.w),
                                            child: Text("current Location",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  BlocBuilder<ServiceCubit, ServiceStates>(
                                    bloc: _serviceCubit,
                                    builder: (context, state) {
                                      return _serviceCubit.isUpdat == true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                              size: 50.sp,
                                            )
                                          : const SizedBox();
                                    },
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
                                        current
                                            is GetCurrentLocationFilterSuccess ||
                                        current
                                            is SelectedCountryCityServiceState) {
                                      return true;
                                    }
                                    return false;
                                  },
                                  builder: (context, state) {
                                    return (_serviceCubit.getCurrentLocation !=
                                                null &&
                                            _serviceCubit.selectedCountryId ==
                                                null)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Distance",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Slider(
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                inactiveColor: Colors.black,
                                                value: _serviceCubit
                                                        .selectedDistance ??
                                                    10,
                                                min: 0,
                                                max: 25,
                                                divisions: 5,
                                                label:
                                                    "${_serviceCubit.selectedDistance?.toInt() ?? 10} km",
                                                onChanged: (value) {
                                                  _serviceCubit
                                                      .distanceSelect(value);
                                                },
                                              ),
                                              Text(
                                                  "${_serviceCubit.selectedDistance?.toInt() ?? 10} km",
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
                              // Container(color: Colors.red,width: 200.w,height: 200.h,),
                              Text(
                                'Choose Category',
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
                                  return DropdownButtonFormField<Categories>(
                                    hint: Text("Cateory",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                    menuMaxHeight: 200,
                                    decoration: const InputDecoration(
                                        errorBorder: InputBorder.none),
                                    items: _serviceCubit.categoriesList!
                                        .map(
                                            (e) => DropdownMenuItem<Categories>(
                                                  value: e,
                                                  child: Text(e.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium),
                                                ))
                                        .toList(),
                                    onChanged: (value) {
                                      _serviceCubit
                                          .selectedCategoryService(value!);
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              // CustomTextFormField(controller: TextEditingController(),hintText: 'Enter your Service Name or Name of Provider',),
                              //TextFormField(decoration: InputDecoration(),),
                              // Text('Heloo bakri',style: TextStyle(fontSize: 30.sp,color: Colors.green),),

                              SizedBox(height: 30.h),
                              ElevatedButton(
                                onPressed: () {
                                  if (_serviceCubit.selectedCountryName ==
                                          null &&
                                      _serviceCubit.getCurrentLocation ==
                                          null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'choose country or your current location',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white),
                                      )),
                                    );
                                    return;
                                  }
                                  _serviceCubit.getServices(GetServicesRequest(
                                    categoryId:
                                        _serviceCubit.selectedCategoryId,
                                    cityId: _serviceCubit.selectedCityId,
                                    countryId: _serviceCubit.selectedCountryId,
                                    latitude: _serviceCubit
                                        .getCurrentLocation?.latitude,
                                    longitude: _serviceCubit
                                        .getCurrentLocation?.longitude,
                                    radius:
                                        _serviceCubit.selectedDistance?.toInt(),
                                    search: _serviceCubit.searchController.text,
                                  ));
                                  print(
                                      'the service is ${_serviceCubit.searchController}');
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text("Start Search",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),

                              //Container(width: 200.w,height: 200.h,color: Colors.red,)
                            ],
                          ));
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         'Choose Country',
                      //         style: Theme.of(context).textTheme.titleMedium,
                      //       ),
                      //       SizedBox(height: 8),
                      //       DropdownButtonFormField<Countries>(
                      //         hint: Text("Select Country"),
                      //         menuMaxHeight: 400,
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         items: _serviceCubit.countriesList!
                      //             .map((e) => DropdownMenuItem<Countries>(
                      //                   value: e,
                      //                   child: Text(e.name),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //
                      //             _serviceCubit.selectedCountryService(value!);
                      //
                      //         },
                      //       ),
                      //       SizedBox(height: 16),
                      //       Text(
                      //         'Choose City',
                      //         style: Theme.of(context).textTheme.titleMedium,
                      //       ),
                      //       SizedBox(height: 8),
                      //       DropdownButtonFormField<Cities>(
                      //         hint: Text("Select City"),
                      //         menuMaxHeight: 400,
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         items: _serviceCubit.citiesList
                      //             ?.map((e) => DropdownMenuItem<Cities>(
                      //                   enabled:
                      //                       _serviceCubit.selectedCountryId != null
                      //                           ? true
                      //                           : false,
                      //                   value: e,
                      //                   child: Text(e.name),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //         _serviceCubit.selectedCityService(value!);
                      //
                      //         },
                      //       ),
                      //       SizedBox(height: 16),
                      //       ElevatedButton(
                      //         onPressed: () async {
                      //           LocationData location =
                      //               await LocationService.getLocationData();
                      //           _serviceCubit.getCurrentLocation = location;
                      //           setState(() {});
                      //         },
                      //         child: Text("get current Location"),
                      //       ),
                      //       SizedBox(height: 16),
                      //       Text("Distance",
                      //           style: Theme.of(context).textTheme.headlineMedium),
                      //       SizedBox(height: 8),
                      //       _serviceCubit.getCurrentLocation != null
                      //           ? Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Slider(
                      //                   activeColor: Colors.blue,
                      //                   inactiveColor: Colors.grey.shade300,
                      //                   value: _distance,
                      //                   min: 0,
                      //                   max: 25,
                      //                   divisions: 5,
                      //                   label: "${_distance.toInt()}km",
                      //                   onChanged: (value) {
                      //                     setState(() {
                      //                       _distance = value;
                      //                       _serviceCubit.selectedDistance = value;
                      //                     });
                      //                   },
                      //                 ),
                      //                 Text("${_distance.toInt()}km"),
                      //                 SizedBox(height: 16),
                      //               ],
                      //             )
                      //           : SizedBox(),
                      //       SizedBox(height: 16),
                      //       Text(
                      //         'Choose Category',
                      //         style: Theme.of(context).textTheme.titleMedium,
                      //       ),
                      //       SizedBox(height: 8),
                      //       DropdownButtonFormField<Categories>(
                      //         hint: Text("Select Cateory"),
                      //         menuMaxHeight: 400,
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //         ),
                      //         items: _serviceCubit.categoriesList!
                      //             .map((e) => DropdownMenuItem<Categories>(
                      //                   value: e,
                      //                   child: Text(e.name),
                      //                 ))
                      //             .toList(),
                      //         onChanged: (value) {
                      //
                      //         _serviceCubit.selectedCategoryService(value!);
                      //         },
                      //       ),
                      //       SizedBox(height: 16),
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           _serviceCubit.getServices(GetServicesRequest(
                      //               categoryId: _serviceCubit.selectedCategoryId,
                      //               cityId: _serviceCubit.selectedCityId,
                      //               countryId: _serviceCubit.selectedCountryId,
                      //               latitude:
                      //                   _serviceCubit.getCurrentLocation?.latitude,
                      //               longitude:
                      //                   _serviceCubit.getCurrentLocation?.longitude,
                      //               radius: 25));
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           minimumSize: Size(double.infinity, 48),
                      //         ),
                      //         child: Text("Start Search"),
                      //       ),
                      //     ],
                      //   ));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
