import 'package:app/core/utils/error_network_widget.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/google_map/domain/entity/marker_location.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';
import 'package:app/features/service/presentation/widgets/section_header_result_filter.dart';
import 'package:app/features/service/presentation/widgets/section_item_of_service.dart';
import 'package:app/features/service/presentation/widgets/show_discount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';

import 'package:app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/google_map_marker.dart';
import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/presentation/cubit/service_cubit.dart';
import 'package:app/features/service/presentation/screens/service_map_screen.dart';
import 'package:app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class FilterResultScreen extends StatefulWidget {
  FilterResultScreen({
    super.key,
  });

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

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
    final serviceSettingCubit = BlocProvider.of<ServiceSettingCubit>(context);
    // print('the location of country is ${_serviceCubit.selectedCountryId}');
    // print('the selected country name ${_serviceCubit.selectedCountry?.name}');
    // print('the selected city name  is ${_serviceCubit.selectedCity?.name}');
    // if (_serviceCubit.selectedCity?.name == 'All Cities') {
    // _serviceCubit.selectedCity!.name = null;
    //  _serviceCubit.isCity = false;
    //}

    markerLocationData.clear();
    final localization = AppLocalizations.of(context)!;

    markerLocationData.add(GoogleMapMarker(BitmapDescriptor.hueGreen,
        id: -1,
        providerId: sharedPref.getInt(CacheConstant.userId),
        name: "Current Location",
        latLng: LatLng(serviceSettingCubit.getCurrentLocation!.latitude!,
            serviceSettingCubit.getCurrentLocation!.longitude!)));

    return Container(
      decoration: _drawerCubit.themeMode == ThemeMode.dark
          ? const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/images/bg.png"), fit: BoxFit.fill))
          : null,
      child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<ServiceSettingCubit, ServiceSettingState>(
              bloc: serviceSettingCubit,
              builder: (context, state) {
                if (state.getAllServiceState is BaseLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.getAllServiceState is BaseErrorState) {
                  final message = state.getAllServiceState as BaseErrorState;
                  return ErrorNetworkWidget(
                    message: message.error.toString(),
                    onTap: () => serviceSettingCubit.getServiceAndDiscount(),
                  );
                } else if (state.getAllServiceState is BaseSuccessState) {
                  final list = (state.getAllServiceState
                  as BaseSuccessState<List<Services>>);

                  ValueNotifier<List<Services>?> listOfService =
                  ValueNotifier(list.data);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        SectionHeaderResultFilter(services: listOfService),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     InkWell(
                        //         onTap: () {
                        //           Navigator.of(context).pop();
                        //         },
                        //         child: Icon(
                        //           Icons.arrow_back_sharp,
                        //           color: Theme.of(context).primaryColorLight,
                        //           size: 45.sp,
                        //         )),
                        //     SizedBox(width: 40.w),
                        //     Expanded(
                        //       child: FittedBox(
                        //         fit: BoxFit.scaleDown,
                        //         alignment:
                        //             Directionality.of(context) == TextDirection.rtl
                        //                 ? Alignment.centerRight
                        //                 : Alignment.centerLeft,
                        //         child: Text(
                        //           localization.filterResults,
                        //           style: Theme.of(context).textTheme.titleLarge,
                        //         ),
                        //       ),
                        //     ),
                        //     //google map
                        //     IconButton(
                        //       onPressed: () async {

                        //         _serviceCubit.filterLocation =
                        //             await (_serviceCubit.selectedCountry?.id != -1
                        //                 ? GeocodingService.getCountryLatLng(
                        //                     _serviceCubit.selectedCity?.name ??
                        //                         _serviceCubit.selectedCountry!.name)
                        //                 : LatLng(
                        //                     _serviceCubit
                        //                         .getCurrentLocation!.latitude!,
                        //                     _serviceCubit
                        //                         .getCurrentLocation!.longitude!));

                        // _serviceCubit.filterBounds =
                        //     _serviceCubit.selectedCountryId != -1
                        //         ? await (GeocodingService.getCountryBounds(
                        //             _serviceCubit.selectedCityName ??
                        //                 _serviceCubit.selectedCountryName!))
                        //         : null;

                        // await (_serviceCubit.selectedCountryId != -1
                        //     ? GeocodingService.getCountryBounds(
                        //         _serviceCubit.selectedCityName ??
                        //             _serviceCubit.selectedCountryName!)
                        //     : GeocodingService.getCurrentLocationBounds(
                        //         _serviceCubit.getCurrentLocation!.latitude!,
                        //         _serviceCubit
                        //             .getCurrentLocation!.longitude!));

                        //         _authCubit.loadMapStyle(
                        //             _drawerCubit.themeMode == ThemeMode.dark
                        //                 ? true
                        //                 : false);

                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => const ServiceMapScreen(),
                        //         ));
                        //       },
                        //       icon: Icon(
                        //         Icons.map,
                        //         color: Theme.of(context).primaryColorLight,
                        //         size: 45.sp,
                        //       ),
                        //     ),

                        //                     },
                        //                   ),
                        //                 ])
                        //         : const SizedBox(),
                        //   ],
                        // ),

                        SizedBox(height: 20.h),

                        //Discount widget
                        ShowDiscount(),

                        //Card item of Service
                        listOfService.value!.isEmpty
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
                          child: ValueListenableBuilder(
                              valueListenable: listOfService,
                              builder: (context, listOfitem, _) {
                                return AnimationLimiter(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                        AlwaysScrollableScrollPhysics()),
                                    padding: EdgeInsets.all(16.w),
                                    itemCount: listOfitem!.length,
                                    itemBuilder: (context, index) {
                                      markerLocationData.add(GoogleMapMarker(
                                        providerId:
                                        listOfitem[index].providerId!,
                                        BitmapDescriptor.hueRed,
                                        id: listOfitem[index].id!,
                                        name: listOfitem[index].name!,
                                        latLng: LatLng(
                                          double.parse(
                                              listOfitem[index].latitude!),
                                          double.parse(
                                              listOfitem[index].longitude!),
                                        ),
                                      ));

                                      final service = listOfitem[index];
                                      return SectionItemOfService(
                                          index: index, service: service);
                                    },
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          )),
    );
  }
}