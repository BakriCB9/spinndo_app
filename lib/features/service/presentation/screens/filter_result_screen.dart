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

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    markerLocationData.clear();
    final localization = AppLocalizations.of(context)!;

    markerLocationData.add(GoogleMapMarker(BitmapDescriptor.hueGreen,
        id: -1,
        providerId: sharedPref.getInt(CacheConstant.userId),
        name: "Current Location",
        latLng: LatLng(_serviceCubit.getCurrentLocation!.latitude!,
            _serviceCubit.getCurrentLocation!.longitude!)));

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
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
                      localization.filterResults,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      _serviceCubit.filterLocation =
                          await (_serviceCubit.selectedCountryName != null
                              ? GeocodingService.getCountryLatLng(
                                  _serviceCubit.selectedCityName ??
                                      _serviceCubit.selectedCountryName!)
                              : LatLng(
                                  _serviceCubit.getCurrentLocation!.latitude!,
                                  _serviceCubit
                                      .getCurrentLocation!.longitude!));

                      _serviceCubit.filterBounds =
                          await (_serviceCubit.selectedCountryName != null
                              ? GeocodingService.getCountryBounds(
                                  _serviceCubit.selectedCityName ??
                                      _serviceCubit.selectedCountryName!)
                              : GeocodingService.getCurrentLocationBounds(
                                  _serviceCubit.getCurrentLocation!.latitude!,
                                  _serviceCubit
                                      .getCurrentLocation!.longitude!));

                      _authCubit.loadMapStyle(
                          _drawerCubit.themeMode == ThemeMode.dark
                              ? true
                              : false);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ServiceMapScreen(),
                      ));
                    },
                    icon: Icon(
                      Icons.map,
                      color: Theme.of(context).primaryColorLight,
                      size: 45.sp,
                    ),
                  ),
                  widget.services.isNotEmpty
                      ? PopupMenuButton(
                          icon: Icon(
                              sortByName
                                  ? Icons.sort_by_alpha_sharp
                                  : sortByDistance
                                      ? Icons.social_distance_sharp
                                      : Icons.sort_sharp,
                              color: Theme.of(context).primaryColorLight,
                              size: 45.sp),
                          color: Theme.of(context).primaryColorDark,
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  height: 60.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        localization.sortByName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 22.sp),
                                      ),
                                      sortByName
                                          ? Container(
                                              width: 20.w,
                                              height: 20.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorManager.primary),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  onTap: () {
                                    widget.services.sort(
                                      (a, b) => a.name!.compareTo(b.name!),
                                    );
                                    sortByName = true;
                                    sortByDistance = false;

                                    setState(() {});
                                  },
                                ),
                                PopupMenuItem(
                                  height: 60.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        localization.sortByDistance,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                                fontSize: 22.sp),
                                      ),
                                      sortByDistance
                                          ? Container(
                                              width: 20.w,
                                              height: 20.h,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorManager.primary,
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  onTap: () {
                                    widget.services.sort(
                                      (a, b) =>
                                          a.distance!.compareTo(b.distance!),
                                    );
                                    sortByName = false;
                                    sortByDistance = true;
                                    setState(() {});
                                  },
                                )
                              ])
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              widget.services.length == 0
                  ? Expanded(
                      child: Center(
                        child: Text(
                          localization.noServicesFoundedinlocation,
                          style: TextStyle(fontSize: 30.sp),
                        ),
                      ),
                    )
                  : Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(
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
                              delay: Duration(milliseconds: 200),
                              child: SlideAnimation(
                                duration: Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: Duration(milliseconds: 3000),
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
                                                      FavoriteWidget()
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
