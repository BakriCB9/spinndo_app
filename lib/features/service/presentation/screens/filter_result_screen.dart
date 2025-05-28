import 'package:app/core/resources/color_manager.dart';
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
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/services.dart';
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
              color: ColorManager.darkBg,
            )
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Column(
                  children: [
                    SectionHeaderResultFilter(
                      serviceSettingCubit: serviceSettingCubit,
                      isNotEmpty: list.data!.isNotEmpty,
                    ),

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
                                          name: listOfitem[index].providerName!,
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
