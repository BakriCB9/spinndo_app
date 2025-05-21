import 'package:app/core/widgets/custom_appbar.dart';
import 'package:app/features/favorite/presentation/view/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';

import 'package:app/core/utils/map_helper/geocoding_service.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/core/widgets/cash_network.dart';
import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/google_map_marker.dart';
import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/screens/service_map_screen.dart';
import 'package:app/features/service/presentation/screens/show_details.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class FilterResultScreen extends StatefulWidget {
  final List<Services> services;

  FilterResultScreen({super.key, required this.services});

  static const String routeName = '/filterResult';

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

final _serviceCubit = serviceLocator.get<ServiceCubit>();
final _drawerCubit = serviceLocator.get<DrawerCubit>();
final _authCubit = serviceLocator.get<AuthCubit>();
bool sortByName = false;
bool sortByDistance = false;
bool sortByNumberOfvisitor = false;

class _FilterResultScreenState extends State<FilterResultScreen> {
  late Size size;
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    print('the location of country is ${_serviceCubit.selectedCountryId}');
    print('the selected country name ${_serviceCubit.selectedCountryName}');
    print('the selected city name  is ${_serviceCubit.selectedCityName}');
    if (_serviceCubit.selectedCityName == 'All Cities') {
      _serviceCubit.selectedCityName = null;
      _serviceCubit.isCity = false;
    }

    final theme = Theme.of(context).textTheme;
    markerLocationData.clear();
    final localization = AppLocalizations.of(context)!;

    markerLocationData.add(GoogleMapMarker(BitmapDescriptor.hueGreen,
        id: -1,
        providerId: sharedPref.getInt(CacheConstant.userId),
        name: "Current Location",
        latLng: LatLng(_serviceCubit.getCurrentLocation!.latitude!,
            _serviceCubit.getCurrentLocation!.longitude!)));

    return Container(
      decoration:  _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
          color: ColorManager.darkBg
      ): null,
      child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  CustomAppbar(appBarText: localization.filterResults),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // ShowDiscount(),

                  widget.services.length == 0
                      ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: size.height / 3.5,
                          child: Lottie.asset(
                            'asset/animation/empty.json',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          localization.noServicesFoundedinlocation,
                          style: TextStyle(fontSize: 30.sp),
                        ),
                        const Spacer(flex: 2)
                      ],
                    ),
                  )
                      : Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.all(16.w),
                        itemCount: widget.services.length,
                        itemBuilder: (context, index) {
                          markerLocationData.add(GoogleMapMarker(
                            providerId: widget.services[index].providerId!,
                            BitmapDescriptor.hueRed,
                            id: widget.services[index].id!,
                            name: widget.services[index].name!,
                            latLng: LatLng(
                              double.parse(widget.services[index].latitude!),
                              double.parse(widget.services[index].longitude!),
                            ),
                          ));

                          final service = widget.services[index];

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 200),
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(milliseconds: 3000),
                                child: GestureDetector(
                                  onTap: () {
                                    if (sharedPref.getString(
                                        CacheConstant.tokenKey) ==
                                        null) {
                                      UIUtils.showMessage(
                                          "You have to Sign in first");
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ShowDetails(
                                            id: service.providerId!),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          service.providerImage != null
                                              ? CircleAvatar(
                                            radius: 60.r,
                                            // backgroundImage:
                                            //     NetworkImage(service.providerImage!),
                                            child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(60.r),
                                                child: CashImage(
                                                  path: service
                                                      .providerImage,
                                                )),
                                          )
                                              : CircleAvatar(
                                            radius: 60.r,
                                            backgroundColor:
                                            ColorManager.primary,
                                            child: Icon(Icons.person,
                                                size: 60.r,
                                                color:
                                                ColorManager.white),
                                          ),
                                          SizedBox(width: 20.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        service.name ??
                                                            "Service Name",
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                            color: Theme.of(
                                                                context)
                                                                .primaryColorLight),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                            children: [
                                                              CircleAvatar(
                                                                radius: 12.r,
                                                                backgroundColor:
                                                                ColorManager
                                                                    .primary,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              Text(
                                                                service.distance !=
                                                                    null
                                                                    ? '${service.distance!.toStringAsFixed(2)} ${localization.km}'
                                                                    : '',
                                                                style: Theme.of(
                                                                    context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                    color: Theme.of(
                                                                        context)
                                                                        .primaryColorLight),
                                                                textAlign:
                                                                TextAlign.end,
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  "${localization.provider}: ${service.providerName ?? "Unknown"}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                      fontSize: 24.sp),
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  "${localization.description} : ${service.description}" ??
                                                      "No description available",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                      fontSize: 24.sp),
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 8.h),
                                                Row(
                                                  children: [
                                                    Icon(Icons.category,
                                                        size: 34.r,
                                                        color: ColorManager
                                                            .primary),
                                                    SizedBox(width: 10.w),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        service.categoryName ??
                                                            "Category",
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .labelMedium!
                                                            .copyWith(
                                                            fontSize:
                                                            24.sp,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis),
                                                      ),
                                                    ),
                                                    //     Align(
                                                    //   alignment:
                                                    //       Alignment.bottomLeft,
                                                    //   child: FavoriteWidget(),
                                                    // )

                                                    Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .visibility_outlined),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child:
                                                              FittedBox(
                                                                alignment: Directionality.of(
                                                                    context) ==
                                                                    TextDirection
                                                                        .rtl
                                                                    ? Alignment
                                                                    .centerRight
                                                                    : Alignment
                                                                    .centerLeft,
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                    '${service.numberOfvisitors == null ? "0" : service.numberOfvisitors}',
                                                                    style: theme
                                                                        .labelMedium!
                                                                        .copyWith(
                                                                        fontSize: 24.sp)),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    FavoriteWidget(
                                                      userId: service
                                                          .providerId
                                                          .toString(),
                                                    ),
                                                    //Icon(Icons.visibility_outlined)
                                                  ],
                                                ),
                                                //SizedBox(height: 10.h),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
