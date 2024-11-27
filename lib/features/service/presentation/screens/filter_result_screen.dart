import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/di/service_locator.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/core/resources/font_manager.dart';
import 'package:snipp/core/utils/map_helper/geocoding_service.dart';
import 'package:snipp/core/utils/ui_utils.dart';
import 'package:snipp/core/widgets/cash_network.dart';
import 'package:snipp/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:snipp/features/service/domain/entities/google_map_marker.dart';
import 'package:snipp/features/service/domain/entities/services.dart';
import 'package:snipp/features/service/presentation/cubit/service_cubit.dart';
import 'package:snipp/features/service/presentation/screens/service_map_screen.dart';
import 'package:snipp/features/service/presentation/screens/show_details.dart';
import 'package:snipp/main.dart';

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

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Filter Results',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Switch(
              activeColor: ColorManager.primary,
              inactiveTrackColor: ColorManager.white,
              inactiveThumbColor: Theme.of(context).primaryColor,
              activeTrackColor: Theme.of(context).primaryColor,
              value: _drawerCubit.themeMode == ThemeMode.dark,
              onChanged: (value) {
                if (value) {
                  _drawerCubit.changeTheme(ThemeMode.dark);
                } else {
                  _drawerCubit.changeTheme(ThemeMode.light);
                }
              },
            ),
            IconButton(
              onPressed: () async {
                _serviceCubit.filterLocation =
                    await (_serviceCubit.getCurrentLocation == null
                        ? GeocodingService.getCountryLatLng(
                            _serviceCubit.selectedCityName ??
                                _serviceCubit.selectedCountryName!)
                        : LatLng(_serviceCubit.getCurrentLocation!.latitude!,
                            _serviceCubit.getCurrentLocation!.longitude!));
                _authCubit.loadMapStyle(
                    _drawerCubit.themeMode == ThemeMode.dark ? true : false);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ServiceMapScreen(),
                ));
              },
              icon: Icon(Icons.map, color: Theme.of(context).primaryColorLight),
            ),
          ],
          elevation: 0,
        ),
        body: widget.services.length == 0
            ? Center(
                child: Text(
                  'No Services Founded in location',
                  style: TextStyle(fontSize: 30.sp),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  markerLocationData.add(GoogleMapMarker(
                    id: widget.services[index].id!,
                    name: widget.services[index].name!,
                    latLng: LatLng(
                      double.parse(widget.services[index].latitude!),
                      double.parse(widget.services[index].longitude!),
                    ),
                  ));

                  final service = widget.services[index];

                  return GestureDetector(
                    onTap: () {
                      if (sharedPref.getString(CacheConstant.tokenKey) ==
                          null) {
                        UIUtils.showMessage("You have to Sign in first");
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowDetails(id: service.providerId!),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            service.providerImage != null
                                ? CircleAvatar(
                                    radius: 60.r,
                                    backgroundImage:
                                        NetworkImage(service.providerImage!),
                                  )
                                : CircleAvatar(
                                    radius: 60.r,
                                    backgroundColor: ColorManager.primary,
                                    child: Icon(Icons.person,
                                        size: 60.r, color: ColorManager.white),
                                  ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name ?? "Service Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Provider: ${service.providerName ?? "Unknown"}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontSize: 24.sp),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "description : ${service.description}" ??
                                        "No description available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontSize: 24.sp),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(Icons.category,
                                          size: 34.r,
                                          color: ColorManager.primary),
                                      SizedBox(width: 10.w),
                                      Text(
                                        service.categoryName ?? "Category",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(fontSize: 24.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
